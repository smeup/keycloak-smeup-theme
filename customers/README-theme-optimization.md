# Customers Theme Optimization Notes

This document records the changes made to the `customers/università-udine/login` theme so another AI can continue from the current state without re-discovering the layout decisions.

The `customers/università-udine/admin` theme keeps the `prod` layout rhythm for the admin console, but uses the customer brand colors and customer logo/public asset setup so the change is visible.

## Goal

Convert the Keycloak login page into a social-login-only experience, keep the page visually aligned with the `prod` theme, and remove the default Keycloak branding/assets from the customer theme.

## What was changed

### 1) Removed the username/password box from the login page

File: `customers/università-udine/login/template.ftl`

Behavior:

- The standard form block is no longer rendered on the `login` page.
- The fallback `try another way` action is also suppressed on the `login` page.
- The social providers section still renders normally.

Why:

- Login must happen only through social login buttons.
- The username/password UI would conflict with the requested flow.

### 2) Removed the social divider and label text

File: `customers/università-udine/login/social-providers.ftl`

Behavior:

- Added a local override for the Keycloak social providers macro.
- The divider line and label above the provider list are not rendered.
- Only the provider button list is emitted.

Why:

- The page must not show `Or sign in with` or the horizontal rule.
- The Microsoft/Google button should remain as the only call to action.

Important detail:

- The upstream Keycloak `keycloak.v2` login theme renders the divider and label inside the social providers macro, so CSS-only hiding was not reliable enough.

### 3) Removed Keycloak background and logo references

Files:

- `customers/università-udine/login/resources/css/styles.css`
- `customers/università-udine/login/resources/css/quick-start.css`

Behavior:

- Keycloak background and logo fallbacks were neutralized.
- The theme now uses the Uniud logo only.
- The login background is kept clean and white.

Why:

- The user explicitly asked to remove all references to the original Keycloak background and logo.
- Keeping Keycloak asset fallbacks made the theme harder to reason about and easier to regress.

### 4) Tuned the visual layout to match `prod`

File: `customers/università-udine/login/resources/css/styles.css`

Behavior:

- The social providers block is lowered slightly below the title with `margin-top: 24px`.
- The social provider list and items are forced to full width so the button stays centered correctly.
- The social provider separator elements remain hidden.
- The page title is kept on a single line.

Why:

- The customer theme should follow the `prod` layout rhythm.
- The button should feel visually centered under the title rather than floating too high.

### 5) Kept the header logo on PNG and enlarged it slightly

Files:

- `customers/università-udine/login/resources/img/logos/logo.png`
- `customers/università-udine/login/resources/css/quick-start.css`
- `customers/università-udine/login/resources/css/styles.css`

Behavior:

- The canonical header logo is now `logo.png`.
- The logo width was increased from `300px` to `320px`.
- The logo height remains proportional and visually safe.

Why:

- The logo can be widened slightly without visible pixelation.
- This improves balance at the top of the card.

## Current login behavior

The final login page now behaves like this:

- Top Uniud logo is visible through `logo.png`.
- The main card title is visible and stays on one line.
- No username/password form is shown.
- No `Or sign in with` text is shown.
- No divider line is shown.
- The social login button is centered and lower, closer to the `prod` layout.
- Keycloak branding/background assets are no longer used.

## Files that matter for future work

If another AI needs to continue this theme, these are the key files:

- `customers/università-udine/login/template.ftl`
- `customers/università-udine/login/social-providers.ftl`
- `customers/università-udine/login/resources/img/logos/logo.png`
- `customers/università-udine/login/resources/css/styles.css`
- `customers/università-udine/login/resources/css/quick-start.css`
- `customers/università-udine/login/theme.properties`
- `customers/università-udine/admin/theme.properties`
- `customers/università-udine/admin/resources/css/quick-start.css`
- `customers/università-udine/admin/resources/css/styles.css`
- `customers/università-udine/admin/resources/public/logo.png`
- `customers/università-udine/admin/resources/public/favicon.ico`

## Practical rules for future edits

- Keep social-only login behavior in the `login` page only.
- Do not reintroduce the standard Keycloak divider or label in social providers.
- Prefer template overrides over CSS-only hiding when the markup is generated upstream.
- If the layout must track `prod`, compare spacing and width rules before changing the markup.
- Be careful with logo dimensions: small width changes are safe only if the PNG still looks crisp.
- Avoid restoring Keycloak logo/background fallback variables unless absolutely needed.

## Verification already performed

- `git diff --check` passed after the changes.
- The customer login theme no longer contains active references to the Keycloak login background/logo assets.

## Notes for another AI

If you need to continue from here, the safest approach is:

1. Check `prod/login/resources/css/styles.css` for layout alignment rules.
2. Make any visual tweak in the customer theme CSS, not in the generic Keycloak flow.
3. Keep the social provider template override as the source of truth for the simplified login UI.
