# Keycloak Smeup Theme

Custom theme for Keycloak based on the Smeup design system.

## Run with Docker

To launch Keycloak on localhost with the custom theme:

```sh
docker compose up
```

## Theme variants

The repository includes four Smeup theme variants:

- `smeup/lab/`: development and testing variant
- `smeup/lab-v2/`: development and testing V2 variant
- `smeup/prod/`: production-ready variant
- `smeup/prod-v2/`: production-ready V2 variant

Both variants include `login`, `account`, and `admin` theme parts.

## Change theme

- Go to `localhost:8080/admin/` and use `admin` as username and password
- Realm settings --> themes --> set the desired theme (`lab`, `lab-v2`, `prod`, or `prod-v2`)
- Refresh the page to see the new theme

## Show **Google** button in login page

- Identity providers --> Google --> client ID & client Secret ( generic values )
- Open on incognito page `localhost:8080/admin/`

## PR packaging and version traceability

Theme packaging can be run locally with `make package` and:

- lists themes under `smeup/` and customer themes under `customers/`
- accepts either the displayed number or the full theme path
- creates a `.tar` archive with the selected theme directory at its root
- prints the SFTP and SSH extraction commands for VM deployment

Use `make list` to inspect the available themes and `make clean` to remove generated archives.
