---
name: bootstrap
description: Bootstrap a new mobile app from the Atlas (Expo) kit and its Pandora (Laravel + Sanctum) backend, wired and verified end-to-end. Use when the user says "/bootstrap", "new app from Atlas and Pandora", "bootstrap a new mobile project", or wants to scaffold the mobile + backend pair. Run "/bootstrap deploy" to deploy an already-bootstrapped app to Laravel Forge.
---

# Bootstrap — Atlas + Pandora end-to-end

Orchestrates a new mobile app: the Pandora Laravel backend and the Atlas Expo app,
scaffolded, wired, and verified. Reuses each kit's `setup.sh`; adds URL wiring, API
type sync, and an auth round-trip gate. Never marches past a failed gate.

**Two modes** (read `$ARGUMENTS`):

- empty → **fresh** bootstrap, Phases 0–3, stops at a verified local stack.
- `deploy` → **deploy continuation**, Phases 4–6, against an already-scaffolded project.

Layout (siblings, separate git remotes):

```
<location>/<slug>-api/      # Pandora backend (Herd serves http://<slug>-api.test)
<location>/<slug>-mobile/   # Atlas Expo app
```

Use the same bundle id in both repos: it's Atlas's `__BUNDLE_ID__` now, and later becomes
Pandora's `APPLE_CLIENT_ID` audience when you enable Apple Sign-In (deferred — see Phase 6 and
`MANUAL_SETUP.md`). The local flow does not wire it into Pandora yet, so keeping it consistent
now just saves a re-key later.

---

## Mode: fresh (`$ARGUMENTS` empty)

### Phase 0 — Inputs & preflight

Ask for, in one message: **app display name**, **slug** (kebab-case), **bundle id**
(e.g. `com.you.acme`), and **location** (default `~/projects/personal`).

Preflight (abort with the missing tool if any fail):

```bash
php -v && composer --version && bun --version && git --version && npx expo --version
```

Refuse to start if `<location>/<slug>-api` or `<location>/<slug>-mobile` already exists —
tell the user to pick another slug or run `/bootstrap deploy` if they meant to continue.

### Phase 1 — Scaffold backend

```bash
cd <location>
git clone --depth 1 git@github.com:davydeh/pandora.git <slug>-api || \
  git clone --depth 1 https://github.com/davydeh/pandora.git <slug>-api
cd <slug>-api
rm -rf .git && git init -q
sed -i '' "s|davydeh/pandora|davydeh/<slug>-api|g" composer.json
# Quote the value: Laravel's dotenv parser rejects an unquoted APP_NAME that contains a space.
sed -i '' "s|APP_NAME=Laravel|APP_NAME=\"<APP_NAME>\"|g" .env.example
composer install --no-interaction
bun install
cp .env.example .env
php artisan key:generate
touch database/database.sqlite
php artisan migrate --force
bun run build
git add -A && git commit -q -m "Initial commit from Pandora starter kit"
```

(This is Pandora `setup.sh`'s non-interactive path. A fresh `main` already includes the
Sanctum mobile API and the `/api/openapi.json` doc.)

### Phase 2 — Scaffold mobile + wire local

```bash
cd <location>
git clone --depth 1 git@github.com:davydeh/atlas.git <slug>-mobile || \
  git clone --depth 1 https://github.com/davydeh/atlas.git <slug>-mobile
cd <slug>-mobile
APP_NAME="<APP_NAME>" APP_SLUG="<slug>" BUNDLE_ID="<BUNDLE_ID>" bash setup.sh
cp .env.example .env
```

`setup.sh` does not write `.env` — it bakes the chosen identity into `app.config.ts`'s
fallbacks. `.env.example` ships *example* identity values (`My App` / `my-app` /
`com.example.myapp`); left as-is in `.env` those env vars override the correct baked identity
at runtime. So **edit the four `EXPO_PUBLIC_*` lines already in `.env` in place** (replace the
existing lines — do not append, which would create duplicate keys) to:

```
EXPO_PUBLIC_API_URL=http://<slug>-api.test
EXPO_PUBLIC_APP_NAME=<APP_NAME>
EXPO_PUBLIC_APP_SLUG=<slug>
EXPO_PUBLIC_BUNDLE_ID=<BUNDLE_ID>
```

