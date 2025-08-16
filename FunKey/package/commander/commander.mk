#############################################################
#
# commander
#
#############################################################
COMMANDER_VERSION = HEAD
COMMANDER_SITE_METHOD = git
COMMANDER_SITE = https://github.com/DrUm78/commander.git
COMMANDER_LICENSE = GPL-2.0

COMMANDER_DEPENDENCIES = sdl sdl_ttf sdl_gfx

COMMANDER_CONF_OPTS = -DCMAKE_BUILD_TYPE=Release -DTARGET_PLATFORM="funkey-s" -DRES_DIR=""
#COMMANDER_CONF_OPTS += -DWITH_SYSTEM_SDL_GFX=ON -DWITH_SYSTEM_SDL_TTF=ON

define COMMANDER_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/bin/commander
	cd $(@D); \
	$(INSTALL) -D -m 0755 -t $(TARGET_DIR)/usr/bin/commander \
		commander \
		res/file-image.png \
		res/file-ipk.png \
		res/file-is-symlink.png \
		res/file-opk.png \
		res/file-text.png \
		res/folder.png res/up.png \
		res/DroidSansFallback.ttf \
		res/Fiery_Turk.ttf \
		res/FreeSans.ttf \
		res/libSDL-1.2.so.0.11.4
endef

define COMMANDER_CREATE_OPK
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/local/share/OPKs/Applications
	$(HOST_DIR)/usr/bin/mksquashfs $(COMMANDER_PKGDIR)/opk $(TARGET_DIR)/usr/local/share/OPKs/Applications/commander_funkey-s.opk -all-root -noappend -no-exports -no-xattrs
endef
COMMANDER_POST_INSTALL_TARGET_HOOKS += COMMANDER_CREATE_OPK

$(eval $(cmake-package))
