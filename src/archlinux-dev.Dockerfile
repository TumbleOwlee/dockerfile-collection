FROM archlinux:latest
# Install basic setup
RUN pacman -Sy --noconfirm git rust neovim clang ctags libx11 rust-analyzer tmux base-devel sudo go skim
# Add user
RUN useradd -m owlee && usermod -G wheel owlee && echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
# Change to user 
USER owlee
WORKDIR /home/owlee
# Install yay for AUR
RUN git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -s && sudo pacman -U --noconfirm yay*.zst && cd .. && rm -r yay*
# Install typescript LSP from AUR
RUN yay -S --noconfirm typescript-language-server
RUN yay -Syyu --noconfirm
# Setup Neovim
RUN git clone https://github.com/TumbleOwlee/neovim-config.git && mkdir -p ~/.config/ && mv neovim-config ~/.config/nvim
RUN nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerInstall' 2>&1 >/dev/null
