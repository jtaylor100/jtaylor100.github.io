ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

all:
	sass $(ROOT_DIR)/sass/layout.scss $(ROOT_DIR)/css/layout.css
	php $(ROOT_DIR)/templates/main.php > $(ROOT_DIR)/index.html
