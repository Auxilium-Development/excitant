#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <FrontBoardServices/FBSSystemService.h>
#import <spawn.h>
#import <notify.h>
#import <sys/wait.h>
#import "AppList.h"
#import <Foundation/Foundation.h>
#include <Excitant.h>
#include <libexcitant.h>


//Prefs
@interface NSUserDefaults (Excitant)
- (id)objectForKey:(NSString *)key inDomain:(NSString *)domain;
- (void)setObject:(id)value forKey:(NSString *)key inDomain:(NSString *)domain;
@end

//Define Prefs
static NSString *nsDomainString = @"com.auxilium.excitant";
static NSString *nsNotificationString = @"com.auxilium.excitant/preferences.changed";

/*#define PLIST_PATH @"/var/mobile/Library/Preferences/EXCITANTTAPS.plist"
#define kTapTap (CFStringRef)@"com.auxilium.excitant/preferences.changed"
#define EXCITANTTOUCHES_PATH @"/var/mobile/Library/Preferences/EXCITANTTOUCHES.plist"
#define kVolPath @"/var/mobile/Library/Preferences/com.midnightchips.volume.plist"
#define kHijackSettingsChangedNotification (CFStringRef)@"EXCITANTTOUCHES.plist/saved"
//Testing Lonestar Prefs
#define kIdentifier @"com.midnightchips.volume"
#define kSettingsChangedNotification (CFStringRef)@"com.midnightchips.volume.plist/ReloadPrefs"
#define kSettingsPath @"/var/mobile/Library/Preferences/com.midnightchips.volume.plist"*/
// Status Bar Shit
/*inline bool GetPrefBool(NSString *key) {
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
}*/
/*inline bool GetVolumeBool(NSString *key) {
  return [[[NSDictionary dictionaryWithContentsOfFile:Volume_PATH] valueForKey:key] boolValue];
}
inline float GetTouchFloats(NSString *key) {
  return [[[NSDictionary dictionaryWithContentsOfFile:EXCITANTTOUCHES_PATH] valueForKey:key] floatValue];
}*/
static NSString *tapapp;
// End the Status Bar Shit
//HomeHijack Stuff
static NSString *selectedApp; //Applist stuff
static NSString *tapLaunch; //TripleTap Launcher
static NSString *volUp; //Volume Up String
static NSString *volDown; //Volume Down String
static NSString *switchApp; //EzLauncher Applist




static void loadSwitchApp() { //Siri Version applist
NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.chilaxan.ezswitchprefs"];
switchApp = [prefs objectForKey:@"switchApp"]; //Setting up variables
}



static void loadPrefsVolAppUp() { //volume version applist
NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.midnightchips.volume.plist"];
volUp = [prefs objectForKey:@"volUp"]; //Setting up variables
}

static void loadPrefsVolAppDown() { //volume down applist
NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.midnightchips.volume.plist"];
volDown = [prefs objectForKey:@"volDown"]; //Setting up variables
}
//Prefs
static BOOL enableFlashUP;
static BOOL enableRespringUP;
static BOOL enablePowerUP;
static BOOL enableFlashDown;
static BOOL enableRespringDown;
static BOOL enablePowerDown;
static BOOL enableVolUpSkip;
static BOOL enableVolDownSkip;
static BOOL enableVolUpCC;
static BOOL enableVolDownCC;
//End Vol Prefs
//Start HomeHijack
static BOOL siriCC;
static BOOL siriRespring;
static BOOL siriBat;
static BOOL siriFlash;
static BOOL tritapCC;
static BOOL tritapRespring;
static BOOL tritapBat;
static BOOL tritapFlash;
//End HomeHijack
//Start Touches
static BOOL enableRB;
static BOOL enableRM;
static BOOL enableRT;
static BOOL enableLB;
static BOOL enableLM;
static BOOL enableLT;
static BOOL setColor;
static NSInteger numTaps;
static float height;
static float width;
//End Touches
//Start TapTap
static BOOL taptaps2;
static BOOL taptaps3;
static BOOL taptaps4;
static BOOL enableAppTap;
static BOOL enableUtils;
static BOOL uicache;
static BOOL respring;
static BOOL tapreboot;
static BOOL safemode;
static BOOL shutdown;
static BOOL enableFlash;
static BOOL enableLPM;
static BOOL enableAPM;
static BOOL enableRL;
static BOOL enableCC;
static BOOL enableRespring;
static BOOL enableSleep;
static BOOL tapsleep;
//End Tap TapTap


