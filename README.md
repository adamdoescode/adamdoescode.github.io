# Adamdoescode Landing Page

[![pages-build-deployment](https://github.com/adamdoescode/adamdoescode.github.io/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/adamdoescode/adamdoescode.github.io/actions/workflows/pages/pages-build-deployment)
[![Site CI](https://github.com/adamdoescode/adamdoescode.github.io/actions/workflows/site.yml/badge.svg)](https://github.com/adamdoescode/adamdoescode.github.io/actions/workflows/site.yml)

For fun and profit.

This page uses essentially straight HTML + CSS, and was used as a way to learn flexbox HTML and CSS styling.

It still relies on Jekyll on GitHub Pages. Local builds use Ruby and Bundler with the `github-pages` gem so they track GitHub Pages behavior.

## Getting Started

Prerequisites:

- `rbenv`
- Bundler
- Docker running
- `act` 0.2.86 or newer

First-time setup:

```bash
rbenv install 3.3.7
# this line adds rbenv to the path
eval "$(rbenv init -)"
make setup
```

For local editing:

```bash
make serve
```

The local editing site is served at [http://127.0.0.1:4000/](http://127.0.0.1:4000/).

The Makefile is a convenience layer for Ruby and Bundler commands, with these aliases:

- `make setup` → `bundle install`
- `make build` → `bundle exec jekyll build --future`
- `make serve` → local preview at `127.0.0.1:4000`
- `make serve-lan` → network preview on port `4000`
- `make ci-local` → run the GitHub Actions build with `act`

The underlying commands can be run directly if Make is unavailable.

To preview the site from another device on the local network which will setup on port 4000:

```bash
make serve-lan
```

## Blog

Articles live in `_posts` and use Jekyll's date-prefixed filename format:

```text
_posts/YYYY-MM-DD-post-title.md
```

The blog index is at `/blog/`, and `jekyll-feed` generates an Atom feed at
`/feed.xml`. Post URLs use Jekyll's default date-based format.

For the same build check used by GitHub Actions:

```bash
make ci-local
```
