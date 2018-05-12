#import <objc/runtime.h>
#import <AVFoundation/AVFoundation.h>
#include <spawn.h>

@interface ExcitantWindow : UIWindow
@end

@interface ExcitantView : UIView
@end

@interface UIStatusBarWindow : UIWindow
-(void)check;
@end