static void notificationCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {


          //HomeHijack
          NSNumber *enableSiriCC = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"kCC" inDomain:nsDomainString];
          NSNumber *enableSiriRespring = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"kSiriRespring" inDomain:nsDomainString];
          NSNumber *enabelSiriBat = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"kSiriBat" inDomain:nsDomainString];
          NSNumber *enableSiriFlash = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"siriFlash" inDomain:nsDomainString];
          NSNumber *enableTritapCC = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"kCCTap" inDomain:nsDomainString];
          NSNumber *enableTritapRespring = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"kRespring" inDomain:nsDomainString];
          NSNumber *enableTritapBat = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"kTapBat" inDomain:nsDomainString];
          NSNumber *enableTritapFlash = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"kTapFlash" inDomain:nsDomainString];

          siriCC = (enableSiriCC)? [enableSiriCC boolValue]:NO;
          siriRespring = (enableSiriRespring)? [enableSiriRespring boolValue]:NO;
          siriBat = (enabelSiriBat)? [enabelSiriBat boolValue]:NO;
          siriFlash = (enableSiriFlash)? [enableSiriFlash boolValue]:NO;
          tritapCC = (enableTritapCC)? [enableTritapCC boolValue]:NO;
          tritapRespring = (enableTritapRespring)? [enableTritapRespring boolValue]:NO;
          tritapBat = (enableTritapBat)? [enableTritapBat boolValue]:NO;
          tritapFlash = (enableTritapFlash)? [enableTritapFlash boolValue]:NO;
          //End End HomeHijack
          //TapTap
          NSNumber *enabletaptaps2 = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"taptaps2" inDomain:nsDomainString];
          NSNumber *enabletaptaps3 = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"taptaps3" inDomain:nsDomainString];
          NSNumber *enabletaptaps4 = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"taptaps4" inDomain:nsDomainString];
          NSNumber *enablenableAppTap = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"enableAppTap" inDomain:nsDomainString];
          NSNumber *enableenableUtils = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"enableUtils" inDomain:nsDomainString];
          NSNumber *enableuicache = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"uicache" inDomain:nsDomainString];
          NSNumber *enablerespring = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"respring" inDomain:nsDomainString];
          NSNumber *enabletapreboot = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"reboot" inDomain:nsDomainString];
          NSNumber *enablesafemode = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"safemode" inDomain:nsDomainString];
          NSNumber *enableshutdown = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"shutdown" inDomain:nsDomainString];
          NSNumber *enableenableFlash = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"enableFlash" inDomain:nsDomainString];
          NSNumber *enableenableLPM = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"enableLPM" inDomain:nsDomainString];
          NSNumber *enableenableRL = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"enableRL" inDomain:nsDomainString];
          NSNumber *enableenableCC = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"enableCC" inDomain:nsDomainString];
          NSNumber *enableenableRespring = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"enableRespring" inDomain:nsDomainString];
          NSNumber *enableenableSleep = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"sleep" inDomain:nsDomainString];
          NSNumber *enabletapsleep = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"enableSleep" inDomain:nsDomainString];

          taptaps2 = (enabletaptaps2)? [enabletaptaps2 boolValue]:NO;
          taptaps3 = (enabletaptaps3)? [enabletaptaps3 boolValue]:NO;
          taptaps4 = (enabletaptaps4)? [enabletaptaps4 boolValue]:NO;
          enableAppTap = (enablenableAppTap)? [enablenableAppTap boolValue]:NO;
          enableUtils = (enableenableUtils)? [enableenableUtils boolValue]:NO;
          uicache = (enableuicache)? [enableuicache boolValue]:NO;
          respring = (enablerespring)? [enablerespring boolValue]:NO;
          tapreboot = (enabletapreboot)? [enabletapreboot boolValue]:NO;
          safemode = (enablesafemode)? [enablesafemode boolValue]:NO;
          shutdown = (enableshutdown)? [enableshutdown boolValue]:NO;
          enableFlash = (enableenableFlash)? [enableenableFlash boolValue]:NO;
          enableLPM = (enableenableLPM)? [enableenableLPM boolValue]:NO;
          enableRL = (enableenableRL)? [enableenableRL boolValue]:NO;
          enableCC  = (enableenableCC)? [enableenableCC boolValue]:NO;
          enableRespring = (enableenableRespring)? [enableenableRespring boolValue]:NO;
          enableSleep = (enableenableSleep)? [enableenableSleep boolValue]:NO;
          tapsleep = (enabletapsleep)? [enabletapsleep boolValue]:NO;

          //TapTap
          //Start Touches
          NSNumber *senableRB = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"enableUtils" inDomain:nsDomainString];
          NSNumber *senableRM = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"taptaps2" inDomain:nsDomainString];
          NSNumber *senableRT = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"taptaps3" inDomain:nsDomainString];
          NSNumber *senableLB = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"taptaps4" inDomain:nsDomainString];
          NSNumber *senableLM = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"enableAppTap" inDomain:nsDomainString];
          NSNumber *senableLT = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"enableUtils" inDomain:nsDomainString];
          NSNumber *ssetColor = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"taptaps2" inDomain:nsDomainString];
          NSNumber *snumTaps = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"taptaps3" inDomain:nsDomainString];
          NSNumber *sheight = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"taptaps4" inDomain:nsDomainString];
          NSNumber *swidth = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"enableAppTap" inDomain:nsDomainString];

          enableRB = (senableRB)? [senableRB boolValue]:NO;
          enableRM = (senableRM)? [senableRM boolValue]:NO;
          enableRT = (senableRT)? [senableRT boolValue]:NO;
          enableLB = (senableLB)? [senableLB boolValue]:NO;
          enableLM = (senableLM)? [senableLM boolValue]:NO;
          enableLT = (senableLT)? [senableLT boolValue]:NO;
          setColor = (ssetColor)? [ssetColor boolValue]:NO;
          numTaps = (snumTaps)? [snumTaps intValue]:1;
          height = (sheight)? [sheight floatValue]:100.0;
          width = (swidth)? [swidth floatValue]:15.0;
          //End Touches
          //Start Volume
          /*
           enableFlashUP;
           enableRespringUP;
           enablePowerUP;
           enableFlashDown;
           enableRespringDown;
           enablePowerDown;
           enableVolUpSkip;
           enableVolDownSkip;
           enableVolUpCC;
           enableVolDownCC;*/

           NSNumber *senableFlashUP = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"kVolUpFlash" inDomain:nsDomainString];
           NSNumber *senableRespringUP = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"kVolUpRespring" inDomain:nsDomainString];
           NSNumber *senablePowerUP = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"kVolUpBat" inDomain:nsDomainString];
           NSNumber *senableFlashDown = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"kVolDownFlash" inDomain:nsDomainString];
           NSNumber *senableRespringDown = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"kVolDownRespring" inDomain:nsDomainString];
           NSNumber *senablePowerDown = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"kVolDownBat" inDomain:nsDomainString];
           NSNumber *senableVolUpSkip = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"kVolUpSkip" inDomain:nsDomainString];
           NSNumber *senableVolDownSkip = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"kVolDownSkip" inDomain:nsDomainString];
           NSNumber *senableVolUpCC = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"kVolUpCC" inDomain:nsDomainString];
           NSNumber *senableVolDownCC = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"kVolDownCC" inDomain:nsDomainString];

           enableFlashUP = (senableFlashUP)? [senableFlashUP boolValue]:NO;
           enableRespringUP = (senableRespringUP)? [senableRespringUP boolValue]:NO;
           enablePowerUP = (senablePowerUP)? [senablePowerUP boolValue]:NO;
           enableFlashDown = (senableFlashDown)? [senableFlashDown boolValue]:NO;
           enableRespringDown = (senableRespringDown)? [senableRespringDown boolValue]:NO;
           enablePowerDown = (senablePowerDown)? [senablePowerDown boolValue]:NO;
           enableVolUpSkip = (senableVolUpSkip)? [senableVolUpSkip boolValue]:NO;
           enableVolDownSkip = (senableVolDownSkip)? [senableVolDownSkip boolValue]:NO;
           enableVolUpCC = (senableVolUpCC)? [senableVolUpCC boolValue]:NO;
           enableVolDownCC = (senableVolDownCC)? [senableVolDownCC boolValue]:NO;
}




