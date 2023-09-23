################################################################################
#
# gmu
#
################################################################################

GMU_VERSION = v1.0-funkey-s
GMU_SITE_METHOD = git
GMU_SITE = https://github.com/DrUm78/gmu.git
GMU_LICENSE = GPL-2.1+
GMU_LICENSE_FILES = LICENSE

GMU_DEPENDENCIES = sdl

define GMU_BUILD_CMDS
	(cd $(@D); \
	sed -i -e 's|rm -rf|#rm -rf|g' package; \
	sed -i -e 's|make -f Makefile.funkey clean|#make -f Makefile.funkey clean|g' package; \
	sed -i -n '61i LIBS+=$(LIBS_SDLFE)' Makefile.funkey; \
	sed -i -e 's|/opt/FunKey-sdk/bin/arm-funkey-linux-musleabihf-gcc|../../host/usr/bin/arm-linux-gcc|g' funkey.mk; \
	sed -i -e 's|/opt/FunKey-sdk/arm-funkey-linux-musleabihf/sysroot|../../host/arm-funkey-linux-musleabihf/sysroot|g' funkey.mk; \
	chmod +x package; \
	./package \
	)
endef

define GMU_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/bin/gmu/decoders
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/bin/gmu/frontends
	$(INSTALL) -m 0755 $(@D)/opk/gmu $(TARGET_DIR)/usr/bin/gmu
	$(INSTALL) -m 0755 $(@D)/opk/decoders/* $(TARGET_DIR)/usr/bin/gmu/decoders
	$(INSTALL) -m 0755 $(@D)/opk/frontends/* $(TARGET_DIR)/usr/bin/gmu/frontends
endef

define GMU_CREATE_OPK
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/local/share/OPKs/Applications
	$(HOST_DIR)/usr/bin/mksquashfs $(GMU_PKGDIR)/opk $(TARGET_DIR)/usr/local/share/OPKs/Applications/gmu_funkey-s.opk -all-root -noappend -no-exports -no-xattrs
endef
GMU_POST_INSTALL_TARGET_HOOKS += GMU_CREATE_OPK

$(eval $(generic-package))