If `<location>` is not a parked Herd path, link the site so `.test` resolves:

```bash
cd <location>/<slug>-api && herd link <slug>-api
```

### Phase 3 — Local checkpoint (GATE)

Three automated gates first (each exits non-zero on failure — stop on the first that fails):

```bash
# 1. Backend reachable (openapi doc is exposed locally)
curl -fsS http://<slug>-api.test/api/openapi.json > /dev/null && echo "backend up"

# 2. Sync types from the local backend and commit them
cd <location>/<slug>-mobile
EXPO_PUBLIC_API_URL=http://<slug>-api.test bun run sync-api-types
git add src/types/api.ts && git commit -q -m "chore: sync API types from <slug>-api"

# 3. Prove the auth round-trip (hits the backend directly — no app or simulator needed)
EXPO_PUBLIC_API_URL=http://<slug>-api.test bun run verify-backend
```

Then a visual smoke check on the simulator. `bun run ios` is a long-running foreground
process (it builds, starts Metro, and stays attached), so run it in the background or a
separate terminal — it is NOT a command whose exit code gates the flow:

```bash
# 4. Boot Atlas on the iOS simulator (resolves Herd .test via the Mac's DNS — a physical
#    device would not). Backgrounded; watch for the login screen with no network errors.
cd <location>/<slug>-mobile && bun run ios &
```

All four checks must pass — the first three by exit code, the fourth by confirming the app
reaches the login screen without network errors. If `verify-backend` fails, read its per-step
output: a reachability failure is DNS/Herd (`herd link`, is the site served?); a signup
failure is the API/DB; an authed-read failure is token/Sanctum config. Fix before proceeding —
do not deploy a backend whose round-trip is unproven.

**Stop here.** Report: "Local stack verified against `http://<slug>-api.test`. Start
building. When you're ready to ship, run `/bootstrap deploy`."

---

## Mode: deploy (`$ARGUMENTS` == "deploy")

Re-entrant. Detect the existing project first; never re-scaffold.

### Phase 4 — Deploy backend to Laravel Forge (manual GATE)

Locate `<slug>-api` and `<slug>-mobile` (ask for the slug/location if not obvious).
Then hand off the dashboard steps — Claude cannot click Forge:

> Deploy `<slug>-api` to Laravel Forge:
>
> 1. Push it to a Git remote if you haven't (`git remote add origin … && git push -u origin main`).
> 2. In Forge: create a site on a server, connect that Git repo, set the deploy branch.
> 3. Environment: set `APP_KEY` (copy from the local `.env`), `APP_URL=https://<your-domain>`,
>    `APP_ENV=production`, and the database vars. Keep `MAIL_MAILER=log` unless you've set up mail.
> 4. Provision SSL (Let's Encrypt) and enable "Deploy".
> 5. In the deploy script (or via SSH), run `php artisan migrate --force`.
> 6. Paste the live `https://…` URL back here.

Wait for the live URL. Note: `/api/openapi.json` will 404 in production by design — that's
expected (it's gated to local/testing); type sync already happened locally in Phase 3.

### Phase 5 — Re-wire & re-verify prod (GATE)

```bash
cd <location>/<slug>-mobile
# Point .env EXPO_PUBLIC_API_URL at the live URL, then:
EXPO_PUBLIC_API_URL=https://<live-host> bun run verify-backend
```

Must pass (the auth round-trip — reachability, signup, authed read, cleanup) against prod.
No `sync-api-types` here. If it's already wired and passing, this is a no-op.

### Phase 6 — EAS & handoff

```bash
cd <location>/<slug>-mobile
bunx eas init   # writes extra.eas.projectId
```

Then point the user at `docs/MANUAL_SETUP.md` for the optional, deferred work: social
sign-in (Apple/Google client IDs), Sentry, PostHog, push (APNs/FCM), and store listings —
all optional at runtime, add as needed.

Report: "Deployed + wired. `<slug>-mobile` verifies against `https://<live-host>` and EAS
is initialized."