//Mute Switch
NSString *switchpath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/com.chilaxan.ezswitchprefs.plist"];
NSDictionary *switchsettings = [NSMutableDictionary dictionaryWithContentsOfFile:switchpath];

static NSInteger switchPreference = (NSInteger)[[switchsettings objectForKey:@"switchPreferences"]?:@9 integerValue];
//End Mute Switch Prefs

//Touches Prefs
/*inline bool GetPrefTouchesBool(NSString *key) {
return [[[NSDictionary dictionaryWithContentsOfFile:EXCITANTTOUCHES_PATH] valueForKey:key] boolValue]; //Looks for bool
}*/

//Touches Applist
static NSString *touchesRightBottom;
static NSString *touchesRightMiddle;
static NSString *touchesRightTop;
static NSString *touchesLeftBottom;
static NSString *touchesLeftMiddle;
static NSString *touchesLeftTop;


//APPLIST DONT DELETE THESE ONE K THX
static void loadTapApp() { //Triple Tap version
NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/EXCITANTTAPS.plist"];
tapapp = [prefs objectForKey:@"launchTapApp"]; //Setting up variables
}

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
//STILL DONT DELETE THOSE K THX :) ^


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


//Start VolSkip11


%group volFunction
NSTimer *timer;
BOOL volUpButtonIsDown;
BOOL volDownButtonIsDown;

