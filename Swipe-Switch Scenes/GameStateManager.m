//
//  GameStateManager.m
//  Swipe-Switch Scenes
//
//  Created by Christopher Whitman on 3/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PreBookScene.h"
#import "IntroScene.h"
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
    (sceneToGoTo < 1) ? sceneToGoTo = -1 : (sceneToGoTo = sceneToGoTo);

    switch (sceneToGoTo) {
        case -1:
        {
            PreBookScene *preBookScene = [PreBookScene node];
            [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:1.0 scene:preBookScene]];
            break;
        }
        case 0:
        {
            IntroScene *introScene = [IntroScene node];
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.2];
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:introScene];
            [UIView commitAnimations];
            

            
            [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:1.0 scene:introScene]];
            break;
        }
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
