FROM archlinux

COPY start.sh /start.sh
COPY nginx.conf /data/nginx.conf

RUN echo 'Server = https://mirror.redrock.team/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist \
  && pacman -Sy && pacman -S --noconfirm nginx shadowsocks-libev shadowsocks-v2ray-plugin \
  && chmod +x /start.sh

CMD /start.sh
