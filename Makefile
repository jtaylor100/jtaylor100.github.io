sources = $(wildcard src/*.md)
post_sources = $(wildcard src/posts/*.md)
targets = $(patsubst src/%,%,$(patsubst %.md,%.html,$(sources))) $(patsubst src/%,%,$(patsubst %.md,%.html,$(post_sources)))


all: $(targets)

index.html: index-p.md src/footer.html
	pandoc $< -o $@ -s --include-after-body="src/footer.html"

%.html: src/%.md src/header.html src/footer.html
	pandoc $< -o $@ -s --include-before-body="src/header.html" --include-after-body="src/footer.html"

posts/%.html: src/posts/%.md src/header.html src/footer.html
	pandoc $< -o $@ -s --include-before-body="src/header.html" --include-after-body="src/footer.html"

index-p.md: src/index.md generate_post_list.sh
	./generate_post_list.sh

.PHONY: clean
clean:
	rm $(targets)
	rm index-p.md
