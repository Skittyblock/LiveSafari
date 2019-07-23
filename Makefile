DEBUG = 0
FINALPACKAGE = 1

ARCHS = armv7 arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = LiveSafari
LiveSafari_FILES = Tweak.xm
LiveSafari_FRAMEWORKS = CoreLocation
LiveSafari_LIBRARIES = imagepicker

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += livesafariprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
