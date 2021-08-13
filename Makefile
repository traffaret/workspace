.DEFAULT_GOAL := all

DOCKER := docker
DOCKER_IMAGE := "workspace-local-dev"

GIT := git
WORKSPACE := $$(pwd)/src

export ZSH := ${HOME}/.oh-my-zsh
export ZSH_CUSTOM := ${ZSH}/custom

.PHONY: all
all: home zsh vim mc tmux dircolors

.PHONY: home
home:
	@echo "Configuring BASH"
	@cp "$(WORKSPACE)/.bashrc" ${HOME}/.bashrc
	@cp "$(WORKSPACE)/.gitmessage" "${HOME}/.gitmessage"
	@cp "$(WORKSPACE)/.gitconfig" "${HOME}/.gitconfig"

.PHONY:  zsh
zsh:
	@echo "Installing ZSH: $$(zsh --version)"
	@if [ ! -d "${ZSH}" ]; then $(GIT) clone https://github.com/ohmyzsh/ohmyzsh.git "${ZSH}"; fi
	@cp "$(WORKSPACE)/.zshrc" "${HOME}/.zshrc"
	@chsh -s $(shell which zsh)
	@echo "Installing ZSH plugins/themes"
	@if [ ! -d "${ZSH_CUSTOM}/themes/powerlevel10k" ]; then $(GIT) clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM}/themes/powerlevel10k"; fi
	@if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ]; then $(GIT) clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"; fi
	@if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" ]; then $(GIT) clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"; fi

.PHONY: tmux
tmux:
	@echo "Configuring tmux: $$(tmux -V)"
	@cp -r "$(WORKSPACE)/.tmux" "${HOME}/.tmux"
	@rm -f "${HOME}/.tmux.conf" && ln -s "$(WORKSPACE)/.tmux/.tmux.conf" "${HOME}/.tmux.conf"
	@if [ ! -f "${HOME}/.tmux.conf.local" ]; then cp "$(WORKSPACE)/.tmux/.tmux.conf.local" "${HOME}/.tmux.conf.local"; fi
	@if [ ! -d "${HOME}/.tmux/themes/nord-tmux" ]; then $(GIT) clone --depth=1 https://github.com/arcticicestudio/nord-tmux.git "${HOME}/.tmux/themes/nord-tmux"; fi

.PHONY: vim
vim:
	@echo "Configuring $$(vim --version)"
	@cp "$(WORKSPACE)/.vimrc"  "${HOME}/.vimrc"
	@if [ ! -d "${HOME}/.vim/bundle/Vundle.vim" ]; then $(GIT) clone https://github.com/VundleVim/Vundle.vim.git "${HOME}/.vim/bundle/Vundle.vim"; fi
	@vim +PluginInstall +qall

.PHONY: mc
mc:
	@echo "Configuring $$(mc --version)"
	@cp -r "$(WORKSPACE)/.mc" "${HOME}"/.mc

dircolors:
	@echo "Configuring dircolors"
	@dircolors && (if [ ! -d "$(WORKSPACE)/custom/nord-dircolors" ]; then $(GIT) clone https://github.com/arcticicestudio/nord-dircolors.git "$(WORKSPACE)/custom/nord-dircolors"; fi) && ln -s "$(WORKSPACE)/custom/nord-dircolors/src/dir_colors" "${HOME}/.dircolors"

.PHONY: uninstall
uninstall:
	@rm -rf "${ZSH}"
	@rm -f "${HOME}/.zshrc"
	@rm -rf "${HOME}/.tmux"
	@rm -f "${HOME}/.tmux.conf.local"
	@rm -f "${HOME}/.tmux.conf"
	@rm -rf "${HOME}/.vim"
	@rm -f "${HOME}/.vimrc"
	@rm -rf "${HOME}/.mc"
	@rm -f "${HOME}/.dircolors"

# Docker

.PHONY: build
build:
	$(DOCKER) build -t $(DOCKER_IMAGE) .

.PHONY: run
run:
	$(DOCKER) run --rm \
		-v "$$(pwd)/src":/home/appuser/.workspace:rw \
		--name $(DOCKER_IMAGE) -it $(DOCKER_IMAGE) bash
