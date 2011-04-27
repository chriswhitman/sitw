#import "IntroScene.h"
#import "PageOneScene.h"
#import "PageTwoScene.h"
#import "CCTransition.h"
#import "CCTransitionPageTurn.h"
#import "MainMenuScene.h"
#import "GlobalDataManager.h"

int swipeCount = 0;

@implementation PageOneScene
@synthesize layer = _layer;


- (id)init {
    
    if ((self = [super init])) {
        self.layer = [PageOneLayer node];
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

@implementation PageOneLayer

@synthesize label = _label;

@synthesize p1l1text = _p1l1text;
@synthesize p1l2text = _p1l2text;
@synthesize p1l3text = _p1l3text;
@synthesize p1l4text = _p1l4text;

@synthesize p2l1text = _p2l1text;
@synthesize p2l2text = _p2l2text;
@synthesize p2l3text = _p2l3text;

@synthesize p3l1text = _p3l1text;
@synthesize p3l2text = _p3l2text;
@synthesize p3l3text = _p3l3text;
@synthesize p3l4text = _p3l4text;
@synthesize p3l5text = _p3l5text;

@synthesize p4l1text = _p4l1text;
@synthesize p4l2text = _p4l2text;

-(id) init
{
    if( (self=[super initWithColor:ccc4(255,255,255,255)] )) {
        
        // allow touches on scene
        self.isTouchEnabled=YES;
		touched=FALSE;
        
        // set out current scene global (gCurrentScene) to the current scene
        GlobalDataManager *data = [[GlobalDataManager alloc] init];
        [data setCurrentScene:1];
        
        // set last viewed scene global variable (gLastViewedScene gets set)
        GlobalDataManager *data_last_viewed = [[GlobalDataManager alloc] init];
        [data_last_viewed setLastViewedScene:1];
        
        #include "GestureConfig.h"
        
        CGSize s = [[CCDirector sharedDirector] winSize];


        CCSprite* background = [CCSprite spriteWithFile:@"Page1-ipad-small.jpeg"];
        //background.tag = 1;
        // background.anchorPoint = ccp(0,0);
        [background setScale:1.0]; 
        background.position = ccp(s.width/2, s.height/2);
        [self addChild:background];
        
        [self showP1];
        
        // for panning/zooming simultaneously      
        //id action = [CCSpawn actions:
        //                 [CCDelayTime actionWithDuration:3.0],
        //                 [CCScaleTo actionWithDuration:12.0 scale:0.83],
        //                 [CCMoveTo actionWithDuration:12.0 position:ccp(s.width/2,s.width/2 - 125)],
        //                 nil];
            
        //[background runAction:action];
        
        // self.label = [CCLabelTTF labelWithString:@"Page one scene" fontName:@"Arial" fontSize:32];
        // _label.color = ccc3(0,0,0);
        // _label.position = ccp(winSize.width/2, winSize.height/2);
        // [self addChild:_label];
    
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"lastViewedScene"];
        
        int currentScene = [[NSUserDefaults standardUserDefaults] integerForKey:@"lastViewedScene"];
        NSLog(@"Current scene retrieved from NSUserDefaults: %i", currentScene);
    }	
    return self;
}

#include "GestureSetup.h"



// message for showing first paragraph (P1)
- (void) showP1{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    // let's play with our properties!
    self.p1l1text = [CCLabelTTF labelWithString:@"The snowflakes were" fontName:@"PopplPontifexBE-Regular" fontSize:21];
    _p1l1text.position = ccp(winSize.width/3.5, winSize.height/6.1);
    _p1l1text.color = ccc3(0,0,0);
    _p1l1text.opacity = 0.0;
    [self addChild:_p1l1text];
    
    self.p1l2text = [CCLabelTTF labelWithString:@"resting after their twisting" fontName:@"PopplPontifexBE-Regular" fontSize:21];
    _p1l2text.position = ccp(winSize.width/3.18, winSize.height/8);
    _p1l2text.color = ccc3(0,0,0);
    _p1l2text.opacity = 0.0;
    [self addChild:_p1l2text];
    
    self.p1l3text = [CCLabelTTF labelWithString:@"twirling dance through" fontName:@"PopplPontifexBE-Regular" fontSize:21];
    _p1l3text.position = ccp(winSize.width/3.09, winSize.height/11.7);
    _p1l3text.color = ccc3(0,0,0);
    _p1l3text.opacity = 0.0;
    [self addChild:_p1l3text];

    self.p1l4text = [CCLabelTTF labelWithString:@"the crisp night air." fontName:@"PopplPontifexBE-Regular" fontSize:21];
    _p1l4text.position = ccp(winSize.width/3, winSize.height/21.1);
    _p1l4text.color = ccc3(0,0,0);
    _p1l4text.opacity = 0.0;
    [self addChild:_p1l4text];

    // make an object out of the action for reuse
    id delay1 = [CCDelayTime actionWithDuration:0.650 ];
    id fadeIn1 = [CCFadeIn actionWithDuration:0.600];
    id fadeP1_1 = [CCSequence actions:delay1, fadeIn1, nil];
                    
    [_p1l1text runAction:fadeP1_1];
    [_p1l2text runAction:[[fadeP1_1 copy] autorelease]];
    [_p1l3text runAction:[[fadeP1_1 copy] autorelease]];
    [_p1l4text runAction:[[fadeP1_1 copy] autorelease]];

    // this is to run sequential actions on an object
    // id MainMenuBottomSeq = [CCSequence actions: mainMenuBottomDelay, mainMenuBottomFadeIn, nil];
    
}
- (void) showP2{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    // let's play with our properties!
    self.p2l1text = [CCLabelTTF labelWithString:@"Every twig in the forest" fontName:@"PopplPontifexBE-Regular" fontSize:21];
    _p2l1text.position = ccp(winSize.width/3.5, winSize.height/6.1);
    _p2l1text.color = ccc3(0,0,0);
    _p2l1text.opacity = 0.0;
    [self addChild:_p2l1text];
    
    self.p2l2text = [CCLabelTTF labelWithString:@"wore a new coat" fontName:@"PopplPontifexBE-Regular" fontSize:21];
    _p2l2text.position = ccp(winSize.width/3.6, winSize.height/8);
    _p2l2text.color = ccc3(0,0,0);
    _p2l2text.opacity = 0.0;
    [self addChild:_p2l2text];
    
    self.p2l3text = [CCLabelTTF labelWithString:@"of glimmering white." fontName:@"PopplPontifexBE-Regular" fontSize:21];
    _p2l3text.position = ccp(winSize.width/3.21, winSize.height/11.7);
    _p2l3text.color = ccc3(0,0,0);
    _p2l3text.opacity = 0.0;
    [self addChild:_p2l3text];
    
    
    // make an object out of the action for reuse
    id delay2 = [CCDelayTime actionWithDuration:0.650];
    id fadeIn2 = [CCFadeIn actionWithDuration:0.600];
    id fadeP2 = [CCSequence actions:delay2, fadeIn2, nil];
    
    [_p2l1text runAction:fadeP2];
    [_p2l2text runAction:[[fadeP2 copy] autorelease]];
    [_p2l3text runAction:[[fadeP2 copy] autorelease]];
}
- (void) showP3{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    // let's play with our properties!
    self.p3l1text = [CCLabelTTF labelWithString:@"Daybreak came" fontName:@"PopplPontifexBE-Regular" fontSize:21];
    _p3l1text.position = ccp(winSize.width/4.1, winSize.height/5.0);
    _p3l1text.color = ccc3(0,0,0);
    _p3l1text.opacity = 0.0;
    [self addChild:_p3l1text];
    
    self.p3l2text = [CCLabelTTF labelWithString:@"Softly moving through the woods" fontName:@"PopplPontifexBE-Regular" fontSize:21];
    _p3l2text.position = ccp(winSize.width/3.18, winSize.height/6.1);
    _p3l2text.color = ccc3(0,0,0);
    _p3l2text.opacity = 0.0;
    [self addChild:_p3l2text];
    
    self.p3l3text = [CCLabelTTF labelWithString:@"and yawning" fontName:@"PopplPontifexBE-Regular" fontSize:21];
    _p3l3text.position = ccp(winSize.width/3.4, winSize.height/8);
    _p3l3text.color = ccc3(0,0,0);
    _p3l3text.opacity = 0.0;
    [self addChild:_p3l3text];
    
    self.p3l4text = [CCLabelTTF labelWithString:@"as its rays slowly stretched" fontName:@"PopplPontifexBE-Regular" fontSize:21];
    _p3l4text.position = ccp(winSize.width/3, winSize.height/11.7);
    _p3l4text.color = ccc3(0,0,0);
    _p3l4text.opacity = 0.0;
    [self addChild:_p3l4text];
    
    self.p3l5text = [CCLabelTTF labelWithString:@"across the snowy meadows." fontName:@"PopplPontifexBE-Regular" fontSize:21];
    _p3l5text.position = ccp(winSize.width/2.7, winSize.height/21.1);
    _p3l5text.color = ccc3(0,0,0);
    _p3l5text.opacity = 0.0;
    [self addChild:_p3l5text];
    
    
    // make an object out of the action for reuse
    id delay3 = [CCDelayTime actionWithDuration:0.650];
    id fadeIn3 = [CCFadeIn actionWithDuration:0.600];
    id fadeP3 = [CCSequence actions:delay3, fadeIn3, nil];
    
    [_p3l1text runAction:fadeP3];
    [_p3l2text runAction:[[fadeP3 copy] autorelease]];
    [_p3l3text runAction:[[fadeP3 copy] autorelease]];
    [_p3l4text runAction:[[fadeP3 copy] autorelease]];
    [_p3l5text runAction:[[fadeP3 copy] autorelease]];

}
- (void) showP4{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    // let's play with our properties!
    self.p4l1text = [CCLabelTTF labelWithString:@"The birds" fontName:@"PopplPontifexBE-Regular" fontSize:21];
    _p4l1text.position = ccp(winSize.width/3.6, winSize.height/6.1);
    _p4l1text.color = ccc3(0,0,0);
    _p4l1text.opacity = 0.0;
    [self addChild:_p4l1text];
    
    self.p4l2text = [CCLabelTTF labelWithString:@"were the first to notice" fontName:@"PopplPontifexBE-Regular" fontSize:21];
    _p4l2text.position = ccp(winSize.width/3.15, winSize.height/8);
    _p4l2text.color = ccc3(0,0,0);
    _p4l2text.opacity = 0.0;
    [self addChild:_p4l2text];
    
    // make an object out of the action for reuse
    id delay4 = [CCDelayTime actionWithDuration:0.650];
    id fadeIn4 = [CCFadeIn actionWithDuration:0.600];
    id fadeP4 = [CCSequence actions:delay4, fadeIn4, nil];
    
    [_p4l1text runAction:fadeP4];
    [_p4l2text runAction:[[fadeP4 copy] autorelease]];
}

// messages for hiding our paragraphs
- (void) hideP1{
    // make an object out of the action for reuse
    id fadeOut = [CCFadeOut actionWithDuration:0.600];
    
    [_p1l1text runAction:fadeOut];
    [_p1l2text runAction:[[fadeOut copy] autorelease]];
    [_p1l3text runAction:[[fadeOut copy] autorelease]];
    [_p1l4text runAction:[[fadeOut copy] autorelease]];
    
}
- (void) hideP2{
    // make an object out of the action for reuse
    id fadeOut2 = [CCFadeOut actionWithDuration:0.600];
    
    [_p2l1text runAction:fadeOut2];
    [_p2l2text runAction:[[fadeOut2 copy] autorelease]];
    [_p2l3text runAction:[[fadeOut2 copy] autorelease]];
}
- (void) hideP3{
    // make an object out of the action for reuse
    id fadeOut3 = [CCFadeOut actionWithDuration:0.600];
    
    [_p3l1text runAction:fadeOut3];
    [_p3l2text runAction:[[fadeOut3 copy] autorelease]];
    [_p3l3text runAction:[[fadeOut3 copy] autorelease]];
    [_p3l4text runAction:[[fadeOut3 copy] autorelease]];
    [_p3l5text runAction:[[fadeOut3 copy] autorelease]];    
}
- (void) hideP4{
    // make an object out of the action for reuse
    id fadeOut4 = [CCFadeOut actionWithDuration:0.600];
    
    [_p4l1text runAction:fadeOut4];
    [_p4l2text runAction:[[fadeOut4 copy] autorelease]];
}


-(void) swipeRightComplete{
    if (!touched) {
        touched=!touched;
    }        
    
    swipeCount--;
    
    switch (swipeCount) {
        case 0:
        {
            [self hideP2];
            
            [self showP1];
            
            self.isTouchEnabled = TRUE;
            
            break;
        }
        case 1:
        {   
            [self hideP3];

            [self showP2];
            
            self.isTouchEnabled = TRUE;
            
            break;
        }
        case 2:
        {
            break;
        }
        default:
            break;
    }
    
    if (swipeCount == -1) {
        IntroScene *introScene = [IntroScene node];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn 
                                                   transitionWithDuration:1.0 
                                                   scene:introScene 
                                                   backwards:TRUE]];
        
        swipeCount = 0;
    }
    
    NSLog(@"Swipe count: %i", swipeCount);

}

