#
# SPDX-License-Identifier: GPL-3.0-or-later

PREFIX ?= /usr/local
_PROJECT=transmission-dlagent
DATA_DIR=$(DESTDIR)$(PREFIX)/share
DOC_DIR=$(DESTDIR)$(PREFIX)/share/doc/$(_PROJECT)
BIN_DIR=$(DESTDIR)$(PREFIX)/bin
LIB_DIR=$(DESTDIR)$(PREFIX)/lib/$(_PROJECT)

DOC_FILES=$(wildcard *.rst)
SCRIPT_FILES=$(wildcard $(_PROJECT)/*)

all:

check: shellcheck

shellcheck:
	shellcheck -s bash $(SCRIPT_FILES)

install: install-scripts install-configs install-doc

install-scripts:

	install \
	  -vDm755 \
	  "$(_PROJECT)/$(_PROJECT)" \
	  "$(BIN_DIR)/$(_PROJECT)"
	install \
	  -vDm755 \
	  "$(_PROJECT)/transmission-quit" \
	  "$(BIN_DIR)/transmission-quit"

install-configs:

	install \
	  -vDm644 \
	  "configs/makepkg.conf" \
	  "$(DATA_DIR)/$(_PROJECT)/makepkg.conf"

install-doc:

	install -vDm 644 $(DOC_FILES) -t $(DOC_DIR)

.PHONY: check install install-configs install-doc install-scripts shellcheck
