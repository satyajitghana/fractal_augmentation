SRC = $(wildcard nbs/*.ipynb)

all: fractal_augmentation docs

fractal_augmentation: $(SRC)
	nbdev_build_lib
	touch fractal_augmentation

sync:
	nbdev_update_lib

docs_serve: docs
	cd docs && bundle exec jekyll serve

docs: $(SRC)
	nbdev_build_docs
	touch docs

test:
	nbdev_test_nbs

release: pypi
	nbdev_bump_version

pypi: dist
	twine upload --repository pypi dist/*

dist: clean
	python setup.py sdist bdist_wheel

clean:
	rm -rf dist