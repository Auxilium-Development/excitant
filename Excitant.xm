#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <FrontBoardServices/FBSSystemService.h>
#import <spawn.h>
#import <notify.h>
#import <sys/wait.h>
#import "AppList.h"

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


@implementation Excitant

+(void)AUXtoggleFlash {
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

+(void)AUXtoggleLPM {
	if([[objc_getClass("_CDBatterySaver") batterySaver] getPowerMode] == 1){
		[[objc_getClass("_CDBatterySaver") batterySaver] setPowerMode:0 error:nil];
	}else{
		[[objc_getClass("_CDBatterySaver") batterySaver] setPowerMode:1 error:nil];
	}
}

+(void)AUXtoggleAirplaneMode {
	SBAirplaneModeController *airplaneManager = [objc_getClass("SBAirplaneModeController") sharedInstance];
	if ([airplaneManager isInAirplaneMode]) {
		[airplaneManager setInAirplaneMode:0];
	} else {
		[airplaneManager setInAirplaneMode:1];

	}
}

+(void)AUXtoggleMute {
	MNRingerSwitchObserver *muteManager = [objc_getClass("MNRingerSwitchObserver") sharedInstance];
	if ([muteManager ringerSwitchEnabled]) {
		[muteManager setRingerSwitchEnabled:0];
	} else {
		[muteManager setRingerSwitchEnabled:1];
	}
}

+(void)AUXtoggleRotationLock {
	SBOrientationLockManager *orientationManager = [%c(SBOrientationLockManager) sharedInstance];
	if ([orientationManager isUserLocked]) {
		[orientationManager unlock];
	} else {
		[orientationManager lock];
	}
}

+(void)AUXcontrolCenter {
	[[%c(SBControlCenterController) sharedInstance] presentAnimated:TRUE];
}

+(void)AUXrespring {
	pid_t pid;
    int status;
    const char* args[] = {"killall", "-9", "backboardd", NULL};
    posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
    waitpid(pid, &status, WEXITED);
}

+(void)AUXlaunchApp:(id)arg1 {	//Before calling, save bundle id to (AUXapp)
	[[UIApplication sharedApplication] launchApplicationWithIdentifier:arg1 suspended:FALSE];
}

/*-(void)AUXhomePress {
	[[objc_getClass("SpringBoard") sharedApplication] _simulateHomeButtonPress];
}*/

@end

// Example //
// %hook SBHomeHardwareButtonActions
// -(void)performTriplePressUpActions{
// 	[Excitant AUXtoggleFlash];
// }
// %end
// Example


// TapTapUtils Shit
// NSNumber* uicache;
// NSNumber* respring;
// NSNumber* rebootd;
// NSNumber* safemode;
// NSNumber* shutdownd;
// NSNumber* sleepdd;
//TapTapUtilsShit







//TapTapUtils
%hook UIStatusBarWindow

%new

-(void)TapTapUtils{
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
										//Do nothing
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


- (instancetype)initWithFrame:(CGRect)frame {
    self = %orig;

    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapTapUtils)];
    tapRecognizer.numberOfTapsRequired = 2;
    [self addGestureRecognizer:tapRecognizer];

    return self;
}


%end



//Prefs for TapTapUtils
%ctor{
	NSString *currentID = NSBundle.mainBundle.bundleIdentifier;
	//NSDictionary *settings = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.clarke1234.taptivatorprefs.plist"];
	// uicache = [settings objectForKey:@"uicache"];
	// respring = [settings objectForKey:@"respring"];
	// rebootd = [settings objectForKey:@"reboot"];
	// safemode = [settings objectForKey:@"safemode"];
	// shutdownd = [settings objectForKey:@"shutdown"];
	// sleepdd = [settings objectForKey:@"sleep"];
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
			[[%c(FBSystemService) sharedInstance] shutdownAndReboot:YES];
		});
		notify_register_dispatch("com.clarke1234.taptapsafemode", &regToken, dispatch_get_main_queue(), ^(int token){
			pid_t pid;
			int status;
			const char* args[] = {"killall", "-SEGV", "SpringBoard", NULL};
			posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
			waitpid(pid, &status, WEXITED);
		});
		notify_register_dispatch("com.clarke1234.taptapshutdown", &regToken, dispatch_get_main_queue(), ^(int token){
			[[%c(FBSystemService) sharedInstance] shutdownAndReboot:NO];
		});
		notify_register_dispatch("com.kietha.taptapsleep", &regToken, dispatch_get_main_queue(), ^(int token){
             [[objc_getClass("SBBacklightController") sharedInstance] _startFadeOutAnimationFromLockSource:1];
        });

}
}
