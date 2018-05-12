#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <FrontBoardServices/FBSSystemService.h>
#import <spawn.h>
#import <notify.h>
#import <sys/wait.h>
#import "AppList.h"


#include <Excitant.h>
#include <libexcitant.h>

#define PLIST_PATH @"/var/mobile/Library/Preferences/EXCITANTTAPS.plist"
#define EXCITANTTOUCHES_PATH @"/var/mobile/Library/Preferences/EXCITANTTOUCHES.plist"
// Status Bar Shit
inline bool GetPrefBool(NSString *key) {
return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] boolValue];
}

inline int GetPrefInt(NSString *key) {
return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] intValue];
}

inline float GetPrefFloat(NSString *key) {
return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] floatValue];
}
//Loading for UIView taps
inline bool GetTouchBool(NSString *key) {
return [[[NSDictionary dictionaryWithContentsOfFile:EXCITANTTOUCHES_PATH] valueForKey:key] boolValue];
}
inline float GetTouchFloats(NSString *key) {
return [[[NSDictionary dictionaryWithContentsOfFile:EXCITANTTOUCHES_PATH] valueForKey:key] floatValue];
}
static NSString *tapapp;
// End the Status Bar Shit
//HomeHijack Stuff
static NSString *selectedApp; //Applist stuff
static NSString *tapLaunch; //TripleTap Launcher
static NSString *volUp; //Volume Up String
static NSString *volDown; //Volume Down String

static void loadSiriPrefs() { //Siri Version applist
NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/EXCITANTTOUCHES.plist"];
selectedApp = [prefs objectForKey:@"siriApp"]; //Setting up variables
}

static void loadPrefsTriTap() { //Triple Tap version
NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/EXCITANTTOUCHES.plist"];
tapLaunch = [prefs objectForKey:@"homeTriTap"]; //Setting up variables
}

static void loadPrefsVolUp() { //Triple Tap version
NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/EXCITANTTOUCHES.plist"];
volUp = [prefs objectForKey:@"volUp"]; //Setting up variables
}

static void loadPrefsVolDown() { //Triple Tap version
NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/EXCITANTTOUCHES.plist"];
volDown = [prefs objectForKey:@"volDown"]; //Setting up variables
}

//Mute Switch Prefs
NSString *switchpath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/com.chilaxan.ezswitchprefs.plist"];
NSDictionary *switchsettings = [NSMutableDictionary dictionaryWithContentsOfFile:switchpath];

static BOOL isEzSwitchEnabled = (BOOL)[[switchsettings objectForKey:@"switchenabled"]?:@TRUE boolValue];
static NSInteger switchPreference = (NSInteger)[[switchsettings objectForKey:@"switchPreferences"]?:@9 integerValue];
//End Mute Switch Prefs

//Touches Prefs
inline bool GetPrefTouchesBool(NSString *key) {
return [[[NSDictionary dictionaryWithContentsOfFile:EXCITANTTOUCHES_PATH] valueForKey:key] boolValue]; //Looks for bool
}

//Touches Applist
static NSString *touchesRightBottom;
static NSString *touchesRightMiddle;
static NSString *touchesRightTop;
static NSString *touchesLeftBottom;
static NSString *touchesLeftMiddle;
static NSString *touchesLeftTop;

static void loadPrefsTouchesRightBottom() { //Triple Tap version
NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/EXCITANTTOUCHES.plist"];
touchesRightBottom = [prefs objectForKey:@"touchesAppRightBottom"]; //Setting up variables
}

static void loadPrefsTouchesLeftBottom() { //Triple Tap version
NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/EXCITANTTOUCHES.plist"];
touchesLeftBottom = [prefs objectForKey:@"touchesAppLeftBottom"]; //Setting up variables
}

static void loadPrefsTouchesLeftMiddle() { //Triple Tap version
NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/EXCITANTTOUCHES.plist"];
touchesLeftMiddle = [prefs objectForKey:@"touchesAppLeftMiddle"]; //Setting up variables
}

static void loadPrefsTouchesRightMiddle() { //Triple Tap version
NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/EXCITANTTOUCHES.plist"];
touchesRightMiddle = [prefs objectForKey:@"touchesAppRightMiddle"]; //Setting up variables
}

