CSS_DIR		:= css
POSTS_DIR	:= posts
TEMPLATES_DIR	:= templates
MARKDOWN_DIR	:= markdown

POSTS		:= $(shell find $(MARKDOWN_DIR)/*.markdown | sed 's/\.markdown/\.html/g' | sed 's/$(MARKDOWN_DIR)\//$(POSTS_DIR)\//g' | tr "\n" " ")
PAGES		:= index.html

CSS		:= $(CSS_DIR)/layout.css

all: $(POSTS) $(PAGES) $(CSS) 
regen: clean all
clean:
	rm -f $(POSTS) $(CSS) $(PAGES)
%.html: $(TEMPLATES_DIR)/%.html $(TEMPLATES_DIR)/main.html
	pandoc --template $(TEMPLATES_DIR)/main.html $< -o $@
$(POSTS_DIR)/%.html: $(MARKDOWN_DIR)/%.markdown $(TEMPLATES_DIR)/post.html $(TEMPLATES_DIR)/main.html
	pandoc --template $(TEMPLATES_DIR)/post.html -V currentyear=$(shell date +%Y) -t html -f markdown  $< \
	| pandoc --template $(TEMPLATES_DIR)/main.html -f markdown-markdown_in_html_blocks+raw_html -t html -o $@
$(CSS_DIR)/%.css: sass/%.scss
	sass $< $@

