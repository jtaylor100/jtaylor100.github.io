MARKDOWN_DIR=markdown
POSTS=$(shell find $(MARKDOWN_DIR)/*.markdown | sed 's/\.markdown/\.html/g' | sed 's/markdown\//posts\//g' | tr "\n" " ")

CSS_DIR=css
POSTS_DIR=posts
TEMPLATES_DIR=templates

CSS=$(CSS_DIR)/layout.css

all: $(GEN_TEMPLATES_DIR) $(POSTS) $(CSS)

regen: clean all

clean:
	rm -f $(POSTS_DIR)/* $(CSS_DIR)/*

$(POSTS_DIR)/%.html: markdown/%.markdown 
	pandoc --template $(TEMPLATES_DIR)/post.html  $< | pandoc --template $(TEMPLATES_DIR)/main.html -o $@

$(CSS_DIR)/%.css: sass/%.scss
	sass $< $@

