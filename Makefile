ARCHS = arm64 armv7
include theos/makefiles/common.mk

TWEAK_NAME = AlwaysTouchID
AlwaysTouchID_FILES = Tweak.xm
AlwaysTouchID_FRAMEWORKS = UIKit AudioToolbox
AlwaysTouchID_PRIVATE_FRAMEWORKS = BiometricKit GraphicsServices

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
