---
name: pandora
description: Create a new Laravel project from the Pandora starter kit. Use when the user says "/pandora", "new laravel project", "create a new app", or wants to scaffold a Laravel 13 + Inertia + React project.
---

# Pandora — New Project Setup

Create a new Laravel project from the Pandora starter kit (Laravel 13 / Inertia v3 / React 19 / Fortify / Wayfinder).

**Starter repo:** git@github.com:davydeh/pandora.git
**Installer:** `bash <(curl -fsSL https://raw.githubusercontent.com/davydeh/pandora/main/setup.sh)`

---

## What Pandora Includes

- Laravel 13 + PHP 8.5 + Inertia v3 + React 19 + TypeScript 6
- Fortify (headless auth with 2FA/TOTP)
- Wayfinder (type-safe routing)
- Actions pattern for business logic
- UUID primary keys
- Vite+ with Bun, Oxlint
- PHPStan MAX + Rector + Pint strict + Pest v4
- Spatie backup, sitemap, image
- Flash messages with sonner toasts
- PWA support (service worker, manifest)
- S3 per-user storage isolation
- Feature flags (payment, invitation)
- GitHub Actions CI

---

## Process

### Step 1: Get Project Name

If `$ARGUMENTS` is empty, ask:

> What should the project be called? (kebab-case, e.g. `my-saas-app`)

If `$ARGUMENTS` has content, use it as the project name.

### Step 2: Determine Location

Default to `~/projects/personal/`. Ask the user if they want a different location.

### Step 3: Run the Installer

```bash
cd <target-directory>
bash <(curl -fsSL https://raw.githubusercontent.com/davydeh/pandora/main/setup.sh)
```

When the script prompts for project name, provide the name from Step 1.

**Important:** The script is interactive. Run it via Bash and let the user interact with the prompts. If the user wants a non-interactive setup, run the steps manually:

```bash
cd <target-directory>
git clone --depth 1 git@github.com:davydeh/pandora.git <project-name>
cd <project-name>
rm -rf .git
git init

# Customize identity
sed -i '' "s|davydeh/pandora|davydeh/<project-name>|g" composer.json
sed -i '' "s|APP_NAME=Laravel|APP_NAME=<project-name>|g" .env.example

# Install
composer install
bun install
cp .env.example .env
php artisan key:generate
touch database/database.sqlite
php artisan migrate
bun run build

# Commit
git add -A
git commit -m "Initial commit from Pandora starter kit"
```

### Step 4: Post-Setup

After the project is created:

1. Tell the user their project is ready
2. Suggest next steps:
   - `composer run dev` to start the dev server
   - The app is available at `http://<project-name>.test` if using Herd
   - Run `composer test` to verify everything works
3. If they want to connect to a remote repo:
   ```bash
   git remote add origin <their-repo-url>
   git push -u origin main
   ```

### Step 5: Optional Customization

Ask if they want to customize anything:
- App name in `.env`
- PWA manifest name/colors in `public/site.webmanifest`
- Admin email in `.env`
- Remove features they don't need (e.g., PWA, S3 storage)
