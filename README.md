# NASA Missions

A web application for calculating the fuel required to launch from and land on
planets during interplanetary travel.

## Development

The project uses Ruby 4.0.4, Rails 8.1, PostgreSQL, and Docker through `dip`.
Install Docker and `dip`, then run:

```sh
dip provision
```

This installs the Ruby and frontend dependencies, builds CSS, prepares the
database, and starts the application at http://localhost:3000. Component previews
are available at http://localhost:3000/lookbook in development.

The provision command copies `.env.example` to `.env` if needed. Set `APP_PORT`
in `.env` to use a different web port, for example when another application is
also running.
Docker containers, volumes, and databases use separate `nasa-missions` names.
Run `dip rails db:seed` on an existing database to add the Earth, Moon, and Mars
options used by the mission planner.

Useful commands:

```sh
dip compose up -d web css
dip compose down
dip rails console
dip rspec spec/requests/home_spec.rb spec/routing/public_routes_spec.rb spec/components/admin
dip rubocop app/controllers/home_controller.rb config/routes.rb spec/requests/home_spec.rb spec/routing/public_routes_spec.rb
```

## Scope of the imported code

- The home page is public; there are no login, account, or admin routes.
- The starter application's workflows, reviews, submissions, staff records, and
  their seed data were removed from the imported application.
- Files in `app/components`, their styles, and Stimulus controllers retain their
  existing interfaces and behavior. Component examples use sample data where they
  previously depended on staff records.
- General supporting libraries and development tooling are retained from the
  starter application.
- Git history, local credentials, uploaded files, installed dependencies, and
  generated assets were not imported.
