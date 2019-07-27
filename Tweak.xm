// LiveSafari, by Skitty
// Turn Safari's icon into a real compass

#import "Tweak.h"

%subclass SBSafariIconImageView : SBLiveIconImageView
%property (nonatomic, retain) CLLocationManager *locationManager;
%property (nonatomic, retain) UIImageView *needle;
- (UIImage *)contentsImage {
  UIImage *img = [UIImage imageWithContentsOfFile:@"/Library/Application Support/LiveSafari/background.png"];

  UIImage *maskImg = [UIImage imageWithData:UIImageJPEGRepresentation([self _currentOverlayImage], 1)];

  CGImageRef maskRef = maskImg.CGImage;
  CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef), CGImageGetHeight(maskRef), CGImageGetBitsPerComponent(maskRef), CGImageGetBitsPerPixel(maskRef), CGImageGetBytesPerRow(maskRef), CGImageGetDataProvider(maskRef), NULL, false);
  CGImageRef masked = CGImageCreateWithMask([img CGImage], mask);

  return [UIImage imageWithCGImage:masked];
}
- (void)setIcon:(id)arg1 location:(long long)arg2 animated:(BOOL)arg3 {
  %orig;

  if (!self.needle) {
    self.needle = [[UIImageView
 alloc] initWithImage:[UIImage imageWithContentsOfFile:@"/Library/Application Support/LiveSafari/needle.png"]];
    [self.needle setCenter:self.center];
    [self addSubview:self.needle];

    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingHeading];
  }
}
- (void)setPaused:(BOOL)paused {
  %orig;
  if (paused) {
    [self.locationManager stopUpdatingLocation];
  } else {
    [self.locationManager startUpdatingLocation];
  }
}
%new
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
  if ([self isAnimationAllowed]) {
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
      self.needle.transform = CGAffineTransformMakeRotation(-newHeading.magneticHeading*M_PI/180);
    } completion:nil];
  }
}
%new
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
  NSLog(@"[LiveSafari] Error: %@", error);
}
%new
- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager {
  return NO;
}
- (void)dealloc {
  [self.locationManager stopUpdatingHeading];
  [self.needle release];
  [self.locationManager release];
  %orig;
}
%end

%hook SBIcon
- (Class)iconImageViewClassForLocation:(long long)arg1 {
  if ([[self leafIdentifier] isEqualToString:@"com.apple.mobilesafari"]) {
    return %c(SBSafariIconImageView);
  }
  return %orig;
}
%end