static void loadPrefsTouchesRightTop() { //Triple Tap version
NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/EXCITANTTOUCHES.plist"];
touchesRightTop = [prefs objectForKey:@"touchesAppRightTop"]; //Setting up variables
}

static void loadPrefsTouchesLeftTop() { //Triple Tap version
NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/EXCITANTTOUCHES.plist"];
touchesLeftTop = [prefs objectForKey:@"touchesAppLeftTop"]; //Setting up variables
}



@implementation ExcitantWindow
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    for (UIWindow *window in self.subviews) {
        if (!window.hidden && window.userInteractionEnabled && [window pointInside:[self convertPoint:point toView:window] withEvent:event])
            return YES;
    }
    return NO;
}
@end

@implementation ExcitantView
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


//Just hard coding in some gesture recognizers

ExcitantView *rightBottomView;
ExcitantView *leftBottomView;
ExcitantView *rightMiddleView;
ExcitantView *leftMiddleView;
ExcitantView *leftTopView;
ExcitantView *rightTopView;
// dont use global, there is almost never reason to use it


%hook SpringBoard
-(void)applicationDidFinishLaunching:(id)application {
	float width = GetTouchFloats(@"vWidth");
    float height = GetTouchFloats(@"vHeight");

    %orig;
		UIWindow * screen = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];

		rightBottomView=[[ExcitantView alloc]initWithFrame:CGRectMake(screen.bounds.size.width, screen.bounds.size.height, - width, - height)];
			if(GetPrefTouchesBool(@"setColor")){
				[rightBottomView setBackgroundColor:[UIColor redColor]];
			}else{
				[rightBottomView setBackgroundColor:[UIColor colorWithWhite:0.001 alpha:0.001]];
			}
	    [rightBottomView setAlpha: 1];
			[rightBottomView setHidden:NO];
	    rightBottomView.userInteractionEnabled = TRUE;

		  leftBottomView=[[ExcitantView alloc]initWithFrame:CGRectMake(screen.bounds.origin.x, screen.bounds.size.height, width, - height)];
			if(GetPrefTouchesBool(@"setColor")){
				[leftBottomView setBackgroundColor:[UIColor redColor]];
			}else{
			[leftBottomView setBackgroundColor:[UIColor colorWithWhite:0.001 alpha:0.001]];
		  }
	    [leftBottomView setAlpha: 1];
			[leftBottomView setHidden:NO];
	    leftBottomView.userInteractionEnabled = TRUE;

			rightMiddleView=[[ExcitantView alloc]initWithFrame:CGRectMake(screen.bounds.size.width, screen.bounds.size.height*.60, - width, - height)];
				if(GetPrefTouchesBool(@"setColor")){
					[rightMiddleView setBackgroundColor:[UIColor blueColor]];
				}else{
					[rightMiddleView setBackgroundColor:[UIColor colorWithWhite:0.001 alpha:0.001]];
				}
		    [rightMiddleView setAlpha: 1];
				[rightMiddleView setHidden:NO];
		    rightMiddleView.userInteractionEnabled = TRUE;

			leftMiddleView=[[ExcitantView alloc]initWithFrame:CGRectMake(screen.bounds.origin.x, screen.bounds.size.height*.60, width, - height)];
				if(GetPrefTouchesBool(@"setColor")){
					[leftMiddleView setBackgroundColor:[UIColor blueColor]];
				}else{
				[leftMiddleView setBackgroundColor:[UIColor colorWithWhite:0.001 alpha:0.001]];
			  }
		    [leftMiddleView setAlpha: 1];
				[leftMiddleView setHidden:NO];
		    leftMiddleView.userInteractionEnabled = TRUE;

				rightTopView=[[ExcitantView alloc]initWithFrame:CGRectMake(screen.bounds.size.width, screen.bounds.size.height*0.001, - width,  height)];
					if(GetPrefTouchesBool(@"setColor")){
						[rightTopView setBackgroundColor:[UIColor greenColor]];
					}else{
						[rightTopView setBackgroundColor:[UIColor colorWithWhite:0.001 alpha:0.001]];
					}
			    [rightTopView setAlpha: 1];
					[rightTopView setHidden:NO];
			    rightTopView.userInteractionEnabled = TRUE;

				leftTopView=[[ExcitantView alloc]initWithFrame:CGRectMake(screen.bounds.origin.x, screen.bounds.size.height*0.001, width,  height)];
					if(GetPrefTouchesBool(@"setColor")){
						[leftTopView setBackgroundColor:[UIColor greenColor]];
					}else{
					[leftTopView setBackgroundColor:[UIColor colorWithWhite:0.001 alpha:0.001]];
				  }
			    [leftTopView setAlpha: 1];
					[leftTopView setHidden:NO];
			    leftTopView.userInteractionEnabled = TRUE;

		ExcitantWindow *window = [[ExcitantWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
		window.windowLevel = 1005;
		[window setHidden:NO];
		[window setAlpha:1.0];
		[window setBackgroundColor:[UIColor clearColor]];
        if(GetTouchBool(@"enableRB")){
        [window addSubview:rightBottomView];
    }else {nil;}
      if(GetTouchBool(@"enableRM")){
		[window addSubview:rightMiddleView];
    }else {nil;}
       if(GetTouchBool(@"enableRT")){
		[window addSubview:rightTopView];
    }else {nil;}
       if(GetTouchBool(@"enableLB")){
		[window addSubview:leftBottomView];
    }else {nil;}
       if(GetTouchBool(@"enableLM")){
		[window addSubview:leftMiddleView];
    }else {nil;}
       if(GetTouchBool(@"enableLT")){
		[window addSubview:leftTopView];
    }else {nil;}

/*UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapTapUtils)];
tapRecognizer.numberOfTapsRequired = 2;
[self addGestureRecognizer:tapRecognizer];*/


		UITapGestureRecognizer *rightBottomRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TouchRecognizerBottomRight:)];
		if(GetPrefTouchesBool(@"taps2")){
	    rightBottomRecognizer.numberOfTapsRequired = 2;
			[rightBottomView addGestureRecognizer:rightBottomRecognizer];
		}else if(GetPrefTouchesBool(@"taps3")){
			rightBottomRecognizer.numberOfTapsRequired = 3;
			[rightBottomView addGestureRecognizer:rightBottomRecognizer];
		}else if (GetPrefTouchesBool(@"taps4")){
			rightBottomRecognizer.numberOfTapsRequired = 4;
			[rightBottomView addGestureRecognizer:rightBottomRecognizer];
		}else{
			rightBottomRecognizer.numberOfTapsRequired = 1;
	    [rightBottomView addGestureRecognizer:rightBottomRecognizer];
		}

		UITapGestureRecognizer *leftBottomRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TouchRecognizerBottomLeft:)];
		if(GetPrefTouchesBool(@"taps2")){
			leftBottomRecognizer.numberOfTapsRequired = 2;
			[leftBottomView addGestureRecognizer:leftBottomRecognizer];
		}else if(GetPrefTouchesBool(@"taps3")){
			leftBottomRecognizer.numberOfTapsRequired = 3;
			[leftBottomView addGestureRecognizer:leftBottomRecognizer];
		}else if (GetPrefTouchesBool(@"taps4")){
			leftBottomRecognizer.numberOfTapsRequired = 4;
			[leftBottomView addGestureRecognizer:leftBottomRecognizer];
		}else{
			leftBottomRecognizer.numberOfTapsRequired = 1;
			[leftBottomView addGestureRecognizer:leftBottomRecognizer];
		}

		UITapGestureRecognizer *leftMiddleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TouchRecognizerLeftMiddle:)];
		if(GetPrefTouchesBool(@"taps2")){
			leftMiddleRecognizer.numberOfTapsRequired = 2;
			[leftMiddleView addGestureRecognizer:leftMiddleRecognizer];
		}else if(GetPrefTouchesBool(@"taps3")){
			leftMiddleRecognizer.numberOfTapsRequired = 3;
			[leftMiddleView addGestureRecognizer:leftMiddleRecognizer];
		}else if (GetPrefTouchesBool(@"taps4")){
			leftMiddleRecognizer.numberOfTapsRequired = 4;
			[leftMiddleView addGestureRecognizer:leftMiddleRecognizer];
		}else{
			leftMiddleRecognizer.numberOfTapsRequired = 1;
			[leftMiddleView addGestureRecognizer:leftMiddleRecognizer];
		}

		UITapGestureRecognizer *rightMiddleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TouchRecognizerRightMiddle:)];
		if(GetPrefTouchesBool(@"taps2")){
			rightMiddleRecognizer.numberOfTapsRequired = 2;
			[rightMiddleView addGestureRecognizer:rightMiddleRecognizer];
		}else if(GetPrefTouchesBool(@"taps3")){
			rightMiddleRecognizer.numberOfTapsRequired = 3;
			[rightMiddleView addGestureRecognizer:rightMiddleRecognizer];
		}else if (GetPrefTouchesBool(@"taps4")){
			rightMiddleRecognizer.numberOfTapsRequired = 4;
			[rightMiddleView addGestureRecognizer:rightMiddleRecognizer];
		}else{
			rightMiddleRecognizer.numberOfTapsRequired = 1;
			[rightMiddleView addGestureRecognizer:rightMiddleRecognizer];
		}

		UITapGestureRecognizer *leftTopRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TouchRecognizerLeftTop:)];
		if(GetPrefTouchesBool(@"taps2")){
			leftTopRecognizer.numberOfTapsRequired = 2;
			[leftTopView addGestureRecognizer:leftTopRecognizer];
		}else if(GetPrefTouchesBool(@"taps3")){
			leftTopRecognizer.numberOfTapsRequired = 3;
			[leftTopView addGestureRecognizer:leftTopRecognizer];
		}else if (GetPrefTouchesBool(@"taps4")){
			leftTopRecognizer.numberOfTapsRequired = 4;
			[leftTopView addGestureRecognizer:leftTopRecognizer];
		}else{
			leftTopRecognizer.numberOfTapsRequired = 1;
			[leftTopView addGestureRecognizer:leftTopRecognizer];
		}

		UITapGestureRecognizer *rightTopRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TouchRecognizerRightTop:)];
		if(GetPrefTouchesBool(@"taps2")){
			rightTopRecognizer.numberOfTapsRequired = 2;
			[rightTopView addGestureRecognizer:rightTopRecognizer];
		}else if(GetPrefTouchesBool(@"taps3")){
			rightTopRecognizer.numberOfTapsRequired = 3;
			[rightTopView addGestureRecognizer:rightTopRecognizer];
		}else if (GetPrefTouchesBool(@"taps4")){
			rightTopRecognizer.numberOfTapsRequired = 4;
			[rightTopView addGestureRecognizer:rightTopRecognizer];
		}else{
			rightTopRecognizer.numberOfTapsRequired = 1;
			[rightTopView addGestureRecognizer:rightTopRecognizer];
		}

		[[NSNotificationCenter defaultCenter] addObserver:self
                                         selector:@selector(keyboardDidShow:)
                                             name:UIKeyboardDidShowNotification
                                           object:nil];

		[[NSNotificationCenter defaultCenter] addObserver:self
                                         selector:@selector(keyboardDidHide:)
                                             name:UIKeyboardDidHideNotification
                                           object:nil];
}

