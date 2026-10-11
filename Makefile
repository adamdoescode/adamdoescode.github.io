.PHONY: setup build serve serve-lan ci-local

setup:
	bundle install

build:
	bundle exec jekyll build --future

serve:
	bundle exec jekyll serve --watch --host 127.0.0.1 --port 4000

serve-lan:
	bundle exec jekyll serve --watch --host 0.0.0.0 --port 4000

ci-local:
	act pull_request -W .github/workflows/site.yml -j build
