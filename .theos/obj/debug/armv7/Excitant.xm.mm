#line 1 "Excitant.xm"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <FrontBoardServices/FBSSystemService.h>
#import <spawn.h>
#import <notify.h>
#import <sys/wait.h>

#include <Excitant.h>

#define PLIST_PATH @"/opt/projects/excitant/taptivatorprefs/entry.plist"
#define HomeHijack_PATH @"/Library/PreferenceLoader/Preferences/HomeHijack.plist"

inline bool GetPrefBool(NSString *key) {
return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] boolValue];
}

inline int GetPrefInt(NSString *key) {
return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] intValue];
}

inline float GetPrefFloat(NSString *key) {
return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] floatValue];
}



#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class SBControlCenterController; @class UIStatusBarWindow; @class SBOrientationLockManager; @class SBHomeHardwareButtonActions; @class FBSystemService; 
static void (*_logos_orig$_ungrouped$SBHomeHardwareButtonActions$performTriplePressUpActions)(_LOGOS_SELF_TYPE_NORMAL SBHomeHardwareButtonActions* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBHomeHardwareButtonActions$performTriplePressUpActions(_LOGOS_SELF_TYPE_NORMAL SBHomeHardwareButtonActions* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$UIStatusBarWindow$TapTapUtils(_LOGOS_SELF_TYPE_NORMAL UIStatusBarWindow* _LOGOS_SELF_CONST, SEL); static UIStatusBarWindow* (*_logos_orig$_ungrouped$UIStatusBarWindow$initWithFrame$)(_LOGOS_SELF_TYPE_INIT UIStatusBarWindow*, SEL, CGRect) _LOGOS_RETURN_RETAINED; static UIStatusBarWindow* _logos_method$_ungrouped$UIStatusBarWindow$initWithFrame$(_LOGOS_SELF_TYPE_INIT UIStatusBarWindow*, SEL, CGRect) _LOGOS_RETURN_RETAINED; 
static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$SBControlCenterController(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("SBControlCenterController"); } return _klass; }static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$SBOrientationLockManager(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("SBOrientationLockManager"); } return _klass; }static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$FBSystemService(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("FBSystemService"); } return _klass; }
#line 26 "Excitant.xm"
@implementation Excitant

-(void)AUXtoggleFlash {
AVCaptureDevice *flashLight = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
if ([flashLight isTorchAvailable] && [flashLight isTorchModeSupported:AVCaptureTorchModeOn]) {
	BOOL success = [flashLight lockForConfiguration:nil];
		if (success) {
			if (flashLight.torchMode == AVCaptureTorchModeOn) {
				[flashLight setTorchMode:AVCaptureTorchModeOff];
			} else {
				[flashLight setTorchMode:AVCaptureTorchModeOn];
			}
			[flashLight unlockForConfiguration];
		}
	}
}

-(void)AUXtoggleLPM {
	if([[objc_getClass("_CDBatterySaver") batterySaver] getPowerMode] == 1){
		[[objc_getClass("_CDBatterySaver") batterySaver] setPowerMode:0 error:nil];
	}else{
		[[objc_getClass("_CDBatterySaver") batterySaver] setPowerMode:1 error:nil];
	}
}

-(void)AUXtoggleAirplaneMode {
	SBAirplaneModeController *airplaneManager = [objc_getClass("SBAirplaneModeController") sharedInstance];
	if ([airplaneManager isInAirplaneMode]) {
		[airplaneManager setInAirplaneMode:0];
	} else {
		[airplaneManager setInAirplaneMode:1];

	}
}

-(void)AUXtoggleMute {
	MNRingerSwitchObserver *muteManager = [objc_getClass("MNRingerSwitchObserver") sharedInstance];
	if ([muteManager ringerSwitchEnabled]) {
		[muteManager setRingerSwitchEnabled:0];
	} else {
		[muteManager setRingerSwitchEnabled:1];
	}
}

