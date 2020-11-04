TARGET = iphone:clang::7.0
ARCHS = armv7 arm64 arm64e

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = LiveSafari
LiveSafari_FILES = Tweak.xm
LiveSafari_FRAMEWORKS = CoreLocation

include $(THEOS_MAKE_PATH)/tweak.mk
