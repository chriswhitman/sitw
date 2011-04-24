//
//  GlobalDataManager.m
//  Swipe-Switch Scenes
//
//  Created by Christopher Whitman on 3/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GlobalDataManager.h"

@implementation GlobalDataManager

- (void) setUserIsInBookFlag{
    extern BOOL gIsInBook;
    gIsInBook = TRUE;
}

- (void) unsetUserIsInBookFlag{
    extern BOOL gIsInBook;
    gIsInBook = FALSE;
}

- (void) setStoryPlayMode:(NSString *)storyPlayMode{
    extern NSString* gStoryPlayMode;
    gStoryPlayMode = storyPlayMode;
}

- (void) setCurrentScene:(int)currentScene{
    extern int gCurrentScene;
    gCurrentScene = currentScene;
}

- (void) setLastViewedScene:(int)lastViewedScene{
    extern int gLastViewedScene;
    gLastViewedScene = lastViewedScene;
}

- (void) increaseSwipeCount{
    extern int gCurrentSwipeCount;
    gCurrentSwipeCount+=1;
}

- (void) clearSwipeCount{
    extern int gCurrentSwipeCount;
    gCurrentSwipeCount = 0;
}

@end