-(void)AUXtoggleRotationLock {
	SBOrientationLockManager *orientationManager = [_logos_static_class_lookup$SBOrientationLockManager() sharedInstance];
	if ([orientationManager isUserLocked]) {
		[orientationManager unlock];
	} else {
		[orientationManager lock];
	}
}

-(void)AUXcontrolCenter {
	[[_logos_static_class_lookup$SBControlCenterController() sharedInstance] presentAnimated:TRUE];
}

-(void)AUXrespring {
	pid_t pid;
    int status;
    const char* args[] = {"killall", "-9", "backboardd", NULL};
    posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
    waitpid(pid, &status, WEXITED);
}

-(void)AUXlaunchApp:(id)arg1 {	
	[[UIApplication sharedApplication] launchApplicationWithIdentifier:arg1 suspended:FALSE];
}

@end



static void _logos_method$_ungrouped$SBHomeHardwareButtonActions$performTriplePressUpActions(_LOGOS_SELF_TYPE_NORMAL SBHomeHardwareButtonActions* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	[Excitant AUXcontrolCenter];
}































static void _logos_method$_ungrouped$UIStatusBarWindow$TapTapUtils(_LOGOS_SELF_TYPE_NORMAL UIStatusBarWindow* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	UIAlertController *confirmationAlertController = [UIAlertController
                                    alertControllerWithTitle:@"TapTapUtils"
                                    message:@"Please pick an option"
                                    preferredStyle:UIAlertControllerStyleAlert];



        UIAlertAction* confirmRespring = [UIAlertAction
                                    actionWithTitle:@"Respring"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        notify_post("com.clarke1234.taptaprespring");
                                    }];

        UIAlertAction* confirmUiCache = [UIAlertAction
                                    actionWithTitle:@"Uicache"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        notify_post("com.clarke1234.taptapuicache");
                                    }];

		UIAlertAction* confirmReboot = [UIAlertAction
									actionWithTitle:@"Reboot"
									style:UIAlertActionStyleDefault
									handler:^(UIAlertAction * action)
									{
										notify_post("com.clarke1234.taptapreboot");
									}];

		UIAlertAction* confirmSafemode = [UIAlertAction
									actionWithTitle:@"Safemode"
									style:UIAlertActionStyleDefault
									handler:^(UIAlertAction * action)
									{
										notify_post("com.clarke1234.taptapsafemode");
									}];

		UIAlertAction* confirmShutdown = [UIAlertAction
									actionWithTitle:@"Shutdown"
									style:UIAlertActionStyleDefault
									handler:^(UIAlertAction * action)
									{
										notify_post("com.clarke1234.taptapshutdown");
									}];

		UIAlertAction* confirmCancel = [UIAlertAction
									actionWithTitle:@"Cancel"
									style:UIAlertActionStyleDefault
									handler:^(UIAlertAction * action)
									{
										
									}];

		UIAlertAction* confirmSleep = [UIAlertAction
                                    actionWithTitle:@"Sleep"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        notify_post("com.kietha.taptapsleep");
                                    }];

		if (GetPrefBool(@"uicache")){
        	[confirmationAlertController addAction:confirmUiCache];
		}
		if (GetPrefBool(@"respring")){
	        [confirmationAlertController addAction:confirmRespring];
		}
		if (GetPrefBool(@"reboot")){
			[confirmationAlertController addAction:confirmReboot];
		}
		if (GetPrefBool(@"safemode")){
			[confirmationAlertController addAction:confirmSafemode];
		}
		if (GetPrefBool(@"shutdown")){
			[confirmationAlertController addAction:confirmShutdown];
		}
		if (GetPrefBool(@"sleep")){
			[confirmationAlertController addAction:confirmSleep];
		}
		[confirmationAlertController addAction:confirmCancel];

        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:confirmationAlertController animated:YES completion:NULL];
}


