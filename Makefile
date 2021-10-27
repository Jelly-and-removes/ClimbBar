debug:
	xcodebuild \
	-sdk iphoneos \
	-configuration Debug \
	-project ClimbBarExample.xcodeproj \
	-scheme ClimbBar \
	build CODE_SIGNING_ALLOWED=NO

build-app:
	xcodebuild \
	-sdk iphoneos \
	-configuration Debug \
	-project ClimbBarExample.xcodeproj \
	-scheme ClimbBarExample \
	build CODE_SIGNING_ALLOWED=NO