-(void) swipeLeftComplete{
    if (!touched) {
        touched=!touched;
    }        
    
    self.isTouchEnabled = FALSE;
    
    swipeCount++;
    
    switch (swipeCount) {
        case 1:
        {
            [self hideP1];
            
            [self showP2];
            
            self.isTouchEnabled = TRUE;
            
            break;
        }
        case 2:
        {
            [self hideP2];
            
            [self showP3];
            
            self.isTouchEnabled = TRUE;
            
            break;
        }
        case 3:
        {
            [self hideP3];
            
            [self showP4];
            
            self.isTouchEnabled = TRUE;
            break;
        }
        default:
            break;
    }
    
    if (swipeCount == 4) {
        PageTwoScene *pageTwoScene = [PageTwoScene node];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn 
                                                   transitionWithDuration:1.0 
                                                   scene:pageTwoScene 
                                                   backwards:FALSE]];
        GlobalDataManager *data = [[GlobalDataManager alloc] init];
        [data clearSwipeCount];
    }

    NSLog(@"Swipe count: %i", swipeCount);
}

- (void) enableSwipes {
    self.isTouchEnabled = TRUE;
}

- (void)dealloc {
    [_label release];
    _label = nil;
    
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
	[[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
	[[CCDirector sharedDirector] purgeCachedData];
	[self removeAllChildrenWithCleanup:YES];

    [super dealloc];
}

@end