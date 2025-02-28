include operator/common.mk

##@ Documentation
DOCS_DIR := $(PWD)/docs

MDBOOK_VERSION ?= v0.4.40
MDBOOK_IMAGE ?= ghcr.io/peaceiris/mdbook:$(MDBOOK_VERSION)

.PHONY: serve-docs
serve-docs: ## Serve docs locally
	@echo "Starting local instance of documentation"
	@$(CONTAINER_TOOL) run \
		-v $(DOCS_DIR):/book \
		--name myriad-docs \
		--rm -dti --init \
		--network host \
		--entrypoint "sh" -e RUST_LOG=error \
		$(MDBOOK_IMAGE) \
		-c "mdbook-mermaid install && mdbook-admonish install && mdbook serve"

.PHONY: stop-docs
stop-docs: ## Stop serving mdBook documentation (Removes container).
		@$(CONTAINER_TOOL) rm -f myriad-docs
