FROM archlinux:latest
RUN pacman -Sy --noconfirm git rust neovim clang ctags libx11 rust-analyzer tmux
RUN git clone https://github.com/TumbleOwlee/neovim-config.git
RUN mkdir -p ~/.config/
RUN mv neovim-config ~/.config/nvim
RUN cd ~ && nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerInstall' 2>&1 >/dev/nul
