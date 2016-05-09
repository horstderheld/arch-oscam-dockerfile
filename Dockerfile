FROM pritunl/archlinux:latest

# install GIT and base-devel both needed for aur
RUN pacman -Syu --noconfirm --needed git base-devel

# no sudo password for users in wheel group
RUN sed -i 's/# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/g' /etc/sudoers

# create docker user
RUN useradd -m -G wheel docker
WORKDIR /home/docker

# the default user is now "docker" and so commands requiring root permissions
# should be prefixed with sudo from now on
USER docker

# go to tmp dir
RUN     cd /tmp  && \
        # clone git
        git clone https://aur.archlinux.org/oscam-svn/ && \
        # go to cloned dir
        cd oscam-svn && \
        # build package
        makepkg -s --noconfirm && \
        # install package
        sudo pacman -U --noconfirm oscam-svn-*-x86_64.pkg.tar.xz && \
        # remove cloned dir in tmp
        sudo rm -R /tmp/oscam-svn

#Expose Ports
EXPOSE 8321
EXPOSE 9000
