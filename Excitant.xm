#include <Auxtivator.h>

@implementation Auxtivator

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
		[muteManager setRingerSwitchEnabled:0]
	} else {
		[muteManager setRingerSwitchEnabled:1]
	}
}

-(void)AUXtoggleRotationLock {
	SBOrientationLockManager *orientationManager = [%c(SBOrientationLockManager) sharedInstance];
	if ([orientationManager isUserLocked]) {
		[orientationManager unlock];
	} else {
		[orientationManager lock];
	}
}

-(void)AUXcontrolCenter {
	[[%c(SBControlCenterController) sharedInstance] presentAnimated:TRUE];
}

-(void)AUXrespring {
	pid_t pid;
    int status;
    const char* args[] = {"killall", "-9", "backboardd", NULL};
    posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
    waitpid(pid, &status, WEXITED);
}

-(void)AUXlaunchApp:(id)arg1 {	//Before calling, save bundle id to (AUXapp)
	[[UIApplication sharedApplication] launchApplicationWithIdentifier:arg1 suspended:FALSE];
}

@end