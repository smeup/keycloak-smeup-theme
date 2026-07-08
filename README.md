# Keycloak Smeup Theme

Custom theme for Keycloak based on the Smeup design system.

## Run with Docker

To launch Keycloak on localhost with the custom theme:

```sh
docker compose up
```

## Theme variants

The repository includes two theme variants:

- `lab/`: development and testing variant
- `prod/`: production-ready variant

Both variants include `login`, `account`, and `admin` theme parts.

## Change theme

- Go to `localhost:8080/admin/` and use `admin` as username and password
- Realm settings --> themes --> set 'smeup-lab' or 'smeup-prod' on themes voices
- Refresh the page to see the new theme

## Show **Google** button in login page

- Identity providers --> Google --> client ID & client Secret ( generic values )
- Open on incognito page `localhost:8080/admin/`
