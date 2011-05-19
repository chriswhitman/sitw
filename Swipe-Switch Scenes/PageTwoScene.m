#import "PageTwoScene.h"
#import "PageOneScene.h"
#import "PageThreeScene.h"
#import "CCTransition.h"
#import "MainMenuScene.h"
#import "GlobalDataManager.h"

@implementation PageTwoScene
@synthesize layer = _layer;
@synthesize bgLayer = _bgLayer;

int swipeCount2 = 0;

- (id)init {
    
    if ((self = [super init])) {
        self.bgLayer = [PageTwoBgLayer node];
        self.layer = [PageTwoLayer node];
        [self addChild:_bgLayer];
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

@implementation PageTwoBgLayer

-(id) init
{
    if( (self=[super initWithColor:ccc4(255,255,255,255)] )) {
        
        CCSprite* whiteBg = [CCSprite spriteWithFile:@"1024Filler-ipad.png"];
        //backgroundBluejay.tag = 1;
        // backgroundBluejay.anchorPoint = ccp(0,0);
        [whiteBg setScale:1.0]; 
        whiteBg.position = ccp(512, 384);
        [self addChild:whiteBg];
    }	
    return self;
}
@end

@implementation PageTwoLayer
@synthesize label = _label;

@synthesize p1l1text = _p1l1text;
@synthesize p1l2text = _p1l2text;
@synthesize p1l3text = _p1l3text;
@synthesize p1l4text = _p1l4text;
@synthesize p1l5text = _p1l5text;
@synthesize p1l6text = _p1l6text;

@synthesize p2l1text = _p2l1text;
@synthesize p2l2text = _p2l2text;
@synthesize p2l3text = _p2l3text;

@synthesize p3l1text = _p3l1text;
@synthesize p3l2text = _p3l2text;
@synthesize p3l3text = _p3l3text;
@synthesize p3l4text = _p3l4text;
@synthesize p3l5text = _p3l5text;

-(id) init
{
    if( (self=[super initWithColor:ccc4(255,255,255,255)] )) {
        
        [self schedule:@selector(turnDepthTestOff) interval:0.95];
        
        CGSize s = [[CCDirector sharedDirector] winSize];
        
        self.position = CGPointMake(250, 0);
        
        CCSprite* background = [CCSprite spriteWithFile:@"Page2FullSpread-ipad.jpg"];
        //backgroundBluejay.tag = 1;
        // backgroundBluejay.anchorPoint = ccp(0,0);
        [background setScale:1.2]; 
        background.position = ccp(s.width/2, s.height/2);
        [self addChild:background];
        
//        CCSprite* whiteBgFarLeft = [CCSprite spriteWithFile:@"Page2WhiteFillerFarLeft-ipad.png"];
//        //backgroundBluejay.tag = 1;
//        // backgroundBluejay.anchorPoint = ccp(0,0);
//        [whiteBgFarLeft setScale:1.0]; 
//        whiteBgFarLeft.position = ccp(-170, 140);
//        [self addChild:whiteBgFarLeft];
//        
//        CCSprite* whiteBgLeft = [CCSprite spriteWithFile:@"Page2WhiteFillerLeft-ipad.png"];
//        //backgroundBluejay.tag = 1;
//        // backgroundBluejay.anchorPoint = ccp(0,0);
//        [whiteBgLeft setScale:1.0]; 
//        whiteBgLeft.position = ccp(180, -55);
//        [self addChild:whiteBgLeft];
//        
//        CCSprite* backgroundDeer = [CCSprite spriteWithFile:@"Page2Deer-ipad.png"];
//        //backgroundBluejay.tag = 1;
//        // backgroundBluejay.anchorPoint = ccp(0,0);
//        [backgroundDeer setScale:1.0]; 
//        backgroundDeer.position = ccp(s.width - 50, s.height - 600);
//        [self addChild:backgroundDeer];
//       
//        CCSprite* backgroundBluejay = [CCSprite spriteWithFile:@"Page2Bluejay-ipad.png"];
//        //backgroundBluejay.tag = 1;
//        // backgroundBluejay.anchorPoint = ccp(0,0);
//        [backgroundBluejay setScale:1.0 ]; 
//        backgroundBluejay.position = ccp(-60, s.height/1.3);
//        [self addChild:backgroundBluejay];
//
//        CCSprite* wordWrap1 = [CCSprite spriteWithFile:@"Page2WordWrap1-ipad.png"];
//        //backgroundBluejay.tag = 1;
//        // backgroundBluejay.anchorPoint = ccp(0,0);
//        [wordWrap1 setScale:1.0 ]; 
//        wordWrap1.position = ccp(220, s.height/1.6);
//        [self addChild:wordWrap1];
//
//        CCSprite* wordWrap2 = [CCSprite spriteWithFile:@"Page2WordWrap2-ipad.png"];
//        //backgroundBluejay.tag = 1;
//        // backgroundBluejay.anchorPoint = ccp(0,0);
//        [wordWrap2 setScale:1.0 ]; 
//        wordWrap2.position = ccp(1040, 490);
//        [self addChild:wordWrap2];
        
        // scale and pan to proper location
        //self.scale = 1.0;
        //self.position = CGPointMake(130, -80);
        

        
        //[self showP1];
        
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
        
        
        // place back home button
        //#include "PlaceBackHomeButton.h"
        
        [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"lastViewedScene"];
        
        int currentScene = [[NSUserDefaults standardUserDefaults] integerForKey:@"lastViewedScene"];
        NSLog(@"Current scene retrieved from NSUserDefaults: %i", currentScene);
        
        
    }	
    return self;
}

#include "GestureSetup.h"

#include "addBackHomeButton.h"

// message for showing first paragraph (P1)
- (void) showP1{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    // let's play with our properties!
    self.p1l1text = [CCLabelTTF labelWithString:@"\"Take care!" fontName:@"PopplPontifexBE-Regular" fontSize:21];
    _p1l1text.position = ccp(winSize.width/3.5, winSize.height/6.1);
    _p1l1text.color = ccc3(0,0,0);
    _p1l1text.opacity = 0.0;
    [self addChild:_p1l1text];
    
    self.p1l2text = [CCLabelTTF labelWithString:@"Take care!\"" fontName:@"PopplPontifexBE-Regular" fontSize:21];
    _p1l2text.position = ccp(winSize.width/3.18, winSize.height/8);
    _p1l2text.color = ccc3(0,0,0);
    _p1l2text.opacity = 0.0;
    [self addChild:_p1l2text];
    
    self.p1l3text = [CCLabelTTF labelWithString:@"The bluejays cawed" fontName:@"PopplPontifexBE-Regular" fontSize:21];
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
    id delay1 = [CCDelayTime actionWithDuration:0.320 ];
    id fadeIn1 = [CCFadeIn actionWithDuration:0.250];
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
    id delay2 = [CCDelayTime actionWithDuration:0.450];
    id fadeIn2 = [CCFadeIn actionWithDuration:0.250];
    id fadeP2 = [CCSequence actions:delay2, fadeIn2, nil];
    
    [_p2l1text runAction:fadeP2];
    [_p2l2text runAction:[[fadeP2 copy] autorelease]];
    [_p2l3text runAction:[[fadeP2 copy] autorelease]];
}
- (void) showP3{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    // let's play with our properties!
    self.p3l1text = [CCLabelTTF labelWithString:@"Daybreak came" fontName:@"PopplPontifexBE-Regular" fontSize:21];
    _p3l1text.position = ccp(winSize.width/4.6, winSize.height/5.0);
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
    id delay3 = [CCDelayTime actionWithDuration:0.450];
    id fadeIn3 = [CCFadeIn actionWithDuration:0.250];
    id fadeP3 = [CCSequence actions:delay3, fadeIn3, nil];
    
    [_p3l1text runAction:fadeP3];
    [_p3l2text runAction:[[fadeP3 copy] autorelease]];
    [_p3l3text runAction:[[fadeP3 copy] autorelease]];
    [_p3l4text runAction:[[fadeP3 copy] autorelease]];
    [_p3l5text runAction:[[fadeP3 copy] autorelease]];
    
}

// messages for hiding our paragraphs
- (void) hideP1{
    // make an object out of the action for reuse
    id fadeOut = [CCFadeOut actionWithDuration:0.250];
    
    // for panning/zooming simultaneously      
    id action = [CCSpawn actions:
                 [CCScaleTo actionWithDuration:8.0 scale:1.3],
                 //[CCMoveTo actionWithDuration:8.0 position:ccp(-590, 100)],
                 [CCMoveTo actionWithDuration:8.0 position:ccp(-590, 100)],
                 nil];
    
    [self runAction:action];
    
    [_p1l1text runAction:fadeOut];
    [_p1l2text runAction:[[fadeOut copy] autorelease]];
    [_p1l3text runAction:[[fadeOut copy] autorelease]];
    [_p1l4text runAction:[[fadeOut copy] autorelease]];
    
}
- (void) hideP2{
    // make an object out of the action for reuse
    id fadeOut2 = [CCFadeOut actionWithDuration:0.250];
    
    [_p2l1text runAction:fadeOut2];
    [_p2l2text runAction:[[fadeOut2 copy] autorelease]];
    [_p2l3text runAction:[[fadeOut2 copy] autorelease]];
}
- (void) hideP3{
    // make an object out of the action for reuse
    id fadeOut3 = [CCFadeOut actionWithDuration:0.250];
    
    [_p3l1text runAction:fadeOut3];
    [_p3l2text runAction:[[fadeOut3 copy] autorelease]];
    [_p3l3text runAction:[[fadeOut3 copy] autorelease]];
    [_p3l4text runAction:[[fadeOut3 copy] autorelease]];
    [_p3l5text runAction:[[fadeOut3 copy] autorelease]];    
}

-(void) swipeRightComplete{
    NSLog(@"Swipe right.");

    if(!touched){
        touched=!touched;
        
        [[CCDirector sharedDirector] setDepthTest:YES]; 

        [self stopAllActions];
        

    }
    
    swipeCount2--;
    
    switch (swipeCount2) {
        case 0:
        {
            [self hideP2];
            
            [self showP1];
            
            break;
        }
        case 1:
        {   
            [self hideP3];
            
            [self showP2];
            
            break;
        }
        case 2:
        {
            break;
        }
        default:
            break;
    }
    
    if (swipeCount2 == -1) {
        
        swipeCount2 = 0;
        
        PageOneScene *pageOneScene = [PageOneScene node];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:1.0 scene:pageOneScene backwards:TRUE]];    }
    
    NSLog(@"Swipe count: %i", swipeCount2);
}

-(void) swipeLeftComplete{
    
    if (!touched) {
        touched=!touched;        
        
        [self stopAllActions];
    }
    
    swipeCount2++;
    
    switch (swipeCount2) {
        case 1:
        {
            [self hideP1];
            
            [self showP2];
            
            break;
        }
        case 2:
        {
            [self hideP2];
            
            [self showP3];
            
            break;
        }
        default:
            break;
    }
    
    if (swipeCount2 == 3) {        
        
        swipeCount2 = 0;
        
        [[CCDirector sharedDirector] setDepthTest:YES]; 
        
        PageThreeScene *pageThreeScene = [PageThreeScene node];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:1.0 scene:pageThreeScene ]];
        
    }
    
    NSLog(@"Swipe count: %i", swipeCount2);
    
    
    
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
    
    [super dealloc];
    
    
}

@end