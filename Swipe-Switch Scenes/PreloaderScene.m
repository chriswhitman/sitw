//
//  PreloaderScene.m
//  Stranger in the Woods Storybook
//
//  Created by Christopher Whitman on 5/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

// Import the interfaces
#import "MainMenuScene.h"
#import "PreloaderScene.h"

NSArray *fullpath;

// MainMenuScene implementation
@implementation PreloaderLayer
@synthesize label = _label;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	PreloaderLayer *layer = [PreloaderLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
    if( (self=[super  initWithColor:ccc4(255, 255, 255, 255)] )) {
        
        [[CCDirector sharedDirector] setDepthTest:NO]; 

        
        // init view
		CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        // allow touches on scene
        self.isTouchEnabled=YES;
		touched=FALSE;
        
        // add greyscaled snowman icon
        CCSprite* preloaderBg = [CCSprite spriteWithFile:@"Default.png"];
        preloaderBg.rotation = -90.0;
        preloaderBg.position = ccp(winSize.width/2, winSize.height/2);
        [preloaderBg setScale:1.0]; 
        [self addChild:preloaderBg];
        
        
        [self initPreloader];
    }
	return self;
}

- (void) initPreloader
{    
    // init view
    CGSize winSize = [[CCDirector sharedDirector] winSize];
 
    _progress = [CCProgressTimer progressWithFile:@"Default-color.png"];
    _progress.type = kCCProgressTimerTypeVerticalBarBT;
    _progress.position = ccp(winSize.width / 2, winSize.height / 2);
    _progress.rotation = -90.0;
    
    [self addChild:_progress];
    
    //_loadingLabel = [CCLabelTTF labelWithString:@"Loading..." fontName:@"Marker Felt" fontSize:24];
    //_loadingLabel.position = ccp(winSize.width / 2, winSize.height / 2 + [_progress contentSize].height / 2 + [_loadingLabel contentSize].height);
    //[self addChild:_loadingLabel];
    
    // load resources
    ResourcesLoader *loader = [ResourcesLoader sharedLoader];
    NSArray *extensions = [NSArray arrayWithObjects:@"png", @"jpg", @"jpeg", @"wav", @"yaml", nil];
    
    for (NSString *extension in extensions) {
        NSArray *paths = [[NSBundle mainBundle] pathsForResourcesOfType:extension inDirectory:nil];
        for (NSString *filename in paths) {
            filename = [[filename componentsSeparatedByString:@"/"] lastObject];
            fullpath = [filename componentsSeparatedByString:@"/"];
            [loader addResources:filename, nil];
            NSLog(@"SUCCESSFULLY LOADED %@", fullpath);
        }
    }
    
    // load it async
    [loader loadResources:self];
}

- (void) registerWithTouchDispatcher {
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:kCCMenuTouchPriority swallowsTouches:YES];
}

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
	[[Gestures sharedGestures] reset];
	return TRUE;
}

- (void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
	CGPoint point = [touch locationInView: [touch view]];
	CGPoint converted = [[CCDirector sharedDirector] convertToGL:point];
	[[Gestures sharedGestures] addPoint:converted];
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    MainMenuLayer *mainMenuScene = [MainMenuLayer node];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipY transitionWithDuration:0.6 scene:mainMenuScene]];
}


- (void) didReachProgressMark:(CGFloat)progressPercentage
{
	[_progress setPercentage:progressPercentage * 100];
	
	if (progressPercentage == 1.0f) {
		//[_loadingLabel setString:@"Loading complete"];
        [self resourcesFinishedLoading];
        
        // allow touches on scene since loading is complete
        self.isTouchEnabled=YES;
		touched=FALSE;
	}
}

- (void) addTapToCont
{
    // init view
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    // build out our label on the screen
    [CCMenuItemFont setFontName:@"PopplPontifexBE-Regular"];
    [CCMenuItemFont setFontSize:32];
    CCMenuItemFont *tapToContButton = [[CCMenuItemFont alloc] initFromString:@"Tap to continue.." target:self selector:@selector(loadMainMenu)];
    tapToContButton.color = ccc3(168,34,28);
    
    // initialize menu and add button to it
    CCMenu *menu = [CCMenu menuWithItems:tapToContButton, nil];
    // position the menu 
    [menu setPosition:ccp(winSize.width/2, 175)];    
    // add menu to screen
    [self addChild:menu];
    
    // add fade in/out effects into memory
    id fadeIn = [CCFadeIn actionWithDuration:0.75];
    id fadeOut = [CCFadeOut actionWithDuration:0.75];
    
    // create a sequence of our actions and then repeat forever
    [tapToContButton runAction: [CCRepeatForever actionWithAction: [CCSequence actions: fadeIn, fadeOut, nil]]];
    
    
}

- (void) resourcesFinishedLoading
{
    [self addTapToCont];
}

- (void) loadMainMenu
{
    MainMenuLayer *mainMenuScene = [MainMenuLayer node];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipY transitionWithDuration:0.6 scene:mainMenuScene]];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
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