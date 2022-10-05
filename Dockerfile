FROM ubuntu:latest

RUN useradd -ms /bin/bash marlin
USER marlin

USER root
# SETTINGS TIMEZONE
ENV TZ=Asia/Dubai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# MINIMAL REQUIREMENT PACKAGES
RUN apt-get update
RUN apt-get upgrade -y 
RUN apt-get install -y apt-utils
RUN apt-get install -y zstd gawk wget git-core diffstat unzip texinfo gcc gcc-multilib glibc-source build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev xterm python3-subunit mesa-common-dev liblz4-tool
RUN apt-get install -y make xsltproc docbook-utils fop dblatex xmlto
RUN apt-get install -y libmpc-dev libgmp-dev bsdmainutils gcc-multilib libssl-dev libpcre3-dev libffi-dev
RUN apt-get install -y libpcre3-dev libffi-dev libgdk-pixbuf-2.0-0 rsync
RUN apt-get install -y libncurses-dev libelf-dev libegl1-mesa libsdl1.2-dev lz4
RUN apt-get install -y repo
RUN repo version
RUN apt-get install -y language-pack-en-base

# DISTRIBUTION PACKAGE
USER marlin
RUN pip3 install pylint
WORKDIR ./STM32MPU_Ecosystem-v4.0.0/Distribution-Package/openstlinux-5.15-yocto-kirkstone-mp1-v22.06.15
RUN mkdir -p /STM32MPU_Ecosystem-v4.0.0/Distribution-Package/openstlinux-5.15-yocto-kirkstone-mp1-v22.06.15
RUN git config --global user.email "marlin@mail.ru" && git config --global user.name "marlin"
USER root
RUN ls && chmod -R a+rwx /STM32MPU_Ecosystem-v4.0.0/
RUN repo init -u https://github.com/STMicroelectronics/oe-manifest.git -b refs/tags/openstlinux-5.15-yocto-kirkstone-mp1-v22.06.15 && repo sync 
USER marlin
#CMD DISTRO=openstlinux-weston MACHINE=stm32mp1 source layers/meta-st/scripts/envsetup.sh && bitbake st-image-weston

# DEVELOPER PACKAGE
#ADD en.SDK-x86_64-stm32mp1-openstlinux-5.15-yocto-kirkstone-mp1-v22.06.15.tar.xz ./STM32MPU_Ecosystem-v4.0.0/Developer-Package
#RUN chmod +x ./STM32MPU_Ecosystem-v4.0.0/Developer-Package/stm32mp1-openstlinux-5.15-yocto-kirkstone-mp1-v22.06.15/sdk/st-image-weston-openstlinux-weston-stm32mp1-x86_64-toolchain-4.0.1-openstlinux-5.15-yocto-kirkstone-mp1-v22.06.15.sh
#RUN ./STM32MPU_Ecosystem-v4.0.0/Developer-Package/stm32mp1-openstlinux-5.15-yocto-kirkstone-mp1-v22.06.15/sdk/st-image-weston-openstlinux-weston-stm32mp1-x86_64-toolchain-4.0.1-openstlinux-5.15-yocto-kirkstone-mp1-v22.06.15.sh -d ./STM32MPU_Ecosystem-v4.0.0/Developer-Package/SDK


CMD ["echo", "End preparing!"]
