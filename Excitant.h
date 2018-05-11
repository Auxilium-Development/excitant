#import <objc/runtime.h>
#import <AVFoundation/AVFoundation.h>
#include <spawn.h>
#include <libexcitant.h>

@interface ExcitantWindow : UIWindow
@end

@interface ExcitantView : UIView
@end

@interface UIStatusBarWindow : UIWindow
//-(void)respring;
-(void)check;
@end

@interface FBSystemService : NSObject
+(id)sharedInstance;
-(void)shutdownAndReboot:(BOOL)arg1;
@end

