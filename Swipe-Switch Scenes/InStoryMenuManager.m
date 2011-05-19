    //
//  InStoryMenuManager.m
//  Stranger in the Woods Storybook
//
//  Created by Christopher Whitman on 5/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InStoryMenuManager.h"
#import "MainMenuScene.h"
#import "PreBookScene.h"


@implementation InStoryMenuManager

// alert view listener for input
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        // [self stopAllActions];
        
        MainMenuLayer *mainMenuScene = [MainMenuLayer node];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:1.0 scene:mainMenuScene backwards:YES]];
        
    } else if (buttonIndex == 1) {
        NSLog(@"Cancel button to UIAlertView was touched");
    }
}

- (void)addMenuToScreen:(CCLayer *) layer
{
    CGSize s = [[CCDirector sharedDirector] winSize];

    
    // menu item to build a snowman game
    CCMenuItemImage *backHomeButton = [CCMenuItemImage 
                                       itemFromNormalImage:@"backHomeButton.png"
                                       selectedImage:@"backHomeButton-hover.png"
                                       block:^(id sender){
                                           UIAlertView *alert = [[UIAlertView alloc] init];
                                           [alert setTitle:@"Go to main menu?"];
                                           [alert setDelegate:layer];
                                           [alert addButtonWithTitle:@"Yes"]; // button index 0
                                           [alert addButtonWithTitle:@"No"]; 
                                           [alert show];
                                           [alert release];
                                        }];
    
    // init our menu
    CCMenu *backButton = [CCMenu menuWithItems:backHomeButton, nil];
    
    // reduce size of button a bit
    backButton.scale = 0.8;
    
    // center back home button
    [backButton setPosition:ccp(s.width/2,30)];
    
    // add menu to our scene
    [layer addChild:backButton];
    
}

@end
