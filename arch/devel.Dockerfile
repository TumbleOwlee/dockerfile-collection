FROM archlinux:latest
# Install basic setup
RUN pacman -Sy --noconfirm git libx11 base-devel sudo go && \
    useradd -m owlee && usermod -G wheel owlee && echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER owlee
WORKDIR /tmp
RUN git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -s && sudo pacman -U --noconfirm yay*.zst && cd .. && rm -r yay* && \
    IS_VM=y NO_CONFIRM=y bash -c "bash <(curl https://raw.githubusercontent.com/TumbleOwlee/env-setup/main/Unix/setup.sh 2>/dev/null)"
WORKDIR /home/owlee
ENTRYPOINT ["/usr/bin/fish"]
