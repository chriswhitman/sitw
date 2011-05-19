//
//  PlaceBackHomeButton.h
//  Stranger in the Woods Storybook
//
//  Created by Christopher Whitman on 4/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

// menu item to build a snowman game
CCMenuItemImage *backHomeButton = [CCMenuItemImage 
                                   itemFromNormalImage:@"backHomeButton.png"
                                   selectedImage:@"backHomeButton-hover.png"
                                   target:self
                                   selector:@selector(goToHomeScreen)];


// create an instance of our menu
CCMenu *backButton = [CCMenu menuWithItems:backHomeButton, nil];

// center back home button
[backButton setPosition:ccp(s.width/2,30)];

// scale back home button to be a bit smaller
[backButton setScale:0.5];

// add menu to our scene
[self addChild:backButton];