static UIStatusBarWindow* _logos_method$_ungrouped$UIStatusBarWindow$initWithFrame$(_LOGOS_SELF_TYPE_INIT UIStatusBarWindow* __unused self, SEL __unused _cmd, CGRect frame) _LOGOS_RETURN_RETAINED {
    self = _logos_orig$_ungrouped$UIStatusBarWindow$initWithFrame$(self, _cmd, frame);

    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(check)];
    tapRecognizer.numberOfTapsRequired = 2;
    [self addGestureRecognizer:tapRecognizer];

    return self;
}







static __attribute__((constructor)) void _logosLocalCtor_0bbbf4f8(int __unused argc, char __unused **argv, char __unused **envp){
	NSString *currentID = NSBundle.mainBundle.bundleIdentifier;
	
	
	
	
	
	
	
	if ([currentID isEqualToString:@"com.apple.springboard"]) {
		int regToken;
		notify_register_dispatch("com.clarke1234.taptaprespring", &regToken, dispatch_get_main_queue(), ^(int token) {
			pid_t pid;
			int status;
			const char* args[] = {"killall", "-9", "backboardd", NULL};
			posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
			waitpid(pid, &status, WEXITED);

		});
		notify_register_dispatch("com.clarke1234.taptapuicache", &regToken, dispatch_get_main_queue(), ^(int token){
			pid_t pid;
			int status;
			const char* args[] = {"uicache", NULL, NULL, NULL};
			posix_spawn(&pid, "/usr/bin/uicache", NULL, NULL, (char* const*)args, NULL);
			waitpid(pid, &status, WEXITED);
				CFRunLoopRunInMode(kCFRunLoopDefaultMode, 20.0, false);
		});
		notify_register_dispatch("com.clarke1234.taptapreboot", &regToken, dispatch_get_main_queue(), ^(int token){
			[[_logos_static_class_lookup$FBSystemService() sharedInstance] shutdownAndReboot:YES];
		});
		notify_register_dispatch("com.clarke1234.taptapsafemode", &regToken, dispatch_get_main_queue(), ^(int token){
			pid_t pid;
			int status;
			const char* args[] = {"killall", "-SEGV", "SpringBoard", NULL};
			posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
			waitpid(pid, &status, WEXITED);
		});
		notify_register_dispatch("com.clarke1234.taptapshutdown", &regToken, dispatch_get_main_queue(), ^(int token){
			[[_logos_static_class_lookup$FBSystemService() sharedInstance] shutdownAndReboot:NO];
		});
		notify_register_dispatch("com.kietha.taptapsleep", &regToken, dispatch_get_main_queue(), ^(int token){
             [[objc_getClass("SBBacklightController") sharedInstance] _startFadeOutAnimationFromLockSource:1];
        });

}
}
static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBHomeHardwareButtonActions = objc_getClass("SBHomeHardwareButtonActions"); MSHookMessageEx(_logos_class$_ungrouped$SBHomeHardwareButtonActions, @selector(performTriplePressUpActions), (IMP)&_logos_method$_ungrouped$SBHomeHardwareButtonActions$performTriplePressUpActions, (IMP*)&_logos_orig$_ungrouped$SBHomeHardwareButtonActions$performTriplePressUpActions);Class _logos_class$_ungrouped$UIStatusBarWindow = objc_getClass("UIStatusBarWindow"); { char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$UIStatusBarWindow, @selector(TapTapUtils), (IMP)&_logos_method$_ungrouped$UIStatusBarWindow$TapTapUtils, _typeEncoding); }MSHookMessageEx(_logos_class$_ungrouped$UIStatusBarWindow, @selector(initWithFrame:), (IMP)&_logos_method$_ungrouped$UIStatusBarWindow$initWithFrame$, (IMP*)&_logos_orig$_ungrouped$UIStatusBarWindow$initWithFrame$);} }
#line 283 "Excitant.xm"
