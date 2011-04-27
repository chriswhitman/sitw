#import "PageTwoScene.h"
#import "PageOneScene.h"
#import "PageThreeScene.h"
#import "CCTransition.h"
#import "MainMenuScene.h"
#import "GlobalDataManager.h"

@implementation PageTwoScene
@synthesize layer = _layer;

- (id)init {
    
    if ((self = [super init])) {
        self.layer = [PageTwoLayer node];
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

@implementation PageTwoLayer
@synthesize label = _label;

-(id) init
{
    if( (self=[super initWithColor:ccc4(255,255,255,255)] )) {
        
        
        [self schedule:@selector(turnDepthTestOff) interval:0.9];
        
        
        CGSize s = [[CCDirector sharedDirector] winSize];
        
        CCSprite* backgroundDeer = [CCSprite spriteWithFile:@"Page2Deer-ipad.png"];
        //backgroundBluejay.tag = 1;
        // backgroundBluejay.anchorPoint = ccp(0,0);
        [backgroundDeer setScale:1.0]; 
        backgroundDeer.position = ccp(s.width + 30, s.height - 510);
        [self addChild:backgroundDeer];
        
        CCSprite* backgroundBluejay = [CCSprite spriteWithFile:@"Page2Bluejay-ipad.png"];
        //backgroundBluejay.tag = 1;
        // backgroundBluejay.anchorPoint = ccp(0,0);
        [backgroundBluejay setScale:1.0 ]; 
        backgroundBluejay.position = ccp(s.width/4.1, s.height/1.3);
        [self addChild:backgroundBluejay];

        CCSprite* wordWrap1 = [CCSprite spriteWithFile:@"Page2WordWrap1-ipad.png"];
        //backgroundBluejay.tag = 1;
        // backgroundBluejay.anchorPoint = ccp(0,0);
        [wordWrap1 setScale:1.0 ]; 
        wordWrap1.position = ccp(s.width/2, s.height/2);
        [self addChild:wordWrap1];
        
        // scale and pan to proper location
        //self.scale = 1.0;
        //self.position = CGPointMake(130, -80);
        
        // for panning/zooming simultaneously      
//        id action = [CCSpawn actions:
//                         [CCDelayTime actionWithDuration:20.0],
//                         [CCScaleTo actionWithDuration:8.0 scale:1.3],
//                         [CCMoveTo actionWithDuration:8.0 position:ccp(100, 100)],
//                         nil];
//        
//        
//        [self runAction:action];
//        
//        [self schedule:@selector(turnDepthTestOn) interval:9.0];

        
        // set out current scene global (gCurrentScene) to the current scene
        GlobalDataManager *data = [[GlobalDataManager alloc] init];
        [data setCurrentScene:2];
        
        // set last viewed scene global varoable (gLastViewedScene gets set)
        GlobalDataManager *data_last_viewed = [[GlobalDataManager alloc] init];
        [data_last_viewed setLastViewedScene:2];
        
        // allow touches on scene
        self.isTouchEnabled=YES;
		touched=FALSE;
        
        #include "GestureConfig.h"
        
        [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"lastViewedScene"];
        
        int currentScene = [[NSUserDefaults standardUserDefaults] integerForKey:@"lastViewedScene"];
        NSLog(@"Current scene retrieved from NSUserDefaults: %i", currentScene);
        
        
    }	
    return self;
}

#include "GestureSetup.h"

-(void) swipeRightComplete{
    NSLog(@"Swipe right.");

    if(!touched){
        touched=!touched;
        
        [[CCDirector sharedDirector] setDepthTest:YES]; 

        PageOneScene *pageOneScene = [PageOneScene node];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:1.0 scene:pageOneScene backwards:TRUE]];
    }
}

-(void) swipeLeftComplete{
    NSLog(@"Swipe left.");
    
    if (!touched) {
        touched=!touched;
        
        [[CCDirector sharedDirector] setDepthTest:YES]; 
        
        PageThreeScene *pageThreeScene = [PageThreeScene node];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:1.0 scene:pageThreeScene ]];
    }
}

-(void)turnDepthTestOn {
    
    [self unschedule:@selector(turnDepthTestOn)];
    
    
    [[CCDirector sharedDirector] setDepthTest:YES]; 
    
}

-(void)turnDepthTestOff {
    
    [self unschedule:@selector(turnDepthTestOff)];
    
    
    [[CCDirector sharedDirector] setDepthTest:NO]; 
    
}


-(void)dealloc {
    [_label release];
    _label = nil;
    
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
	[[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
	[[CCDirector sharedDirector] purgeCachedData];
	[self removeAllChildrenWithCleanup:YES];
    
    [[CCDirector sharedDirector] setDepthTest:YES]; 
    
    [super dealloc];
    
    
}

@end