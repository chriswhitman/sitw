#import "PageOneScene.h"
#import "PageTwoScene.h"
#import "PageThreeScene.h"
#import "CCTransition.h"
#import "CCTransitionPageTurn.h"
#import "HelloWorldLayer.h"
#import "GlobalDataManager.h"


@implementation PageThreeScene
@synthesize layer = _layer;

- (id)init {
    
    if ((self = [super init])) {
        self.layer = [PageThreeLayer node];
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

@implementation PageThreeLayer
@synthesize label = _label;

-(id) init
{
    if( (self=[super initWithColor:ccc4(255,255,255,255)] )) {
        
        // allow touches on scene
        self.isTouchEnabled=YES;
		touched=FALSE;
        
        // set out current scene global (gCurrentScene) to the current scene
        GlobalDataManager *data = [[GlobalDataManager alloc] init];
        [data setCurrentScene:3];
        
        // set last viewed scene global varoable (gLastViewedScene gets set)
        GlobalDataManager *data_last_viewed = [[GlobalDataManager alloc] init];
        [data_last_viewed setLastViewedScene:3];
        
        #include "GestureConfig.h"
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        self.label = [CCLabelTTF labelWithString:@"Page three" fontName:@"Arial" fontSize:32];
        _label.color = ccc3(0,0,0);
        _label.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:_label];
        
        [[NSUserDefaults standardUserDefaults] setInteger:3 forKey:@"lastViewedScene"];
        
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
        
        PageTwoScene *pageTwoScene = [PageTwoScene node];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:1.0 scene:pageTwoScene backwards:TRUE]];
    }
}

-(void) swipeLeftComplete{
    NSLog(@"Swipe left.");
    if (!touched) {
        touched=!touched;
            
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