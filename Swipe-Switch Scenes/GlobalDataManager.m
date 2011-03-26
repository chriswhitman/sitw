//
//  GlobalDataManager.m
//  Swipe-Switch Scenes
//
//  Created by Christopher Whitman on 3/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GlobalDataManager.h"


@implementation GlobalDataManager

- (void) setUserIsInBookFlag
{
    extern BOOL gIsInBook;
    
    gIsInBook = TRUE;
}

- (void) unsetUserIsInBookFlag
{
    extern BOOL gIsInBook;
    
    gIsInBook = FALSE;
}

- (void) setStoryPlayMode:(NSString *)storyType
{
    // logic to set the story play mode global here
}

- (void) setCurrentScene:(int)currentScene
{
    extern int gCurrentScene;
    
    gCurrentScene = currentScene;
}

@end
