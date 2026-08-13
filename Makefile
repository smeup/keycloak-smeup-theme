SHELL := /bin/bash

DIST_DIR ?= dist
SSH_TARGET ?= user@vm
REMOTE_TMP_DIR ?= /tmp
REMOTE_THEMES_PATH ?= /path/to/keycloak-themes-keycloak-0

.PHONY: help list package clean

help:
	@printf '%s\n' \
		'Usage:' \
		'  make list                                      List available themes' \
		'  make package                                   Select and package a theme' \
		'  make clean                                    Remove generated archives' \
		'' \
		'Optional SSH variables:' \
		'  make package SSH_TARGET=user@vm REMOTE_THEMES_PATH=/path/to/keycloak-themes-keycloak-0'

list:
	@set -euo pipefail; \
	mapfile -t themes < <({ find . -mindepth 1 -maxdepth 1 -type d -printf '%P\n' | while read -r folder; do \
		if [[ -f "$$folder/login/theme.properties" ]]; then printf '%s\n' "$$folder"; fi; \
	done; find customers -mindepth 1 -maxdepth 1 -type d -printf '%p\n' 2>/dev/null | while read -r folder; do \
		if [[ -f "$$folder/login/theme.properties" ]]; then printf '%s\n' "$$folder"; fi; \
	done; } | sort); \
	if (( $${#themes[@]} == 0 )); then echo 'Nessun tema trovato.'; exit 1; fi; \
	printf '%s\n' "$${themes[@]}"

package:
	@set -euo pipefail; \
	mapfile -t themes < <({ find . -mindepth 1 -maxdepth 1 -type d -printf '%P\n' | while read -r folder; do \
		if [[ -f "$$folder/login/theme.properties" ]]; then printf '%s\n' "$$folder"; fi; \
	done; find customers -mindepth 1 -maxdepth 1 -type d -printf '%p\n' 2>/dev/null | while read -r folder; do \
		if [[ -f "$$folder/login/theme.properties" ]]; then printf '%s\n' "$$folder"; fi; \
	done; } | sort); \
	if (( $${#themes[@]} == 0 )); then echo 'Nessun tema trovato.'; exit 1; fi; \
	echo 'Temi disponibili:'; \
	for index in "$${!themes[@]}"; do printf '  %d) %s\n' $$((index + 1)) "$${themes[$$index]}"; done; \
	read -r -p 'Seleziona il tema da impacchettare: ' selection; \
	if [[ "$$selection" =~ ^[0-9]+$$ ]]; then \
		if (( selection < 1 || selection > $${#themes[@]} )); then echo 'Selezione non valida.' >&2; exit 1; fi; \
		theme="$${themes[$$((selection - 1))]}"; \
	else \
		theme=''; \
		for candidate in "$${themes[@]}"; do \
			if [[ "$$candidate" == "$$selection" ]]; then theme="$$candidate"; break; fi; \
		done; \
		if [[ -z "$$theme" ]]; then echo 'Selezione non valida.' >&2; exit 1; fi; \
	fi; \
	mkdir -p '$(DIST_DIR)'; \
	theme_id="$${theme//\//-}"; \
	archive="$$(printf '%s' "$$theme_id" | tr '[:upper:]' '[:lower:]')-$$(date -u +%Y%m%d%H%M%S).tar"; \
	theme_dir="$$(basename "$$theme")"; \
	theme_parent="$$(dirname "$$theme")"; \
	tar -cf "$(DIST_DIR)/$$archive" -C "$$theme_parent" "$$theme_dir"; \
	echo; \
	echo "Archivio creato: $(DIST_DIR)/$$archive"; \
	echo; \
	echo 'Comandi da eseguire dalla VM tramite SSH/SFTP:'; \
	echo "  sftp $(SSH_TARGET)"; \
	echo "  sftp> put $(DIST_DIR)/$$archive $(REMOTE_TMP_DIR)/$$archive"; \
	echo '  sftp> bye'; \
	echo "  ssh $(SSH_TARGET) tar -xf $(REMOTE_TMP_DIR)/$$archive -C $(REMOTE_THEMES_PATH)"; \
	echo; \
	echo 'Nota: configurare SSH_TARGET, REMOTE_TMP_DIR e REMOTE_THEMES_PATH in base alla VM e al mount del PVC.'

clean:
	@rm -rf '$(DIST_DIR)'
	@echo 'Archivio generati rimossi.'
