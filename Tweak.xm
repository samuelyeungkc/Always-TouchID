#import <AudioToolbox/AudioToolbox.h>
#import "SpringBoard/SBUIController.h"
#import <SpringBoard/SBBacklightController.h>
#import <SpringBoard/SBDeviceLockController.h>
#import <SpringBoard/SBLockScreenManager.h>
#import <SpringBoardUIServices/SBUIBiometricEventMonitor.h>
#import <BiometricKit/BiometricKit.h>
#import <SpringBoard/SBReachabilityTrigger.h>
#import <SpringBoardUI/SBUISound.h>
#import <SpringBoard/SBSoundController.h>
#import <SpringBoard/SBUserAgent.h>
#import <AccessibilityUtilities/AXSpringBoardServer.h>
#import <SpringBoard/SBControlCenterController.h>
#import <SpotlightUI/SPUISearchViewController.h>
#import <SpringBoardUIServices/SBUIPasscodeLockViewBase.h>

#import <Preferences/PSAssistiveTouchSettingsDetail.h>

%hook BiometricKit
-(long long)getBioLockoutState
{
	
	unsigned long long origin = %orig;
	NSString *msg = [NSString stringWithFormat:@"BioLockout state : %llu", origin];
	NSString *title = @"title";
	NSString *cancel = @"OK";
	UIAlertView *a = [[UIAlertView alloc] initWithTitle:title
	message:msg delegate:nil cancelButtonTitle:cancel otherButtonTitles:nil];
//	[a show];
	[a release];
	
	return %orig;
}
%end

%hook SBUIBiometricEventMonitor
-(unsigned long long)lockoutState
{
	unsigned long long origin = %orig;
	NSString *msg = [NSString stringWithFormat:@"lockout state : %llu", origin];
	NSString *title = @"title";
	NSString *cancel = @"OK";
	UIAlertView *a = [[UIAlertView alloc] initWithTitle:title
	message:msg delegate:nil cancelButtonTitle:cancel otherButtonTitles:nil];
//	[a show];
	[a release];
	
	return %orig;
}
%end

%hook SBLockScreenManager
-(void)triggerDidTimeoutForFingerOn:(id)arg1
{
	unsigned long long *att;
	object_getInstanceVariable(self, "_failedMesaUnlockAttempts", (void**) &att);
	//NSString *str; object_getInstanceVariable(self, "_failedMesaUnlockAttempts", (void **)&str);
//NSString *msg = [NSString stringWithFormat:@"lolcatz %llu", *att];
NSString *msg = @"H";
NSString *title = @"title";
NSString *cancel = @"OK";
UIAlertView *a = [[UIAlertView alloc] initWithTitle:title
message:msg delegate:nil cancelButtonTitle:cancel otherButtonTitles:nil];
//[a show];
[a release];
	%orig;
}

-(void)_bioAuthenticated:(id)arg1
{
NSString *msg = @"here";
NSString *title = @"title";
NSString *cancel = @"OK";
UIAlertView *a = [[UIAlertView alloc] initWithTitle:title
message:msg delegate:nil cancelButtonTitle:cancel otherButtonTitles:nil];
[a show];
[a release];
	%orig;
}
%end

%hook SBUIBiometricEventMonitor
-(BOOL)isMatchingEnabled
{
	return YES;
}
-(void)disableMatchingForPasscodeView:(id)arg1
{
}
-(void)_stopFingerDetection
{
}
-(void)_stopMatching
{
}
%end

%hook SBUIPasscodeLockViewBase
-(BOOL)_wantsBiometricAuthentication
{
	return %orig;
}

-(void)updateStatusTextForBioEvent:(unsigned long long)arg1 animated:(BOOL)arg2
{
	unsigned long long match = [self biometricMatchMode];
	match = 2;
	match = [self biometricMatchMode];
	NSString *msg = [NSString stringWithFormat:@"matching mode : %llu", match];
        NSString *title = @"title";
        NSString *cancel = @"OK";
        UIAlertView *a = [[UIAlertView alloc] initWithTitle:title
        message:msg delegate:nil cancelButtonTitle:cancel otherButtonTitles:nil];
        [a show];
        [a release];
}

-(void)resetForFailedMesaAttemptWithStatusText:(id)arg1 andSubtitle:(id)arg2
{
        NSString *msg = @"Hello!";
        NSString *title = @"title";
        NSString *cancel = @"OK";
        UIAlertView *a = [[UIAlertView alloc] initWithTitle:title
        message:msg delegate:nil cancelButtonTitle:cancel otherButtonTitles:nil];
        [a show];
        [a release];
	%orig;

}
%end

%hook SBDeviceLockController
-(void)disableMatchingForPasscodeView:(id)arg1
{
}
%end

%hook SBLockScreenManager
- (void)setBioUnlockingDisabled:(BOOL)arg1 forRequester:(id)arg2
{

        NSString *msg = @"Hello!";
        NSString *title = @"title";
        NSString *cancel = @"OK";
        UIAlertView *a = [[UIAlertView alloc] initWithTitle:title
        message:msg delegate:nil cancelButtonTitle:cancel otherButtonTitles:nil];
        [a show];
        [a release];
        id monitor = [%c(SBUIBiometricEventMonitor) sharedInstance];
	[monitor _startMatching];

}
%end

%hook SBUIBiometricEventMonitor
-(void)_startMatching
{
/*
        NSString *msg = @"started mathcing!";
        NSString *title = @"title";
        NSString *cancel = @"OK";
        UIAlertView *a = [[UIAlertView alloc] initWithTitle:title
        message:msg delegate:nil cancelButtonTitle:cancel otherButtonTitles:nil];
        [a show];
        [a release];
*/
	%orig;
}

-(BOOL)isFingerprintUnlockAllowedAndEnabled
{
        NSString *msg = @"Hello!";
        NSString *title = @"title";
        NSString *cancel = @"OK";
        UIAlertView *a = [[UIAlertView alloc] initWithTitle:title
        message:msg delegate:nil cancelButtonTitle:cancel otherButtonTitles:nil];
        [a show];
        [a release];


	return YES;
}
%end


