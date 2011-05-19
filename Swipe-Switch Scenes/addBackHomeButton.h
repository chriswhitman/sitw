//
//  addBackHomeButton.h
//  Stranger in the Woods Storybook
//
//  Created by Christopher Whitman on 4/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

-(void) goToHomeScreen{
    
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setTitle:@"Go to to main menu?"];
    [alert setDelegate:self];
    [alert addButtonWithTitle:@"Yes"]; // button index 0
    [alert addButtonWithTitle:@"No"]; 
    [alert show];
    [alert release];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self stopAllActions];
        
        MainMenuLayer *mainMenuScene = [MainMenuLayer node];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:1.0 scene:mainMenuScene backwards:YES]];

    } else if (buttonIndex == 1) {
        NSLog(@"Cancel button to UIAlertView was touched");
    }
}