//Mute Switch Function
- (void)_updateRingerState:(int)arg1 withVisuals:(BOOL)arg2 updatePreferenceRegister:(BOOL)arg3 {
	if(arg1) {
		if (isEzSwitchEnabled) {
			if (switchPreference == 0) {
				[Excitant AUXtoggleFlash];
				}
			if (switchPreference == 1){
				[Excitant AUXtoggleLPM];
			}
			if (switchPreference == 2) {
                [Excitant AUXtoggleAirplaneMode];
			}
            if (switchPreference == 3) {
                [Excitant AUXtoggleMute]; //DOES NOT WORK YET
			}
			if (switchPreference == 4) {
                [Excitant AUXtoggleRotationLock];
			}
		} else {
			%orig;
		}
	}
}
//End Mute Switch Function

%new
- (void) TouchRecognizerBottomRight:(UITapGestureRecognizer *)sender {
	loadPrefsTouchesRightBottom();
	[Excitant AUXlaunchApp:touchesRightBottom];
}
//what else is there?

%new
- (void) TouchRecognizerBottomLeft:(UITapGestureRecognizer *)sender {
	loadPrefsTouchesLeftBottom();
	[Excitant AUXlaunchApp:touchesLeftBottom];
}
%new
- (void) TouchRecognizerLeftMiddle:(UITapGestureRecognizer *)sender {
	loadPrefsTouchesLeftMiddle();
	[Excitant AUXlaunchApp:touchesLeftMiddle];
}
%new
- (void) TouchRecognizerRightMiddle:(UITapGestureRecognizer *)sender {
	loadPrefsTouchesRightMiddle();
	[Excitant AUXlaunchApp:touchesRightMiddle];
}
%new
- (void) TouchRecognizerLeftTop:(UITapGestureRecognizer *)sender {
	loadPrefsTouchesLeftTop();
	[Excitant AUXlaunchApp:touchesLeftTop];
}
%new
- (void) TouchRecognizerRightTop:(UITapGestureRecognizer *)sender {
	loadPrefsTouchesRightTop();
	[Excitant AUXlaunchApp:touchesRightTop];
}
%new
-(void)keyboardDidShow:(NSNotification *)hideViews {
  rightBottomView.hidden = YES;
  leftBottomView.hidden = YES;
  rightMiddleView.hidden = YES;
  leftMiddleView.hidden = YES;
  leftTopView.hidden = YES;
  rightTopView.hidden = YES;
}
%new
-(void)keyboardDidHide:(NSNotification *)showViews {
  rightBottomView.hidden = NO;
  leftBottomView.hidden = NO;
  rightMiddleView.hidden = NO;
  leftMiddleView.hidden = NO;
  leftTopView.hidden = NO;
  rightTopView.hidden = NO;
}



