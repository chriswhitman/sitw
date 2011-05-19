//
//  PreBookScene.m
//  Stranger in the Woods Storybook
//
//  Created by Christopher Whitman on 4/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PreBookScene.h"
#import "IntroScene.h"
#import "PageOneScene.h"
#import "PageTwoScene.h"
#import "CCTransition.h"
#import "CCTransitionPageTurn.h"
#import "MainMenuScene.h"
#import "GlobalDataManager.h"

@implementation PreBookScene
@synthesize layer = _layer;

- (id)init {
    
    if ((self = [super init])) {
        self.layer = [PreBookLayer node];
        [self addChild:_layer];
    }
    return self;
}

- (void)dealloc {
    [_layer release];
    _layer = nil;
    [super dealloc];
}
@end

@implementation PreBookLayer
@synthesize label = _label;

-(id) init
{
    if( (self=[super initWithColor:ccc4(255,255,255,255)] )) {
        [[CCDirector sharedDirector] setDepthTest:YES]; 
        
        // allow touches on scene
        self.isTouchEnabled=YES;
		touched=FALSE;
        
        // set out current scene global (gCurrentScene) to the current scene
        GlobalDataManager *data = [[GlobalDataManager alloc] init];
        [data setCurrentScene:-1];
        
        // set last viewed scene global variable (gLastViewedScene gets set)
        GlobalDataManager *data_last_viewed = [[GlobalDataManager alloc] init];
        [data_last_viewed setLastViewedScene:1];
        
        #include "GestureConfig.h"
        
        CGSize s = [[CCDirector sharedDirector] winSize];
        
        CCSprite* background = [CCSprite spriteWithFile:@"PreIntroPage-ipad.jpg"];
        background.tag = 1;
        background.position = ccp(s.width/2, s.height/2);
        // background.anchorPoint = ccp(0,0);
        [background setScale:1.0]; 
        [self addChild:background];
            
        
        // set up the swipe to continue image
        CCSprite* swipeToContinueButton = [CCSprite spriteWithFile:@"swipe.png"];
        [swipeToContinueButton setScale:1.0 ]; 
        swipeToContinueButton.position = ccp(s.width/1.3, s.height/11);
        [self addChild:swipeToContinueButton];
        
        // place back home button
        #include "PlaceBackHomeButton.h"
        
        [[NSUserDefaults standardUserDefaults] setInteger:-1 forKey:@"lastViewedScene"];
        
        int currentScene = [[NSUserDefaults standardUserDefaults] integerForKey:@"lastViewedScene"];
        NSLog(@"Current scene retrieved from NSUserDefaults: %i", currentScene);
        
        
    }	
    return self;
}

-(void) registerWithTouchDispatcher{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:kCCMenuTouchPriority swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
	[[Gestures sharedGestures] reset];
	return TRUE;
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
	CGPoint point = [touch locationInView: [touch view]];
	CGPoint converted = [[CCDirector sharedDirector] convertToGL:point];
	[[Gestures sharedGestures] addPoint:converted];
}



#include "addBackHomeButton.h"

-(void) swipeRightComplete{
    if(!touched){
        touched=!touched;
    }
}

-(void) swipeLeftComplete{
    if (!touched) {
        touched=!touched;
        
        IntroScene *introScene = [IntroScene node];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:1.0 scene:introScene]];
    }
}

- (void)dealloc {
    [_label release];
    _label = nil;

    [super dealloc];
}

@end