FROM archlinux

ENV METHOD=aes-128-gcm
ENV PASS=defaultpassxQd
ENV V2_PATH=/v2api
ENV PORT=80

RUN echo 'Server = https://mirror.redrock.team/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist \
  && echo '[archlinuxcn]' >> /etc/pacman.conf \
  && echo 'Server = https://repo.archlinuxcn.org/$arch' >> /etc/pacman.conf \
  && pacman -Sy && pacman-key --init \
  && pacman -S --noconfirm archlinuxcn-keyring \
  && pacman -S --noconfirm nginx shadowsocks-rust-opt-git \
  && yes|pacman -Scc

COPY start.sh /start.sh
COPY simple-plugin /usr/bin/simple-plugin
COPY nginx.conf /data/nginx.conf

RUN chmod +x /start.sh && chmod +x /usr/bin/simple-plugin

CMD /start.sh
