# syntax=docker/dockerfile:1

ARG RUBY_VERSION=4.0.4
ARG NODE_MAJOR=22

FROM public.ecr.aws/docker/library/ruby:${RUBY_VERSION}-slim AS base

WORKDIR /rails

# ---------------------------------------------------------------------------
# Build stage
# ---------------------------------------------------------------------------

FROM base AS build

ARG NODE_MAJOR

ENV RAILS_ENV="production" \
    NODE_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development:test" \
    BUNDLE_JOBS="4" \
    BUNDLE_RETRY="3" \
    BUNDLE_BUILD__PUMA="--with-cflags='-D PUMA_QUERY_STRING_MAX_LENGTH=32000 -D PUMA_REQUEST_URI_MAX_LENGTH=32000'"

# Install packages required to build gems and frontend assets
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -yq \
      build-essential \
      ca-certificates \
      curl \
      git \
      gnupg \
      libpq-dev \
      libvips \
      libyaml-dev \
      pkg-config && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key \
      | gpg --dearmor -o /usr/share/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_MAJOR}.x nodistro main" \
      > /etc/apt/sources.list.d/nodesource.list && \
    apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -yq \
      nodejs && \
    npm install --global yarn@1.22.22 && \
    node --version && \
    npm --version && \
    yarn --version && \
    rm -rf /var/lib/apt/lists/*

# ---------------------------------------------------------------------------
# Ruby dependencies
# ---------------------------------------------------------------------------

COPY Gemfile Gemfile.lock ./

RUN --mount=type=cache,target=/usr/local/bundle/cache \
    bundle install && \
    rm -rf \
      ~/.bundle/ \
      "${BUNDLE_PATH}"/ruby/*/cache \
      "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git \
      /usr/local/bundle/cache/*.gem && \
    bundle exec bootsnap precompile --gemfile

# ---------------------------------------------------------------------------
# JavaScript dependencies
# ---------------------------------------------------------------------------

COPY package.json yarn.lock ./

RUN --mount=type=cache,target=/usr/local/share/.cache/yarn \
    yarn install --frozen-lockfile --production=false

# ---------------------------------------------------------------------------
# Application code
# ---------------------------------------------------------------------------

COPY . .

# Precompile Ruby application code
RUN bundle exec bootsnap precompile app/ lib/

# Build Bootstrap/Sass CSS and compile Rails assets
RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

# Frontend build dependencies are not needed at runtime
RUN rm -rf node_modules

# ---------------------------------------------------------------------------
# Runtime stage
# ---------------------------------------------------------------------------

FROM base AS final

ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development:test" \
    BUNDLE_JOBS="4" \
    BUNDLE_RETRY="3" \
    LD_PRELOAD="libjemalloc.so.2"

# Copy gems and compiled application from build stage
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Copy production configuration
COPY config/database.yml.example config/database.yml
COPY .dockerdev/.pryrc.prod /home/rails/.pryrc

# Install runtime-only dependencies and create application user
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -yq \
      ca-certificates \
      curl \
      libjemalloc2 \
      libvips \
      postgresql-client \
      procps \
      vim && \
    update-ca-certificates && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* && \
    useradd --create-home --shell /bin/bash rails && \
    mkdir -p \
      /home/rails/.pry \
      /home/rails/.local && \
    chown -R rails:rails \
      /rails \
      /home/rails

ARG DD_GIT_REPOSITORY_URL
ARG DD_GIT_COMMIT_SHA

ENV DD_GIT_REPOSITORY_URL="${DD_GIT_REPOSITORY_URL}" \
    DD_GIT_COMMIT_SHA="${DD_GIT_COMMIT_SHA}"

USER rails:rails

EXPOSE 3000

CMD ["./bin/rails", "server"]