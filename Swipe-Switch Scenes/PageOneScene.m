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
    id fadeIn = [CCFadeIn actionWithDuration:1.6];
    
    [_p1l1text runAction:fadeIn];
    [_p1l2text runAction:[[fadeIn copy] autorelease]];
    [_p1l3text runAction:[[fadeIn copy] autorelease]];
    [_p1l4text runAction:[[fadeIn copy] autorelease]];

    // this is to run sequential actions on an object
    // id MainMenuBottomSeq = [CCSequence actions: mainMenuBottomDelay, mainMenuBottomFadeIn, nil];
    
}
- (void) showP2{
    
}
- (void) showP3{
    
}
- (void) showP4{
    
}

// messages for hiding our paragraphs
- (void) hideP1{
    // make an object out of the action for reuse
    id fadeOut = [CCFadeOut actionWithDuration:1.6];
    
    [_p1l1text runAction:fadeOut];
    [_p1l2text runAction:[[fadeOut copy] autorelease]];
    [_p1l3text runAction:[[fadeOut copy] autorelease]];
    [_p1l4text runAction:[[fadeOut copy] autorelease]];}
- (void) hideP2{
    
}
- (void) hideP3{
    
}
- (void) hideP4{
    
}

// this will help us  manage our text
// based on the number  of swipes the
// user has made on the current scene
- (void) textController:(int)swipeCount:(bool)swipeIsForward {
    switch (swipeCount) {
        case 1:
        {
            if (swipeIsForward) {
                // hide first paragraph
                [self hideP1];
                
                //go to second paragraph
                [self showP2];
                break;
            } else  {
                
            }
            break;
        }
        case 2:
        {
            if (swipeIsForward) {
                // hide second paragraph
                [self hideP2];
                
                //go to third paragraph
                [self showP3];
            } else  {
                
            }
            break;
        }  
        case 3:
        {
            if (swipeIsForward) {
                
            } else  {
                
            }
            break;
        }  
        case 4:
        {
            if (swipeIsForward) {
                
            } else  {
                
            }
            break;
        }
        default:
            break;
    }
}

-(void) swipeRightComplete{
    if(!touched){
        touched=!touched;
        
        if (swipeCount > 0) {
            swipeCount--;
            [self textController:swipeCount :false];
        } else {
            IntroScene *introScene = [IntroScene node];
            [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn 
                                                       transitionWithDuration:1.0 
                                                       scene:introScene 
                                                       backwards:TRUE]];
        }
        

    }
}

-(void) swipeLeftComplete{
    if (!touched) {
        touched=!touched;
        
        if (swipeCount < 5) {
            swipeCount++;
            [self textController:swipeCount :true];
        } else {
            PageTwoScene *pageTwoScene = [PageTwoScene node];
            [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn 
                                                       transitionWithDuration:1.0 
                                                       scene:pageTwoScene 
                                                       backwards:TRUE]];
        }
    }
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