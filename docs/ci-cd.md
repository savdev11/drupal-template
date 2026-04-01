# CI/CD

## CI workflow

`.github/workflows/ci.yml` runs on pushes/PRs and performs:

- Composer validation/install
- PHPCS (Drupal + DrupalPractice)
- PHPMD
- YAML lint
- Twig lint
- PHPUnit

## Release + deploy workflow

`.github/workflows/release-deploy.yml` runs when tags like `v0.1.0` are pushed.

Flow:

1. Verify tag commit belongs to `main`.
2. Create GitHub release.
3. Trigger optional deployment webhooks:
   - `COOLIFY_WEBHOOK_URL`
   - `DOKPLOY_WEBHOOK_URL`

If a webhook secret is not configured, that deployment target is skipped.
