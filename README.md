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

To add the example Apollo 11, Mars, and Passenger Ship missions, run:

```sh
dip rails missions:seed_examples
```

The task also creates the required planets and can be run again without
duplicating the example missions.

Useful commands:

```sh
dip compose up -d web css
dip compose down
dip rails console
dip rspec
dip rubocop
```
