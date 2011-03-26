#import "PageTwoScene.h"
#import "PageOneScene.h"
#import "PageThreeScene.h"
#import "CCTransition.h"
#import "HelloWorldLayer.h"
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
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        self.label = [CCLabelTTF labelWithString:@"Page two" fontName:@"Arial" fontSize:32];
        _label.color = ccc3(0,0,0);
        _label.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:_label];
        
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
        
        PageOneScene *pageOneScene = [PageOneScene node];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:1.0 scene:pageOneScene backwards:TRUE]];
    }
}

-(void) swipeLeftComplete{
    NSLog(@"Swipe left.");
    if (!touched) {
        touched=!touched;
        
        PageThreeScene *pageThreeScene = [PageThreeScene node];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:1.0 scene:pageThreeScene ]];
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