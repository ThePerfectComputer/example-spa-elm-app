SRC_FILES := $(shell find src -name "*.elm")

all: elm.min.js

serve: all
	python3 -m http.server

elm.min.js: $(SRC_FILES)
	rm -f elm.min.js elm.js
	./optimize.sh src/Main.elm
