STOW ?= stow
PACKAGES ?= zsh nvim tmux btop alacritty

.PHONY: install uninstall dryrun

install:
	$(STOW) -v -t $$HOME $(PACKAGES)

uninstall:
	$(STOW) -v -D -t $$HOME $(PACKAGES)

dryrun:
	$(STOW) -n -v -t $$HOME $(PACKAGES)

