# frozen_string_literal: true

# https://ddnexus.github.io/pagy/toolbox/options/
Pagy::OPTIONS[:limit] = 15
Pagy::OPTIONS[:max_limit] = 30
Pagy::OPTIONS[:limit_key] = "per_page"

Pagy::OPTIONS[:headers_map] = {
  page: "X-Page",
  limit: "X-Per-Page",
  pages: "X-Total-Pages",
  count: "X-Total"
}
