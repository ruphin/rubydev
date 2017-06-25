build:
	docker build -t ruphin/rubydev .
	docker push ruphin/rubydev
.PHONY: build
