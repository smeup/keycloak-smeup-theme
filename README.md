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

## PR packaging and version traceability

On every Pull Request update, GitHub Actions runs `PR Theme Packaging` and:

- creates `.tar` archives only when PR diffs touch `lab/` or `prod/`
- creates one `.tar` per customer folder when PR diffs touch subfolders under `customers/` (for example `customers/acme/`)
- assigns a version like `pr-<PR>.<RUN>-<SHORT_SHA>-<UTC_TIMESTAMP>`
- uploads all files in the workflow artifact `theme-packages-<VERSION>`
- includes a manifest file with version, PR, branch, commit and SHA256 checksums

If no relevant diffs are found, the packaging step is skipped and no tar artifact is created.

This provides a clear build trace only when packaging is actually needed.
