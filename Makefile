.PHONY: setup build serve ci-local

setup:
	bundle install

build:
	bundle exec jekyll build --future

serve:
	bundle exec jekyll serve --watch --host 127.0.0.1 --port 4000

ci-local:
	act pull_request -W .github/workflows/site.yml -j build
