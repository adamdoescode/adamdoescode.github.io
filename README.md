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
eval "$(rbenv init -)"
make setup
```

### rbenv needs initialising in every shell, not just at setup

`rbenv init` is **not** a one-off install step. It puts the `rbenv` shims on
`PATH`, and that happens per shell. Interactive shells usually get it from
`~/.bashrc`, but non-interactive ones — scripts, CI steps, `ssh host 'make build'`,
anything an editor or agent runs for you — do not, and every Make target fails with:

```text
make: bundle: No such file or directory
make: *** [Makefile:7: build] Error 127
```

That error means the shims are missing, not that Bundler is uninstalled. Prefix the
command in the same shell:

```bash
eval "$(rbenv init - bash)" && make build
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

## Theming and colour

All colour lives in **`assets/theme.css`** and nowhere else. `indexStyles.css` and
`assets/blog.css` contain no hex literals; they reference named tokens, so changing
the palette is a one-file edit.

A *token* is a named colour role the markup references instead of a hex value. The
stylesheets say what a thing is (`--colour-primary-ink` for a link), and `theme.css`
says what colour that role currently is.

Light mode is the default `:root`. Dark mode is a `@media (prefers-color-scheme: dark)`
block that overrides the same token names, so the browser follows the OS. There is
deliberately no toggle and no JavaScript. `color-scheme: light dark` is set so
scrollbars and form controls follow too.

Current palette: [colorhunt f599c6 / ffea88 / 7dccad / 4d6787](https://colorhunt.co/palette/f599c6ffea887dccad4d6787).

### Token vocabulary

| token | meaning |
| --- | --- |
| `--colour-bg`, `--colour-surface`, `--colour-surface-alt` | page ground, raised cards, code/callout surfaces |
| `--colour-ink`, `--colour-muted` | body text, de-emphasised text |
| `--colour-primary` / `--colour-primary-ink` | pink FILL / pink TEXT |
| `--colour-secondary`, `--colour-accent` (+ `-ink`) | yellow and mint, same fill/text split |
| `--colour-on-primary`, `--colour-on-secondary` | text sitting ON a pastel fill |
| `--colour-border`, `--colour-shadow` | the neobrutalist outline and hard offset shadow |
| `--border-width`, `--shadow-offset`, `--shadow-hard` | shared geometry, so both stylesheets stay in step |

Names are semantic, not literal — `--colour-primary`, never `--colour-pink` — which is
what lets the palette change without renaming anything.

### Swapping the palette

Published palettes are fills only: they ship no text-safe shade and no dark ground,
so both get derived. The rules used here:

1. **Pick the darkest palette member as the ink anchor.** Darken it until it clears
   4.5:1 on the light background; that becomes `--colour-ink` and `--colour-border`.
   Darken it further for the dark-mode ground. A palette with no dark member cannot
   do this and will force you to invent colours that aren't in it.
2. **Derive text colours by darkening the fill, holding its hue.** Walk lightness
   down in HLS until contrast clears 4.5:1. Keeps `*-ink` in the same hue family
   instead of introducing a new colour.
3. **Keep the pastels literal.** They are bright enough to read on a dark ground,
   so in dark mode fill and ink converge and the palette stays recognisable.
4. **Invert only the outline.** `--colour-border` flips to near-white in dark mode.
5. **Step surfaces up, not down.** `bg` → `surface` → `surface-alt` each get slightly
   lighter in dark mode, the reverse of light mode.

### Rules worth not relearning

- **A surface token that flips lightness between schemes must pair with
  `--colour-ink`, never a fixed dark `*-ink`.** `--colour-surface-alt` is pastel
  yellow in light but dark slate in dark; hardcoding light-mode ink on it renders
  dark-on-dark. Audit every rule that sets `background` and `color` together.
- **Text on a pastel fill stays dark in both schemes.** Pastel fills don't invert,
  so `--colour-on-primary` is a constant, not a per-scheme value.
- **Keep a decorative bar's border well under its height.** A 3px border on a 5px
  bar leaves no fill visible and the bar reads as solid black.
- **Pastels vanish as rules on near-white.** For a divider or underline meant to
  read as deliberate, use the palette's most saturated member, not its lightest.
- **Compute contrast, don't eyeball it.** Pastels look fine and fail AA.

### Verifying a colour change

Colour bugs are invisible in a diff — dark-on-dark text and swallowed dividers both
pass code review. Render both schemes and look:

```bash
eval "$(rbenv init - bash)" && make build
make serve   # then, against the running server:

# prefers-color-scheme: 1 = light, 0 = dark
chromium --headless --no-sandbox --disable-gpu --hide-scrollbars \
  --window-size=1280,2200 --blink-settings=preferredColorScheme=0 \
  --virtual-time-budget=4000 --screenshot=dark.png http://127.0.0.1:4000/
```

Snap-packaged Chromium is confined and cannot write into hidden directories such as
`~/.hermes/...`; point `--screenshot` somewhere plain like `~/Downloads/`.

Then re-run the gate that keeps the next swap a one-file edit:

```bash
grep -nE '#[0-9a-fA-F]{3,6}\b' indexStyles.css assets/blog.css   # must print nothing
```
