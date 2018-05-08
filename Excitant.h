#import <objc/runtime.h>
#import <AVFoundation/AVFoundation.h>
#include <spawn.h>

@interface Auxtivator : NSObject
-(void)AUXtoggleFlash;
-(void)AUXtoggleLPM;
-(void)AUXtoggleAirplaneMode;
-(void)AUXtoggleMute;
-(void)AUXtoggleRotationLock;
-(void)AUXcontrolCenter;
-(void)AUXrespring;
-(void)AUXlaunchApp:(id)arg1;
@end

@interface _CDBatterySaver : NSObject
+(id)batterySaver;
-(BOOL)getPowerMode;
-(BOOL)setPowerMode:(long long)arg1 error:(id *)arg2;
@end

@interface SBOrientationLockManager	: NSObject
+(instancetype)sharedInstance;
-(BOOL)isUserLocked;
-(void)lock;
-(void)unlock;
@end

@interface SBAirplaneModeController : NSObject
+(id)sharedInstance;
-(BOOL)isInAirplaneMode;
-(void)setInAirplaneMode:(BOOL)arg1;
@end

@interface MNRingerSwitchObserver : NSObject
+(id)sharedInstance;
-(BOOL)ringerSwitchEnabled;
-(void)setRingerSwitchEnabled:(BOOL)arg1;
@end

@interface SBControlCenterController : NSObject
+(id)sharedInstance;
-(void)presentAnimated:(BOOL)arg1;
@end