//
//  AppDelegate.h
//  Swipe-Switch Scenes
//
//  Created by Christopher Whitman on 3/22/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

BOOL gIsInBook = FALSE;
int gCurrentScene;
int gLastViewedScene;
int gCurrentSwipeCount = 0;
NSString* gStoryPlayMode;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;

}

@property (nonatomic, retain) UIWindow *window;
@end
