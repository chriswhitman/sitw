//
//  GameStateManager.m
//  Swipe-Switch Scenes
//
//  Created by Christopher Whitman on 3/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PageOneScene.h"
#import "PageTwoScene.h"
#import "PageThreeScene.h"
#import "CCTransition.h"
#import "CCTransitionPageTurn.h"
#import "MainMenuScene.h"
#import "GlobalDataManager.h"
#import "GameStateManager.h"

@implementation StoryStateManager

- (void) resumeStoryToScene:(int)sceneToGoTo{
    
    // sets scene to first scene if it's zero
    (sceneToGoTo < 2) ? sceneToGoTo = 1 : (sceneToGoTo = sceneToGoTo);

    switch (sceneToGoTo) {
        case 1:
        {
            PageOneScene *pageOneScene = [PageOneScene node];
            [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:1.0 scene:pageOneScene]];
            break;
        }
        case 2: 
        {
            PageTwoScene *pageTwoScene = [PageTwoScene node];
            [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:1.0 scene:pageTwoScene]];
            break;
        }
        case 3:
        {
            PageThreeScene *pageThreeScene = [PageThreeScene node];
            [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:1.0 scene:pageThreeScene]];
            break;
        }            
        default:
            break;
    }
}

@end
