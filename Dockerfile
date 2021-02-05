FROM archlinux
RUN pacman --noconfirm -Syu && pacman --noconfirm -S kube-scheduler
