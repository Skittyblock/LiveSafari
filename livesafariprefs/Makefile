include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = LiveSafari

LiveSafari_FILES = LSFRootListController.m
LiveSafari_INSTALL_PATH = /Library/PreferenceBundles
LiveSafari_FRAMEWORKS = UIKit
LiveSafari_PRIVATE_FRAMEWORKS = Preferences
LiveSafari_CFLAGS = -fobjc-arc
LiveSafari_LIBRARIES = imagepicker

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/LiveSafari.plist$(ECHO_END)
