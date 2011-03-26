//
//  GlobalDataManager.m
//  Swipe-Switch Scenes
//
//  Created by Christopher Whitman on 3/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GlobalDataManager.h"

static GlobalDataManager *sharedGlobalDataManager = nil;

@implementation GlobalDataManager

@synthesize currentScene;
@synthesize gamePlayed;
@synthesize data;
@synthesize musicOn, sfxOn;

+ (GlobalDataManager*)sharedDataManager
{
    @synchronized(self) {
        if (sharedGlobalDataManager == nil) {
            [[self alloc] init]; // assignment not done here
        }
    }
    return sharedGlobalDataManager;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (sharedGlobalDataManager == nil) {
			
            NSLog(@"Global Data Manager: Creating Singleton");
        	sharedGlobalDataManager = [super allocWithZone:zone];
			
            //Do variable initialize stuff here, if you need
			
        	return sharedGlobalDataManager;  // assignment and return on first allocation
        }
    }
    return nil; //on subsequent allocation attempts return nil
}


-(void) clearData {
	currentScene = 0;
	gamePlayed = NO;
	musicOn = YES;
	sfxOn = YES;
	data = nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{	
    return self;
}

- (unsigned)retainCount
{
    return UINT_MAX;  //denotes an object that cannot be released
}

- (void)release
{
    //do nothing
}

- (id)autorelease
{
    return self;
}

@end
