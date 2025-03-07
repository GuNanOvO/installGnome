#!/bin/bash

# 一键安装 GNOME 桌面环境的脚本
# 适用于 openEuler 22.03 LTS 系统
# 请确保已配置 Everything 源和 EPOL 源，并以 root 权限运行

# 检查是否以 root 权限运行
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root! Use 'sudo' or switch to the root user."
    exit 1
fi

echo "Starting GNOME desktop environment installation..."

# 1. 更新软件源
echo "Updating software sources..."
dnf update -y
if [ $? -ne 0 ]; then
    echo "Failed to update software sources. Please check your network or source configuration and try again."
    exit 1
fi

# 2. 安装常用字体
echo "Installing fonts..."
dnf install -y dejavu-fonts liberation-fonts gnu-*-fonts google-*-fonts
if [ $? -ne 0 ]; then
    echo "Font installation failed. Please check the software source or network connection."
    exit 1
fi

# 3. 安装 Xorg 相关组件（精简版，避免安装过多无用包）
echo "Installing Xorg..."
dnf install -y xorg-x11-apps xorg-x11-drivers xorg-x11-drv-ati \
xorg-x11-drv-dummy xorg-x11-drv-evdev xorg-x11-drv-fbdev xorg-x11-drv-intel \
xorg-x11-drv-libinput xorg-x11-drv-nouveau xorg-x11-drv-qxl \
xorg-x11-drv-synaptics-legacy xorg-x11-drv-v4l xorg-x11-drv-vesa \
xorg-x11-drv-vmware xorg-x11-drv-wacom xorg-x11-fonts xorg-x11-fonts-others \
xorg-x11-font-utils xorg-x11-server xorg-x11-server-utils xorg-x11-server-Xephyr \
xorg-x11-server-Xspice xorg-x11-util-macros xorg-x11-utils xorg-x11-xauth \
xorg-x11-xbitmaps xorg-x11-xinit xorg-x11-xkb-utils
if [ $? -ne 0 ]; then
    echo "Xorg installation failed. Please check the software source or network connection."
    exit 1
fi

# 4. 安装 GNOME 及相关组件
echo "Installing GNOME desktop environment..."
dnf install -y adwaita-icon-theme atk atkmm at-spi2-atk at-spi2-core baobab \
abattis-cantarell-fonts cheese clutter clutter-gst3 clutter-gtk cogl dconf \
dconf-editor devhelp eog epiphany evince evolution-data-server file-roller folks \
gcab gcr gdk-pixbuf2 gdm gedit geocode-glib gfbgraph gjs glib2 glibmm24 \
glib-networking gmime30 gnome-autoar gnome-backgrounds gnome-bluetooth \
gnome-builder gnome-calculator gnome-calendar gnome-characters \
gnome-clocks gnome-color-manager gnome-contacts gnome-control-center \
gnome-desktop3 gnome-disk-utility gnome-font-viewer gnome-getting-started-docs \
gnome-initial-setup gnome-keyring gnome-logs gnome-menus gnome-music \
gnome-online-accounts gnome-online-miners gnome-photos gnome-remote-desktop \
gnome-screenshot gnome-session gnome-settings-daemon gnome-shell \
gnome-shell-extensions gnome-software gnome-system-monitor gnome-terminal \
gnome-tour gnome-user-docs gnome-user-share gnome-video-effects \
gnome-weather gobject-introspection gom grilo grilo-plugins \
gsettings-desktop-schemas gsound gspell gssdp gtk3 gtk4 gtk-doc gtkmm30 \
gtksourceview4 gtk-vnc2 gupnp gupnp-av gupnp-dlna gvfs json-glib libchamplain \
libdazzle libgdata libgee libgnomekbd libgsf libgtop2 libgweather libgxps libhandy \
libmediaart libnma libnotify libpeas librsvg2 libsecret libsigc++20 libsoup \
mm-common mutter nautilus orca pango pangomm libphodav python3-pyatspi \
python3-gobject rest rygel simple-scan sushi sysprof tepl totem totem-pl-parser \
tracker3 tracker3-miners vala vte291 yelp yelp-tools yelp-xsl zenity
if [ $? -ne 0 ]; then
    echo "GNOME installation failed. Please check the software source or network connection."
    exit 1
fi

# 5. 设置以图形界面启动
echo "Setting system to boot into graphical mode..."
systemctl set-default graphical.target
if [ $? -ne 0 ]; then
    echo "Failed to set graphical mode. Please check systemctl settings manually."
    exit 1
fi

# 6. 完成提示
echo "GNOME desktop environment installation completed!"
echo "Please reboot the system to enter the graphical interface: sudo reboot"

exit 0
