#import "IntroScene.h"
#import "PageOneScene.h"
#import "PageTwoScene.h"
#import "CCTransition.h"
#import "CCTransitionPageTurn.h"
#import "MainMenuScene.h"
#import "GlobalDataManager.h"

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


        CCSprite* background = [CCSprite spriteWithFile:@"Page1-ipad.jpg"];
        //background.tag = 1;
        background.position = ccp(s.width/2 + 160, s.height/2 - 75);
        // background.anchorPoint = ccp(0,0);
        //[background setScale:1.0]; 
        [self addChild:background];
            
        //id action = [CCSpawn actions:
        //                 [CCDelayTime actionWithDuration:3.0],
        //                 [CCScaleTo actionWithDuration:12.0 scale:0.83],
        //                 [CCMoveTo actionWithDuration:12.0 position:ccp(s.width/2,s.width/2 - 125)],
        //                 nil];
            
        //[background runAction:action];
    
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        // self.label = [CCLabelTTF labelWithString:@"Page one scene" fontName:@"Arial" fontSize:32];
        // _label.color = ccc3(0,0,0);
        // _label.position = ccp(winSize.width/2, winSize.height/2);
        // [self addChild:_label];
    
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"lastViewedScene"];
        
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

-(void) swipeRightComplete{
    if(!touched){
        touched=!touched;
        
        IntroScene *introScene = [IntroScene node];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:1.0 scene:introScene backwards:TRUE]];
    }
}

-(void) swipeLeftComplete{
    if (!touched) {
        touched=!touched;
        
        PageTwoScene *pageTwoScene = [PageTwoScene node];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:1.0 scene:pageTwoScene]];
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