%end


//Start HomeHijack
%hook SBAssistantController
-(void)_viewWillAppearOnMainScreen:(BOOL)arg1{
    loadSiriPrefs();
    if(GetTouchBool(@"kCC")){
        [Excitant AUXcontrolCenter];
        %orig;
    }else if (GetTouchBool(@"kSiriRespring")){
      [Excitant AUXrespring];
    }else if(selectedApp != nil){
        [Excitant AUXlaunchApp:selectedApp];
        %orig(NO);
      }else if(GetTouchBool(@"kSiriFlash")){
        //Flashlight
            [Excitant AUXtoggleFlash];
          }else if (GetTouchBool(@"kSiriBat")){
              [Excitant AUXtoggleLPM];
              }else{
        %orig;
    }
}

%end

%hook SBAssistantWindow
-(id)initWithScreen:(id)arg1 layoutStrategy:(id)arg2 debugName:(id)arg3 scene:(id)arg4 {
    loadSiriPrefs();
    if (selectedApp !=nil) {
        return NULL;
    }else if(GetTouchBool(@"kCC")){
        return NULL;
    }else if (GetTouchBool(@"kSiriBat")){
        return NULL;
    }else if(GetTouchBool(@"kSiriFlash")){
        return NULL;
    }else{
        return %orig;
    }
}
%end

