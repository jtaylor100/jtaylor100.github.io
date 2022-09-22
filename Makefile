sources = $(wildcard src/*.md)
post_sources = $(wildcard src/posts/*.md)
targets = $(patsubst src/%,%,$(patsubst %.md,%.html,$(sources))) $(patsubst src/%,%,$(patsubst %.md,%.html,$(post_sources)))
common_dependencies = src/defaults.yaml src/footer.html src/styles.html


all: $(targets)

index.html: index-p.md $(common_dependencies)
	pandoc $< -o $@ -s --defaults="src/defaults.yaml"

%.html: src/%.md src/header.html $(common_dependencies)
	pandoc $< -o $@ -s --defaults="src/defaults.yaml" --include-before-body="src/header.html"

posts/%.html: src/posts/%.md src/header.html $(common_dependencies)
	pandoc $< -o $@ -s --defaults="src/defaults.yaml" --include-before-body="src/header.html"

index-p.md: src/index.md $(post_sources) generate_post_list.sh
	./generate_post_list.sh

.PHONY: clean
clean:
	rm $(targets)
	rm index-p.md