%hook SBVolumeHardwareButtonActions

-(void)volumeIncreasePressDown
{
	//HBLogInfo(@"************volumeIncreasePressDown");


    volUpButtonIsDown = YES;
      timer = [NSTimer scheduledTimerWithTimeInterval: 0.5 target: self selector: @selector(handleTimer:) userInfo: @1 repeats: NO];
}

-(void)volumeIncreasePressUp
{
	//	HBLogInfo(@"************volumeIncreasePressUp");
		timer = nil;

		if(volUpButtonIsDown == YES)
		{
			[[%c(SBMediaController) sharedInstance] _changeVolumeBy:0.062500];
			volUpButtonIsDown = NO;
		}
	}


-(void)volumeDecreasePressDown
{
	//HBLogInfo(@"************volumeDecreasePressDown");
	//if([%c(SBMediaController) applicationCanBeConsideredNowPlaying:[[%c(SBMediaController) sharedInstance] nowPlayingApplication]] == NO)
		volDownButtonIsDown = YES;
	    timer = [NSTimer scheduledTimerWithTimeInterval: 0.5 target: self selector: @selector(handleTimer:) userInfo: @-1 repeats: NO];
}

-(void)volumeDecreasePressUp
{
		//HBLogInfo(@"************volumeDecreasePressUp");

		// [timer invalidate];
		timer = nil;

		if(volDownButtonIsDown == YES)
		{
			[[%c(SBMediaController) sharedInstance] _changeVolumeBy:-0.062500];
			volDownButtonIsDown = NO;

	}
}

%new
-(void)handleTimer:(NSTimer *)timer{
	if( (volUpButtonIsDown == YES && [[timer userInfo] intValue] == 1) || ( volDownButtonIsDown == YES &&[[timer userInfo] intValue] == -1) ) {

    /*static BOOL enableFlashUP
    static BOOL enableRespringUP
    static BOOL enablePowerUP
    static BOOL enableFlashDown
    static BOOL enableRespringDown
    static BOOL enablePowerDown*/
    if ([[timer userInfo] intValue] == 1){
    //Battery Saver
    loadPrefsVolAppUp();
    if(enablePowerUP == YES){
        [Excitant AUXtoggleLPM];
        NSLog(@"Running Toggle");
        volUpButtonIsDown = NO;
    		volDownButtonIsDown = NO;

        }else if(enableRespringUP == YES){
        [Excitant AUXrespring];
        volUpButtonIsDown = NO;
    		volDownButtonIsDown = NO;

        }else if(enableVolUpCC == YES){
          [Excitant AUXcontrolCenter];
          volUpButtonIsDown = NO;
      		volDownButtonIsDown = NO;

        }else if(enableFlashUP == YES){
        //Flashlight
            [Excitant AUXtoggleFlash];
            volUpButtonIsDown = NO;
        		volDownButtonIsDown = NO;
          }
          else if (enableVolUpSkip == YES){
            HBLogInfo(@"************handleTimer");

          [[%c(SBMediaController) sharedInstance] changeTrack:[[timer userInfo] intValue]];
          volUpButtonIsDown = NO;
          volDownButtonIsDown = NO;
      }
      else if (volUp != nil) {
        [Excitant AUXlaunchApp:volUp];
        volUpButtonIsDown = NO;
    		volDownButtonIsDown = NO;

      }else{
      }
      /*static BOOL enableFlashUP
      static BOOL enableRespringUP
      static BOOL enablePowerUP
      static BOOL enableFlashDown
      static BOOL enableRespringDown
      static BOOL enablePowerDown*/
	}else if ([[timer userInfo] intValue] == -1){
    loadPrefsVolAppDown();
    //Battery Saver
    if(enablePowerDown == YES){
        [Excitant AUXtoggleLPM];
        volUpButtonIsDown = NO;
    		volDownButtonIsDown = NO;
        }else if(enableRespringDown == YES){
        [Excitant AUXrespring];
        volUpButtonIsDown = NO;
    		volDownButtonIsDown = NO;
        }else if(enableVolDownCC == YES){
          [Excitant AUXcontrolCenter];
          volUpButtonIsDown = NO;
      		volDownButtonIsDown = NO;
        }else if(enableFlashDown == YES){
        //Flashlight
            [Excitant AUXtoggleFlash];
            volUpButtonIsDown = NO;
        		volDownButtonIsDown = NO;

      }else if (enableVolDownSkip == YES){
        [[%c(SBMediaController) sharedInstance] changeTrack:[[timer userInfo] intValue]];
    		volUpButtonIsDown = NO;
    		volDownButtonIsDown = NO;
      }
      else if (volDown != nil) {
        [Excitant AUXlaunchApp:volDown];
        volUpButtonIsDown = NO;
        volDownButtonIsDown = NO;
      }else{

      }

  }
}
}
%end
%end

