.DEFAULT_GOAL := all

DOCKER := docker
DOCKER_IMAGE := "workspace-local-dev"

GIT := git
PWD := $$(pwd)
SOURCE := $(PWD)/src
CONFIG := ${HOME}/.config/workspace
ENV := $(CONFIG)/env

export ZSH := ${HOME}/.oh-my-zsh
export ZSH_CUSTOM := ${ZSH}/custom

.PHONY: all
all: home git zsh p10k vim tmux

.PHONY: home
home:
	@echo "Configuring BASH"
	@cp "$(SOURCE)/.bashrc" ${HOME}/.bashrc
	@mkdir -p "$(CONFIG)"
	@cp "$(SOURCE)/.workspace" "$(ENV)" && echo "export WORKSPACE=$(PWD)" >> "$(ENV)"

.PHONY: git
git:
	@cp "$(SOURCE)/.gitmessage" "${HOME}/.gitmessage"
	@cp "$(SOURCE)/.gitconfig" "${HOME}/.gitconfig"

.PHONY: zsh
zsh:
	@echo "Installing ZSH: $$(zsh --version)"
	@if [ ! -d "${ZSH}" ]; then $(GIT) clone https://github.com/ohmyzsh/ohmyzsh.git "${ZSH}"; fi
	@cp "$(SOURCE)/.zshrc" "${HOME}/.zshrc"
	@chsh -s $(shell which zsh)
	@echo "Installing ZSH plugins/themes"
	@if [ ! -d "${ZSH_CUSTOM}/themes/powerlevel10k" ]; then $(GIT) clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM}/themes/powerlevel10k"; fi
	@if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ]; then $(GIT) clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"; fi
	@if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" ]; then $(GIT) clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"; fi

.PHONY: p10k
p10k:
	@echo "Configuring p10k"
	@cp "$(SOURCE)/.p10k.zsh" "${HOME}/.p10k.zsh"

.PHONY: tmux
tmux:
	@echo "Configuring tmux: $$(tmux -V)"
	@cp -r "$(SOURCE)/.tmux" "${HOME}/.tmux"
	@rm -f "${HOME}/.tmux.conf" && ln -s "${HOME}/.tmux/.tmux.conf" "${HOME}/.tmux.conf"
	@if [ ! -f "${HOME}/.tmux.conf.local" ]; then cp "$(SOURCE)/.tmux/.tmux.conf.local" "${HOME}/.tmux.conf.local"; fi

.PHONY: vim
vim:
	@echo "Configuring $$(vim --version)"
	@cp "$(SOURCE)/.vimrc"  "${HOME}/.vimrc"
	@mkdir -p "${HOME}/.vim/colors"
	@cp -a "$(SOURCE)/.vim/colors/." "${HOME}/.vim/colors"
	@if [ ! -d "${HOME}/.vim/bundle/Vundle.vim" ]; then $(GIT) clone https://github.com/VundleVim/Vundle.vim.git "${HOME}/.vim/bundle/Vundle.vim"; fi
	@vim +PluginInstall +qall

.PHONY: update
update: $(ENV)
	@cd "${WORKSPACE}" && $(GIT) pull

.PHONY: uninstall
uninstall: $(ENV)
	@rm -rf "${WORKSPACE}"
	@rm -rf "$(CONFIG)"

# Docker

.PHONY: build
build:
	$(DOCKER) build -t $(DOCKER_IMAGE) .

.PHONY: run
run:
	$(DOCKER) run --rm \
		-v "$(SOURCE)":/home/appuser/src \
		-v "$(PWD)/Makefile":/home/appuser/Makefile \
		--name $(DOCKER_IMAGE) -it $(DOCKER_IMAGE) bash
