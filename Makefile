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
all: home git zsh vim mc tmux dircolors

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

.PHONY:  zsh
zsh:
	@echo "Installing ZSH: $$(zsh --version)"
	@if [ ! -d "${ZSH}" ]; then $(GIT) clone https://github.com/ohmyzsh/ohmyzsh.git "${ZSH}"; fi
	@cp "$(SOURCE)/.zshrc" "${HOME}/.zshrc"
	@chsh -s $(shell which zsh)
	@echo "Installing ZSH plugins/themes"
	@if [ ! -d "${ZSH_CUSTOM}/themes/powerlevel10k" ]; then $(GIT) clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM}/themes/powerlevel10k"; fi
	@if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ]; then $(GIT) clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"; fi
	@if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" ]; then $(GIT) clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"; fi

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
	@if [ ! -d "${HOME}/.vim/bundle/Vundle.vim" ]; then $(GIT) clone https://github.com/VundleVim/Vundle.vim.git "${HOME}/.vim/bundle/Vundle.vim"; fi
	@vim +PluginInstall +qall

.PHONY: mc
mc:
	@echo "Configuring $$(mc --version)"
	@cp -r "$(SOURCE)/.mc" "${HOME}"/.mc

.PHONY: dircolors
dircolors:
	@echo "Configuring dircolors"
	@dircolors && (if [ ! -d "$(SOURCE)/custom/nord-dircolors" ]; then $(GIT) clone https://github.com/arcticicestudio/nord-dircolors.git "$(SOURCE)/custom/nord-dircolors"; fi)
	@ln -s "$(SOURCE)/custom/nord-dircolors/src/dir_colors" "${HOME}/.dircolors" &>/dev/null

.PHONY: update
update: $(ENV)
	@cd "${WORKSPACE}" && $(GIT) pull

.PHONY: uninstall
uninstall: $(ENV)
	@rm -rf "${ZSH}"
	@rm -f "${HOME}/.gitmessage"
	@rm -f "${HOME}/.gitconfig"
	@rm -f "${HOME}/.zshrc"
	@rm -rf "${HOME}/.tmux"
	@rm -f "${HOME}/.tmux.conf.local"
	@rm -f "${HOME}/.tmux.conf"
	@rm -rf "${HOME}/.vim"
	@rm -f "${HOME}/.vimrc"
	@rm -rf "${HOME}/.mc"
	@rm -f "${HOME}/.dircolors"
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
