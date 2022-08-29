sources = $(wildcard src/*.md)
post_sources = $(wildcard src/posts/*.md)
targets = $(patsubst src/%,%,$(patsubst %.md,%.html,$(sources))) $(patsubst src/%,%,$(patsubst %.md,%.html,$(post_sources)))


all: $(targets)

index.html: index-p.md
	pandoc $< -o $@ -s

%.html: src/%.md src/header.html
	pandoc $< -o $@ -s --include-before-body="src/header.html"

posts/%.html: src/posts/%.md src/header.html
	pandoc $< -o $@ -s --include-before-body="src/header.html"

index-p.md: src/index.md generate_post_list.sh
	./generate_post_list.sh

.PHONY: clean
clean:
	rm $(targets)
	rm index-p.md
