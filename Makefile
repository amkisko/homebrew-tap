.PHONY: bump help

# Example: make bump FORMULA=bmx TAG=v0.1.3
# Optional: make bump FORMULA=bmx TAG=v0.1.3 COMMIT=1 PUSH=1
FORMULA ?=
TAG ?=
REPOSITORY ?=
MIRROR ?=
COMMIT ?=
PUSH ?=

help:
	@echo "make bump FORMULA=bmx TAG=v0.1.3 [COMMIT=1] [PUSH=1] [MIRROR=path] [REPOSITORY=owner/repo]"

bump:
	@test -n "$(FORMULA)" || (echo "FORMULA is required" >&2; exit 2)
	@test -n "$(TAG)" || (echo "TAG is required" >&2; exit 2)
	./scripts/bump-formula.sh \
		--formula "$(FORMULA)" \
		--tag "$(TAG)" \
		$(if $(REPOSITORY),--repository "$(REPOSITORY)",) \
		$(if $(MIRROR),--mirror "$(MIRROR)",) \
		$(if $(COMMIT),--commit,) \
		$(if $(PUSH),--push,)