//End VolSkip11
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
/* hi */
%group Main
ExcitantView *rightBottomView;
ExcitantView *leftBottomView;
ExcitantView *rightMiddleView;
ExcitantView *leftMiddleView;
ExcitantView *leftTopView;
ExcitantView *rightTopView;
// dont use global, there is almost never reason to use it


%hook SpringBoard
-(void)applicationDidFinishLaunching:(id)application {
  /*
  static BOOL enableRB;
  static BOOL enableRM;
  static BOOL enableRT;
  static BOOL enableLB;
  static BOOL enableLM;
  static BOOL enableLT;
  static BOOL setColor;
  static NSInteger numTaps;
  static float height;
  static float width;
*/
//Side Subviews
    %orig;
		UIWindow * screen = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];

		rightBottomView=[[ExcitantView alloc]initWithFrame:CGRectMake(screen.bounds.size.width, screen.bounds.size.height, - width, - height)];
			if(setColor == YES){
				[rightBottomView setBackgroundColor:[UIColor redColor]];
			}else{
				[rightBottomView setBackgroundColor:[UIColor colorWithWhite:0.001 alpha:0.001]];
			}
	    [rightBottomView setAlpha: 1];
			[rightBottomView setHidden:NO];
	    rightBottomView.userInteractionEnabled = TRUE;

		  leftBottomView=[[ExcitantView alloc]initWithFrame:CGRectMake(screen.bounds.origin.x, screen.bounds.size.height, width, - height)];
			if(setColor == YES){
				[leftBottomView setBackgroundColor:[UIColor redColor]];
			}else{
			[leftBottomView setBackgroundColor:[UIColor colorWithWhite:0.001 alpha:0.001]];
		  }
	    [leftBottomView setAlpha: 1];
			[leftBottomView setHidden:NO];
	    leftBottomView.userInteractionEnabled = TRUE;

			rightMiddleView=[[ExcitantView alloc]initWithFrame:CGRectMake(screen.bounds.size.width, screen.bounds.size.height*.60, - width, - height)];
				if(setColor == YES){
					[rightMiddleView setBackgroundColor:[UIColor blueColor]];
				}else{
					[rightMiddleView setBackgroundColor:[UIColor colorWithWhite:0.001 alpha:0.001]];
				}
		    [rightMiddleView setAlpha: 1];
				[rightMiddleView setHidden:NO];
		    rightMiddleView.userInteractionEnabled = TRUE;

			leftMiddleView=[[ExcitantView alloc]initWithFrame:CGRectMake(screen.bounds.origin.x, screen.bounds.size.height*.60, width, - height)];
				if(setColor == YES){
					[leftMiddleView setBackgroundColor:[UIColor blueColor]];
				}else{
				[leftMiddleView setBackgroundColor:[UIColor colorWithWhite:0.001 alpha:0.001]];
			  }
		    [leftMiddleView setAlpha: 1];
				[leftMiddleView setHidden:NO];
		    leftMiddleView.userInteractionEnabled = TRUE;

				rightTopView=[[ExcitantView alloc]initWithFrame:CGRectMake(screen.bounds.size.width, screen.bounds.size.height*0.001, - width,  height)];
					if(setColor == YES){
						[rightTopView setBackgroundColor:[UIColor greenColor]];
					}else{
						[rightTopView setBackgroundColor:[UIColor colorWithWhite:0.001 alpha:0.001]];
					}
			    [rightTopView setAlpha: 1];
					[rightTopView setHidden:NO];
			    rightTopView.userInteractionEnabled = TRUE;

				leftTopView=[[ExcitantView alloc]initWithFrame:CGRectMake(screen.bounds.origin.x, screen.bounds.size.height*0.001, width,  height)];
					if(setColor == YES){
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
    /*static BOOL enableRB;
    static BOOL enableRM;
    static BOOL enableRT;
    static BOOL enableLB;
    static BOOL enableLM;
    static BOOL enableLT;
    static BOOL setColor;
    static NSInteger numTaps;
    static float height;
    static float width;
*/
        if(enableRB == YES){
        [window addSubview:rightBottomView];
    }else {nil;}
      if(enableRM == YES){
		[window addSubview:rightMiddleView];
    }else {nil;}
       if(enableRT == YES){
		[window addSubview:rightTopView];
    }else {nil;}
       if(enableLB == YES){
		[window addSubview:leftBottomView];
    }else {nil;}
       if(enableLM == YES){
		[window addSubview:leftMiddleView];
    }else {nil;}
       if(enableLT == YES){
		[window addSubview:leftTopView];
    }else {nil;}

/*UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapTapUtils)];
tapRecognizer.numberOfTapsRequired = 2;
[self addGestureRecognizer:tapRecognizer];*/

/*static BOOL enableRB;
static BOOL enableRM;
static BOOL enableRT;
static BOOL enableLB;
static BOOL enableLM;
static BOOL enableLT;
static BOOL setColor;
static NSInteger numTaps;
static float height;
static float width;
*/
		UITapGestureRecognizer *rightBottomRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TouchRecognizerBottomRight:)];
		if(numTaps == 2){
	    rightBottomRecognizer.numberOfTapsRequired = 2;
			[rightBottomView addGestureRecognizer:rightBottomRecognizer];
		}else if(numTaps == 3){
			rightBottomRecognizer.numberOfTapsRequired = 3;
			[rightBottomView addGestureRecognizer:rightBottomRecognizer];
		}else if (numTaps == 4){
			rightBottomRecognizer.numberOfTapsRequired = 4;
			[rightBottomView addGestureRecognizer:rightBottomRecognizer];
		}else if (numTaps == 1){
			rightBottomRecognizer.numberOfTapsRequired = 1;
	    [rightBottomView addGestureRecognizer:rightBottomRecognizer];
		}

		UITapGestureRecognizer *leftBottomRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TouchRecognizerBottomLeft:)];
		if(numTaps == 2){
			leftBottomRecognizer.numberOfTapsRequired = 2;
			[leftBottomView addGestureRecognizer:leftBottomRecognizer];
		}else if(numTaps == 3){
			leftBottomRecognizer.numberOfTapsRequired = 3;
			[leftBottomView addGestureRecognizer:leftBottomRecognizer];
		}else if (numTaps == 4){
			leftBottomRecognizer.numberOfTapsRequired = 4;
			[leftBottomView addGestureRecognizer:leftBottomRecognizer];
		}else if (numTaps == 1){
			leftBottomRecognizer.numberOfTapsRequired = 1;
			[leftBottomView addGestureRecognizer:leftBottomRecognizer];
		}

		UITapGestureRecognizer *leftMiddleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TouchRecognizerLeftMiddle:)];
		if(numTaps == 2){
			leftMiddleRecognizer.numberOfTapsRequired = 2;
			[leftMiddleView addGestureRecognizer:leftMiddleRecognizer];
		}else if(numTaps == 3){
			leftMiddleRecognizer.numberOfTapsRequired = 3;
			[leftMiddleView addGestureRecognizer:leftMiddleRecognizer];
		}else if (numTaps == 4){
			leftMiddleRecognizer.numberOfTapsRequired = 4;
			[leftMiddleView addGestureRecognizer:leftMiddleRecognizer];
		}else if(numTaps == 1){
			leftMiddleRecognizer.numberOfTapsRequired = 1;
			[leftMiddleView addGestureRecognizer:leftMiddleRecognizer];
		}

		UITapGestureRecognizer *rightMiddleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TouchRecognizerRightMiddle:)];
		if(numTaps == 2){
			rightMiddleRecognizer.numberOfTapsRequired = 2;
			[rightMiddleView addGestureRecognizer:rightMiddleRecognizer];
		}else if(numTaps == 3){
			rightMiddleRecognizer.numberOfTapsRequired = 3;
			[rightMiddleView addGestureRecognizer:rightMiddleRecognizer];
		}else if (numTaps == 4){
			rightMiddleRecognizer.numberOfTapsRequired = 4;
			[rightMiddleView addGestureRecognizer:rightMiddleRecognizer];
		}else if (numTaps == 1){
			rightMiddleRecognizer.numberOfTapsRequired = 1;
			[rightMiddleView addGestureRecognizer:rightMiddleRecognizer];
		}

		UITapGestureRecognizer *leftTopRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TouchRecognizerLeftTop:)];
		if(numTaps == 2){
			leftTopRecognizer.numberOfTapsRequired = 2;
			[leftTopView addGestureRecognizer:leftTopRecognizer];
		}else if(numTaps == 3){
			leftTopRecognizer.numberOfTapsRequired = 3;
			[leftTopView addGestureRecognizer:leftTopRecognizer];
		}else if (numTaps == 4){
			leftTopRecognizer.numberOfTapsRequired = 4;
			[leftTopView addGestureRecognizer:leftTopRecognizer];
		}else if (numTaps == 1){
			leftTopRecognizer.numberOfTapsRequired = 1;
			[leftTopView addGestureRecognizer:leftTopRecognizer];
		}

		UITapGestureRecognizer *rightTopRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TouchRecognizerRightTop:)];
		if(numTaps == 2){
			rightTopRecognizer.numberOfTapsRequired = 2;
			[rightTopView addGestureRecognizer:rightTopRecognizer];
		}else if(numTaps == 3){
			rightTopRecognizer.numberOfTapsRequired = 3;
			[rightTopView addGestureRecognizer:rightTopRecognizer];
		}else if (numTaps == 4){
			rightTopRecognizer.numberOfTapsRequired = 4;
			[rightTopView addGestureRecognizer:rightTopRecognizer];
		}else if (numTaps == 1){
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
//End Side Subviews
//Mute Switch Function
- (void)_updateRingerState:(int)arg1 withVisuals:(BOOL)arg2 updatePreferenceRegister:(BOOL)arg3 {
  loadSwitchApp();
	if(arg1) {
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
                        [Excitant AUXtoggleMute];
		}
		if (switchPreference == 4) {
                        [Excitant AUXtoggleRotationLock];
		}
      		if (switchPreference == 5) {
                        [Excitant AUXlaunchApp:switchApp];
      		}
	} else {
		%orig;
	}
}
//End Mute Switch Function
//Side Subviews Selectors
%new
- (void) TouchRecognizerBottomRight:(UITapGestureRecognizer *)sender {
	loadPrefsTouchesRightBottom();
	[Excitant AUXlaunchApp:touchesRightBottom];
}


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
//End Selectors, Start Observers
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
//End Side Subviews Observers


