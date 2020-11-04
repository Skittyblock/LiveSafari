// LiveSafari Headers

#import <CoreLocation/CoreLocation.h>

@interface SBIcon : NSObject
- (id)leafIdentifier;
@end

@interface SBIconImageView : UIView
@property (nonatomic, readonly) double continuousCornerRadius; 
- (UIImage *)squareContentsImage;
- (UIImage *)_currentOverlayImage; // removed in iOS 14
@end

@interface SBLiveIconImageView : SBIconImageView
- (void)updateImageAnimated:(BOOL)arg1;
- (void)setIcon:(id)arg1 location:(long long)arg2 animated:(BOOL)arg3;
- (void)updateUnanimated;
- (void)updateAnimatingState;
- (BOOL)isAnimationAllowed;
- (void)prepareForReuse;
- (id)snapshot;
- (void)setPaused:(BOOL)arg1;
@end

@interface SBSafariIconImageView : SBLiveIconImageView <CLLocationManagerDelegate>
@property (nonatomic,retain) CLLocationManager *locationManager;
@property (nonatomic, retain) UIImageView *needle;
- (void)test;
@end