%hook SBHomeHardwareButtonActions
-(void)performTriplePressUpActions{
  loadPrefsTriTap();
  if (GetTouchBool(@"kRespring")){
    [Excitant AUXrespring];
  }else if (GetTouchBool(@"kCCTap")){
    [Excitant AUXcontrolCenter];
  }else if (tapLaunch != nil){
    [Excitant AUXlaunchApp:tapLaunch];
    }else if(GetTouchBool(@"kTapFlash")){
    //Flashlight
        [Excitant AUXtoggleFlash];
      }
      else if (GetTouchBool(@"kTapBat")){
        [Excitant AUXtoggleLPM];
        }else{
    %orig;
  }
}
%end

%hook VolumeControl //Volume Up Controller
-(void)increaseVolume{
  loadPrefsVolUp();

  //Battery Saver
  if(GetTouchBool(@"kVolUpBat")){
      [Excitant AUXtoggleLPM];

      }else if(GetTouchBool(@"kVolUpRespring")){
      [Excitant AUXrespring];

      }else if(GetTouchBool(@"kVolUpCC")){
        [Excitant AUXcontrolCenter];

      }else if(GetTouchBool(@"kVolUpFlash")){
      //Flashlight
          [Excitant AUXtoggleFlash];
    }
    else if (volUp != nil) {
      [Excitant AUXlaunchApp:volUp];
    }
    else{
      %orig;
    }
}


%end