%end


//Start HomeHijack
%hook SBAssistantController
-(void)_viewWillAppearOnMainScreen:(BOOL)arg1{
    if(siriCC == YES){
        [Excitant AUXcontrolCenter];
        %orig;
    }else if (siriRespring == YES){
      [Excitant AUXrespring];
      }else if(siriFlash == YES){
        //Flashlight
            [Excitant AUXtoggleFlash];
          }else if (siriBat == YES){
              [Excitant AUXtoggleLPM];
              }else if(selectedApp != nil){
                  [Excitant AUXlaunchApp:selectedApp];
                  %orig(NO);
              }else{
        %orig;
    }
}

%end

%hook SBAssistantWindow
-(id)initWithScreen:(id)arg1 layoutStrategy:(id)arg2 debugName:(id)arg3 scene:(id)arg4 {

    if (selectedApp !=nil) {
        return NULL;
    }else if(siriCC == YES){
        return NULL;
    }else if (siriBat == YES){
        return NULL;
    }else if(siriFlash == YES){
        return NULL;
    }else{
        return %orig;
    }
}
%end

%hook SBHomeHardwareButtonActions
-(void)performTriplePressUpActions{
  /*static BOOL siriCC;
  static BOOL siriRespring;
  static BOOL siriBat;
  static BOOL siriFlash;
  static BOOL tritapCC;
  static BOOL tritapRespring;
  static BOOL tritapBat;
  static BOOL tritapFlash;*/
  if (tritapRespring == YES){
    [Excitant AUXrespring];
  }else if (tritapCC == YES){
    [Excitant AUXcontrolCenter];
    }else if(tritapFlash == YES){
    //Flashlight
        [Excitant AUXtoggleFlash];
      }
      else if (tritapBat == YES){
        [Excitant AUXtoggleLPM];
        }else if (tapLaunch != nil){
          [Excitant AUXlaunchApp:tapLaunch];
        }else{
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

                                    /*static BOOL taptaps2;
                                    static BOOL taptaps3;
                                    static BOOL taptaps4;
                                    static BOOL enableAppTap;
                                    static BOOL enableUtils;
                                    static BOOL uicache;
                                    static BOOL respring;
                                    static BOOL reboot;
                                    static BOOL safemode;
                                    static BOOL shutdown;
                                    static BOOL enableFlash;
                                    static BOOL enableLPM;
                                    static BOOL enableAPM;
                                    static BOOL enableRL;
                                    static BOOL enableCC;
                                    static BOOL enableRespring;
                                    static BOOL enableSleep;
*/

		if (uicache == YES){
        	[confirmationAlertController addAction:confirmUiCache];
		}
		if (respring == YES){
	        [confirmationAlertController addAction:confirmRespring];
		}
		if (tapreboot == YES){
			[confirmationAlertController addAction:confirmReboot];
		}
		if (safemode == YES){
			[confirmationAlertController addAction:confirmSafemode];
		}
		if (shutdown == YES){
			[confirmationAlertController addAction:confirmShutdown];
		}
		if (tapsleep == YES){
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
  loadTapApp();                    //TY Midnight :D
	[Excitant AUXlaunchApp:tapapp];
}



- (instancetype)initWithFrame:(CGRect)frame {
    self = %orig;
	int taps;
  /*static BOOL taptaps2;
  static BOOL taptaps3;
  static BOOL taptaps4;
  static BOOL enableAppTap;
  static BOOL enableUtils;
  static BOOL uicache;
  static BOOL respring;
  static BOOL reboot;
  static BOOL safemode;
  static BOOL shutdown;
  static BOOL enableFlash;
  static BOOL enableLPM;
  static BOOL enableAPM;
  static BOOL enableRL;
  static BOOL enableCC;
  static BOOL enableRespring;
  static BOOL enableSleep;*/
	if(taptaps2 == YES){
		taps = 2;
	}
	else if(taptaps3 == YES){
		taps = 3;
	}
	else if(taptaps4 == YES){
		taps = 4;
	}
	else {
		taps = 2;
	}
    if(enableUtils == YES){
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapTapUtils)];
        tapRecognizer.numberOfTapsRequired = taps;
        [self addGestureRecognizer:tapRecognizer];

        //return self;
    }
	if(enableFlash == YES){
		UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flash)];
        tapRecognizer.numberOfTapsRequired = taps;
        [self addGestureRecognizer:tapRecognizer];
	}
	if(enableLPM == YES){
		UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lpm)];
        tapRecognizer.numberOfTapsRequired = taps;
        [self addGestureRecognizer:tapRecognizer];
	}
	if(enableAPM == YES){
		UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(apm)];
        tapRecognizer.numberOfTapsRequired = taps;
        [self addGestureRecognizer:tapRecognizer];
	}
	if(enableRL == YES){
		UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rotationLock)];
        tapRecognizer.numberOfTapsRequired = taps;
        [self addGestureRecognizer:tapRecognizer];
	}
	if(enableCC == YES){
		UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(controlCenter)];
        tapRecognizer.numberOfTapsRequired = taps;
        [self addGestureRecognizer:tapRecognizer];
	}
	if(enableRespring == YES){
		UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respring)];
        tapRecognizer.numberOfTapsRequired = taps;
        [self addGestureRecognizer:tapRecognizer];
	}
	if(enableSleep == YES){
		UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lockDevice)];
        tapRecognizer.numberOfTapsRequired = taps;
        [self addGestureRecognizer:tapRecognizer];
	}
	if(enableAppTap == YES){
		UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(launchApp)];
        tapRecognizer.numberOfTapsRequired = taps;
        [self addGestureRecognizer:tapRecognizer];
	}
    return self;
}


%end
%end


//Prefs for TapTapUtils
%ctor{
  notificationCallback(NULL, NULL, NULL, NULL, NULL);
  CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
    NULL,
    notificationCallback,
    (CFStringRef)nsNotificationString,
    NULL,
    CFNotificationSuspensionBehaviorCoalesce);
    	@autoreleasepool {
    		%init(volFunction);
        } %init(Main)//autoreleasepool for volskip, just applying it to everything rn
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
