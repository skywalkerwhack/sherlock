# Variables
VENV_DIR = .venv
PYTHON = $(VENV_DIR)/bin/python
PIP = $(VENV_DIR)/bin/pip
SOURCE_DIR = sherlock
TEST_DIR = tests

# Default target
.PHONY: all
all: install lint test

# Create virtual environment
$(VENV_DIR):
	python3 -m venv $(VENV_DIR)

# Install dependencies
.PHONY: install
install: $(VENV_DIR)
	$(PIP) install -r requirements.txt

# Lint the code
.PHONY: lint
lint:
	$(PYTHON) -m flake8 $(SOURCE_DIR)/

# Run tests
.PHONY: test
test:
	$(PYTHON) -m unittest discover -s $(TEST_DIR)

# Clean up
.PHONY: clean
clean:
	rm -rf $(VENV_DIR)
	find . -type f -name '*.pyc' -delete
	find . -type d -name '__pycache__' -delete

# Run the application
.PHONY: run
run: install
	$(PYTHON) $(SOURCE_DIR)/main.py

# Build documentation
.PHONY: docs
docs:
	$(PYTHON) -m sphinx -b html docs/ docs/_build/html
