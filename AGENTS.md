# Repository Guidelines

## Project Structure & Module Organization
- `app/` contains Rails code; `app/channels` for AnyCable channel handlers, `app/sidekiq` for jobs orchestrated by Sidekiq.
- `config/` stores framework and AnyCable config; adjust environment settings in `config/environments/` and `config/cable.yml`.
- `db/` holds migrations and seeds; run migrations after pulling schema updates.
- `Procfile.dev` defines the process set used by Overmind; `Dockerfile` is available for containerized runs.
- `test/` mirrors app structure with Minitest suites and fixtures.

## Build, Test, and Development Commands
```bash
bundle install             # install gems
brew services start redis  # start Redis locally for Action Cable
overmind start             # run web, AnyCable, ws, sidekiq from Procfile.dev
bin/rails s -p 3000        # boot app if running processes manually
bundle exec rails test     # run the entire Minitest suite
```
Use `DEEPSEEK_API_KEY=...` in your shell (or `.env`) before launching the stack.

## Coding Style & Naming Conventions
- Follow standard Rails conventions: 2-space indentation, snake_case file names, CamelCase class/module names.
- Prefer single quotes for simple Ruby strings; double quotes only when interpolation is needed.
- Place shared helpers or support modules in `lib/` and keep namespaces aligned to their directory structure.
- Keep channel names aligned with `RoomChannel` pattern so Action Cable identifiers remain predictable.

## Testing Guidelines
- Write Minitest cases under `test/` mirroring the directory of the code under test.
- Name test files `<subject>_test.rb` and methods `test_<behavior>`; use fixtures in `test/fixtures` or Factory helpers when present.
- Run `bundle exec rails test` before submitting; target high-traffic features with integration tests in `test/integration`.

## Commit & Pull Request Guidelines
- Match existing history: concise, imperative subject lines (`gem upgrade`, `Add chat broadcast guard`).
- Squash local work into focused commits that describe observable changes.
- PRs should outline the problem, solution, and verification steps; link issues when available and include screenshots/GIFs for UI changes.
- Note any required env vars or migrations in the PR body so reviewers can reproduce locally.

## Configuration Notes
- Keep `.env` and credentials out of version control; rely on `config/credentials.yml.enc` for shared secrets.
- Redis must be reachable at `localhost:6379`; adjust `config/cable.yml` if you deviate.
