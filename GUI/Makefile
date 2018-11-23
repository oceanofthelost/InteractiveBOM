JS_DEPS := node_modules
JS_SRCS := $(wildcard src/*.js)
PURS_DEPS := bower_components
PURS_SRCS := $(wildcard src/*.purs)

BOWER := npx bower
BROWSERIFY := npx browserify
PSCID := npx pscid
PULP := npx pulp

.DEFAULT_GOAL := index.js

# Track an empty file as a timestamp of the last `npm install`
$(JS_DEPS)/.stamp: package.json package-lock.json
	npm install
	touch $@

# Track an empty file as a timestamp of the last `bower install`
$(PURS_DEPS)/.stamp: $(JS_DEPS)/.stamp bower.json
	$(BOWER) install
	touch $@

.PHONY: build
build: output/Main/index.js

clean:
	rm -fr \
	  .psci-modules \
	  .pulp-cache \
	  .purs-repl \
	  bower_components \
	  index.js \
	  node_modules \
	  output \
	  pcbdata.json

index.js: $(JS_DEPS)/.stamp $(JS_SRCS) output/Main/index.js pcbdata.json
	$(BROWSERIFY) src/main.js --debug --outfile $@

output/Main/index.js: $(JS_DEPS)/.stamp $(PURS_DEPS)/.stamp $(PURS_SRCS)
	$(PULP) build

pcbdata.json: ../Examples/Eagle/Arduino_MEGA2560_ref/pcbdata.json
	cp $< $@

.PHONY: repl
repl: $(JS_DEPS)/.stamp $(PURS_DEPS)/.stamp
	$(PULP) repl

.PHONY: test
test: $(JS_DEPS)/.stamp $(PURS_DEPS)/.stamp
	$(PULP) test

.PHONY: watch
watch: $(JS_DEPS)/.stamp $(PURS_DEPS)/.stamp
	$(PSCID)