%hook VolumeControl //Volume Up Controller
-(void)decreaseVolume{
  loadPrefsVolDown();

  //Battery Saver
  if(GetTouchBool(@"kVolDownBat")){
      [Excitant AUXtoggleLPM];
      }else if(GetTouchBool(@"kVolDownRespring")){
      [Excitant AUXrespring];
      }else if(GetTouchBool(@"kVolDownCC")){
        [Excitant AUXcontrolCenter];
      }else if(GetTouchBool(@"kVolDownFlash")){
      //Flashlight
          [Excitant AUXtoggleFlash];
    }
    else if (volDown != nil) {
      [Excitant AUXlaunchApp:volDown];
    }
    else{
      %orig;
    }

}

%end
//End HomeHijack



/* Tony was here
If you're reading this listen to this xxxtentacion playlist:

*/


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

%new

-(void)flash{
	[Excitant AUXtoggleFlash];
}

%new

-(void)lpm{
	[Excitant AUXtoggleLPM];
}

%new

-(void)apm{
	[Excitant AUXtoggleAirplaneMode];
}

%new

-(void)rotationLock{
	[Excitant AUXtoggleRotationLock];
}

%new

-(void)controlCenter{
	[Excitant AUXcontrolCenter];
}

%new

-(void)respring{
	[Excitant AUXrespring];
}

%new

-(void)lockDevice{
	[Excitant AUXlockDevice];
}
%new

- (void)launchApp {
	NSDictionary *Tapprefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/EXCITANTTAPS.plist"];
	tapapp = [Tapprefs objectForKey:@"launchAppTap"]; //doesnt work
	[Excitant AUXlaunchApp:tapapp];
}



- (instancetype)initWithFrame:(CGRect)frame {
    self = %orig;
	int taps;
	if(GetPrefBool(@"taptaps2")){
		taps = 2;
	}
	else if(GetPrefBool(@"taptaps3")){
		taps = 3;
	}
	else if(GetPrefBool(@"taptaps4")){
		taps = 4;
	}
	else {
		taps = 2;
	}
    if(GetPrefBool(@"enableUtils")){
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapTapUtils)];
        tapRecognizer.numberOfTapsRequired = taps;
        [self addGestureRecognizer:tapRecognizer];

        //return self;
    }
	if(GetPrefBool(@"enableFlash")){
		UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flash)];
        tapRecognizer.numberOfTapsRequired = taps;
        [self addGestureRecognizer:tapRecognizer];
	}
	if(GetPrefBool(@"enableLPM")){
		UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lpm)];
        tapRecognizer.numberOfTapsRequired = taps;
        [self addGestureRecognizer:tapRecognizer];
	}
	if(GetPrefBool(@"enableAPM")){
		UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(apm)];
        tapRecognizer.numberOfTapsRequired = taps;
        [self addGestureRecognizer:tapRecognizer];
	}
	if(GetPrefBool(@"enableRL")){
		UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rotationLock)];
        tapRecognizer.numberOfTapsRequired = taps;
        [self addGestureRecognizer:tapRecognizer];
	}
	if(GetPrefBool(@"enableCC")){
		UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(controlCenter)];
        tapRecognizer.numberOfTapsRequired = taps;
        [self addGestureRecognizer:tapRecognizer];
	}
	if(GetPrefBool(@"enableRespring")){
		UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respring)];
        tapRecognizer.numberOfTapsRequired = taps;
        [self addGestureRecognizer:tapRecognizer];
	}
	if(GetPrefBool(@"enableSleep")){
		UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lockDevice)];
        tapRecognizer.numberOfTapsRequired = taps;
        [self addGestureRecognizer:tapRecognizer];
	}
	if(GetPrefBool(@"enableAppTap")){
		UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(launchApp)];
        tapRecognizer.numberOfTapsRequired = taps;
        [self addGestureRecognizer:tapRecognizer];
	}
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
			[Excitant AUXreboot];
		});
		notify_register_dispatch("com.clarke1234.taptapsafemode", &regToken, dispatch_get_main_queue(), ^(int token){
			pid_t pid;
			int status;
			const char* args[] = {"killall", "-SEGV", "SpringBoard", NULL};
			posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
			waitpid(pid, &status, WEXITED);
		});
		notify_register_dispatch("com.clarke1234.taptapshutdown", &regToken, dispatch_get_main_queue(), ^(int token){
			[Excitant AUXshutdown];
		});
		notify_register_dispatch("com.kietha.taptapsleep", &regToken, dispatch_get_main_queue(), ^(int token){
             [Excitant AUXlockDevice];
        });

}
}
