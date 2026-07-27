---
name: "Keycloak Theme Optimizer"
description: "Optimize Keycloak customer login and admin themes for social-only authentication, remove Keycloak branding assets, align the layout with the prod theme, and standardize the customer logo to logo.png. Use when editing customers/* login themes, admin console branding, hiding username/password form boxes, removing social divider text, or keeping the UI visually consistent across variants."
---

# Keycloak Theme Optimizer

## What This Skill Does

Use this skill when working on the customer Keycloak login or admin theme and you want to keep the UI aligned with the `prod` theme, clean up Keycloak branding, and use the canonical customer assets.

## Primary Goals

- Hide the username/password form on the login page.
- Keep only social login buttons visible.
- Remove the default Keycloak divider text and horizontal rule above social providers.
- Remove Keycloak background and logo fallbacks.
- Keep the login card visually aligned with the `prod` theme.
- Preserve the existing social provider button behavior and provider icons.
- Standardize the customer logo on `logo.png` when updating header branding.
- Keep the admin console visually aligned with `prod` for layout, but use the customer brand colors and logo asset so the branding remains visible.

## Files Usually Involved

- `customers/università-udine/login/template.ftl`
- `customers/università-udine/login/social-providers.ftl`
- `customers/università-udine/login/resources/css/styles.css`
- `customers/università-udine/login/resources/css/quick-start.css`
- `customers/università-udine/login/resources/img/logos/logo.png`
- `customers/README-theme-optimization.md`
- `customers/università-udine/admin/theme.properties`
- `customers/università-udine/admin/resources/css/quick-start.css`
- `customers/università-udine/admin/resources/css/styles.css`
- `customers/università-udine/admin/resources/public/logo.png`
- `customers/università-udine/admin/resources/public/favicon.ico`

## Editing Rules

- Prefer template overrides when upstream Keycloak generates unwanted markup.
- Use CSS only for spacing, centering, sizing, and visual cleanup.
- Do not reintroduce the default Keycloak logo or background image fallbacks.
- Prefer `logo.png` as the canonical logo asset for the customer theme.
- Keep the login page on the social-auth flow only.
- When adjusting vertical rhythm, compare against the `prod` theme before changing markup.
- Keep the social provider button full-width and centered under the title.
- Small logo size changes are acceptable only if the asset still looks crisp.
- For admin console work, keep the same layout rhythm as `prod`, but switch the branding tokens and logo asset to the customer theme.

## Recommended Workflow

1. Check the current `prod` theme for spacing and alignment.
2. Update the customer `template.ftl` only if a block must disappear entirely.
3. Override the social providers macro if the divider or label is generated upstream.
4. Tune `styles.css` for spacing, centering, and title/logo presentation.
5. Tune `quick-start.css` for logo dimensions and brand variables.
6. Validate with `git diff --check` or a narrow CSS/template inspection.

## Design Notes

- The login page should feel minimal: logo, title, one social button, nothing else.
- The social button should sit slightly below the title, not flush against it.
- If the button looks off-center, adjust the social block width before changing its content.
- If the title wraps, prefer a small font-size or white-space adjustment rather than changing the card width.

## Known Good Outcome

The intended final result is:
- Uniud logo at the top via `logo.png`.
- Title on a single line.
- No username/password box.
- No `Or sign in with` text.
- No horizontal divider above social providers.
- A centered social login button.
- No visible Keycloak background or logo assets.
- The admin console should use the same `prod`-aligned colors, radius, and branding assets.

## How To Reuse

When another AI needs to continue this theme, point it to this skill and the notes in `customers/README-theme-optimization.md`. If the task is still unclear, start from the `prod` theme and copy only the spacing/layout behavior that matters.
