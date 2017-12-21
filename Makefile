MARKDOWN_DIR=markdown
POSTS=$(shell find $(MARKDOWN_DIR)/*.markdown | sed 's/\.markdown/\.html/g' | sed 's/markdown\//posts\//g' | tr "\n" " ")

CSS_DIR=css
POSTS_DIR=posts
TEMPLATES_DIR=templates

HOME_PAGE=index.html
CSS=$(CSS_DIR)/layout.css

all: $(POSTS) $(HOME_PAGE) $(CSS) 
regen: clean all
clean:
	rm -f $(POSTS_DIR)/* $(CSS_DIR)/* $(HOME_PAGE)
%.html: $(TEMPLATES_DIR)/%.html $(TEMPLATES_DIR)/main.html
	pandoc --template $(TEMPLATES_DIR)/main.html $< -o $@
$(POSTS_DIR)/%.html: markdown/%.markdown $(TEMPLATES_DIR)/post.html $(TEMPLATES_DIR)/main.html
	pandoc --template $(TEMPLATES_DIR)/post.html -t html -f markdown  $< | pandoc --template $(TEMPLATES_DIR)/main.html -f markdown-markdown_in_html_blocks+raw_html -t html -o $@
$(CSS_DIR)/%.css: sass/%.scss
	sass $< $@

