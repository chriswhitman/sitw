//
//  IntroScene.m
//  Stranger in the Woods Storybook
//
//  Created by Christopher Whitman on 4/5/11.
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
#import "InStoryMenuManager.h"

BOOL isForwardSwipe;

@implementation IntroScene
@synthesize layer = _layer;
@synthesize menuLayer = _menuLayer;

- (id)init {
    
    if ((self = [super init])) {
        self.layer = [IntroSceneLayer node];
        self.menuLayer = [IntroSceneMenuLayer node];
        [self addChild:_layer z:10];
        [self addChild:_menuLayer z:20];
    }
    return self;
}

- (void)dealloc {
    [_layer release];
    _layer = nil;
    [super dealloc];
}
@end

@implementation IntroSceneMenuLayer

-(id) init
{
    if( (self=[super init] )) {
        
        // load window data into object
        CGSize s = [[CCDirector sharedDirector] winSize];
        
        // allow touches on scene
        self.isTouchEnabled=YES;
		touched=FALSE;
        
        #include "GestureConfig.h"
        
        InStoryMenuManager *menu = [[[InStoryMenuManager alloc] init] autorelease];
        [menu addMenuToScreen:self];        
    }	
    return self;
    
    
}

#include "addBackHomeButton.h"

@end

@implementation IntroSceneLayer
@synthesize label = _label;
@synthesize lineTwoText = _lineTwoText;
@synthesize lineThreeText = _lineThreeText;

-(id) init
{   
    if( (self=[super initWithColor:ccc4(255,255,255,255)] )) {
        
        // load window data into object
        CGSize s = [[CCDirector sharedDirector] winSize];
        
        // allow touches on scene
        self.isTouchEnabled=YES;
		touched=FALSE;
        
        // set out current scene global (gCurrentScene) to the current scene
        GlobalDataManager *data = [[GlobalDataManager alloc] init];
        [data setCurrentScene:0];
        
        // set last viewed scene global variable (gLastViewedScene gets set)
        GlobalDataManager *data_last_viewed = [[GlobalDataManager alloc] init];
        [data_last_viewed setLastViewedScene:0];
        
        #include "GestureConfig.h"
        
        if ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)) {
            CCSprite* background = [CCSprite spriteWithFile:@"intro-page-background-ipad.png"];
            background.tag = 1;
            background.position = ccp(s.width/2, s.height/2.3);
            // background.anchorPoint = ccp(0,0);
            [self addChild:background];
        } else {
           // code for iphone background image and positioning            
        }
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        // first line of text
        self.label = [CCLabelTTF labelWithString:@"For those who protect wild places" fontName:@"Poetica-ChanceryIII" fontSize:42];
        _label.color = ccc3(237,31,36);
        _label.position = ccp(winSize.width/2, winSize.height/4);
        [self addChild:_label];
        
        // second line of text
        self.lineTwoText = [CCLabelTTF labelWithString:@"and to the snowman that lives" fontName:@"Poetica-ChanceryIII" fontSize:42];
        _lineTwoText.color = ccc3(237,31,36);
        _lineTwoText.position = ccp(winSize.width/2, winSize.height/5.4);
        [self addChild:_lineTwoText];
        
        // third line of text
        self.lineThreeText = [CCLabelTTF labelWithString:@"in every child's heart." fontName:@"Poetica-ChanceryIII" fontSize:42];
        _lineThreeText.color = ccc3(237,31,36);
        _lineThreeText.position = ccp(winSize.width/2, winSize.height/8.25);
        [self addChild:_lineThreeText];
        
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"Intro Text"];
        
        int currentScene = [[NSUserDefaults standardUserDefaults] integerForKey:@"lastViewedScene"];
        NSLog(@"Current scene retrieved from NSUserDefaults: %i", currentScene);
      

        
        // will want to check this out for the highlighting/replacing of text
        // Delayed timer code, sends message after given duration
        //[self runAction:[CCSequence actions:
        //                [CCDelayTime actionWithDuration:3],
        //                [CCCallFunc actionWithTarget:self selector:@selector(gameOverDone)],
        //                 nil]];
        
    }	
    return self;
}



#include "GestureSetup.h"
- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    // 3d projection fix, must be turned off before using 3d effects, i.e., turn-page transition
    [[CCDirector sharedDirector] setDepthTest:YES]; 
    
    // forward swipe, moves story forward
    // maybe debug and check direction of swipe
    if(isForwardSwipe)
    {
        PreBookScene *preBookScene = [PreBookScene node];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:1.0 scene:preBookScene backwards:TRUE]];
    } else {
        PageOneScene *pageOneScene = [PageOneScene node];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:1.0 scene:pageOneScene]];
    }
    
	NSLog(@"Touch Ended:%@", touch);
}

- (void)swipeRightComplete{
    if (!touched)
    {
        touched=!touched;
    }
    
    isForwardSwipe = NO;
}

- (void)swipeLeftComplete
{
    if (!touched)
    {
        touched=!touched;
    }        
    
    isForwardSwipe = YES;
}


- (void)dealloc 
{
    [_label release];
    _label = nil;
    
    // [[CCTextureCache sharedTextureCache] removeUnusedTextures];
	// [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
	// [[CCDirector sharedDirector] purgeCachedData];
	// [self removeAllChildrenWithCleanup:YES];
    
    [super dealloc];
}

@end