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
make setup
```

For local editing:

```bash
make serve
```

The site is served at [http://127.0.0.1:4000/](http://127.0.0.1:4000/).

For the same build check used by GitHub Actions:

```bash
make ci-local
```
