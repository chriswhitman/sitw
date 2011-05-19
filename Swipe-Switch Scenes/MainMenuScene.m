//
//  MainMenuSceneS.m
//  Swipe-Switch Scenes
//
//  Created by Christopher Whitman on 3/22/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

// Import the interfaces
#import "MainMenuScene.h"
#import "PreBookScene.h"
#import "IntroScene.h"
#import "PageOneScene.h"
#import "PageTwoScene.h"
#import "PageThreeScene.h"
#import "CCTransition.h"
#import "GlobalDataManager.h"
#import "GameStateManager.h"


// MainMenuScene implementation
@implementation MainMenuLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainMenuLayer *layer = [MainMenuLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// set up our menus
- (void) setUpMenus
{
    
    // menu item to read the book
    CCMenuItemImage *menuItemReadToMe = [CCMenuItemImage 
                                             itemFromNormalImage:@"readToMe-ipad.png"
                                             selectedImage:@"readToMe-hover-ipad.png"
                                             target:self
                                             selector:@selector(setReadToMeFlagAndGoToBook:)];
    

    // menu item to read the book
    CCMenuItemImage *menuItemReadItMyself = [CCMenuItemImage 
                                                itemFromNormalImage:@"readItMyself-ipad.png"
                                                selectedImage:@"readItMyself-hover-ipad.png"
                                                target:self
                                                selector:@selector(setReadItMyselfFlagAndGoToBook:)];
    
    // menu item to read the book
    CCMenuItemImage *menuItemAutoPlay = [CCMenuItemImage 
                                             itemFromNormalImage:@"autoplay-ipad.png"
                                             selectedImage:@"autoplay-hover-ipad.png"
                                             target:self
                                             selector:@selector(setAutoPlayFlagAndGoToBook:)];
    
    
    // menu item to build a snowman game
    CCMenuItemImage *menuItemBuildASnowman = [CCMenuItemImage 
                                         itemFromNormalImage:@"buildASnowman-ipad.png"
                                         selectedImage:@"buildASnowman-hover-ipad.png"
                                         target:self
                                         selector:@selector(setAutoPlayFlagAndGoToBook:)];
    
    
    // create an instance of our menu
    CCMenu * mainMenu = [CCMenu menuWithItems:menuItemReadToMe, menuItemReadItMyself, menuItemAutoPlay, menuItemBuildASnowman, nil];
    
    // align our menu items
    [mainMenu alignItemsHorizontally];
    
    // get window parameters and put em in an object
    CGSize s = [[CCDirector sharedDirector] winSize];
    
    // move menu to right
    [mainMenu setPosition:ccp(s.width/2,60)];
    
    // add menu to our scene
    [self addChild:mainMenu];
    
}
// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
    if( (self=[super  initWithColor:ccc4(255, 255, 255, 255)] )) {
        
        GlobalDataManager *action = [[GlobalDataManager alloc]init];
        [action setUserIsInBookFlag];
        
        // initialize window object
        CGSize s = [[CCDirector sharedDirector] winSize];
        
        // add a background to the layer
        CCSprite* background = [CCSprite spriteWithFile:@"bg.jpg"];
        background.tag = 1;
        // background.opacity = 1.0;
        background.position = ccp(s.width/2, s.height/2);
        // background.anchorPoint = ccp(0,0);
        [self addChild:background];

        // add a background to the layer
        CCSprite* backgroundSnowman = [CCSprite spriteWithFile:@"bgSnowman-ipad.png"];
        backgroundSnowman.tag = 1;
        // background.opacity = 1.0;
        backgroundSnowman.position = ccp(s.width/2, s.height/2.43);
        // background.anchorPoint = ccp(0,0);
        [self addChild:backgroundSnowman];
        
        // add the top text to the layer
        CCSprite* main_menu_logo = [CCSprite spriteWithFile:@"mainMenuLogo-ipad.png"];
        main_menu_logo.tag = 1;
        main_menu_logo.opacity = 0.0;
        main_menu_logo.position = ccp(s.width/2, s.height/1.12);
        // background.anchorPoint = ccp(0,0);
        [self addChild:main_menu_logo];
        
        // fade logo in
        // delay first though
        // don't forget to pass CCSequence nil since it's an array of objects (NSArray)
        id logoDelay = [CCDelayTime actionWithDuration:.8];
        id fadeLogoIn = [CCFadeIn actionWithDuration:3];
        id mainMenuSequence = [CCSequence actions:logoDelay, fadeLogoIn, nil];
        
        [main_menu_logo runAction:mainMenuSequence];
        
        // add bottom text to the layer
        CCSprite* main_menu_bottom = [CCSprite spriteWithFile:@"authorNames-ipad.png"];
        main_menu_bottom.tag = 1;
        main_menu_bottom.position = ccp(s.width/2, s.height/1.34);
        main_menu_bottom.opacity = 0.0;
        [self addChild:main_menu_bottom];  
         
        id mainMenuBottomDelay = [CCDelayTime actionWithDuration:.8];
        id mainMenuBottomFadeIn = [CCFadeIn actionWithDuration:3];
        id MainMenuBottomSeq = [CCSequence actions: mainMenuBottomDelay, mainMenuBottomFadeIn, nil];
        
        [main_menu_bottom runAction:MainMenuBottomSeq];
        
        // add bottom text to the layer
        CCSprite* main_menu_top = [CCSprite spriteWithFile:@"photographFantasy-ipad.png"];
        main_menu_top.tag = 1;
        main_menu_top.position = ccp(s.width/2, s.height/1.25);
        main_menu_top.opacity = 0.0;
        [self addChild:main_menu_top];  

        
        id mainMenuTopDelay = [CCDelayTime actionWithDuration:.8];
        id mainMenuTopFadeIn = [CCFadeIn actionWithDuration:3];
        id MainMenuTopSeq = [CCSequence actions: mainMenuTopDelay, mainMenuTopFadeIn, nil];
        
        [main_menu_top runAction:MainMenuTopSeq];
        
        // PARTICLE SYSTEM EMITTER SETUP /////////////////////////////////////////
        // request window size
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        // initialize the particle system to be a snow system
        emitter = [CCParticleSnow  node]; 
        
        // add a texture (snowflake image in this case)
        emitter.texture = [[CCTextureCache sharedTextureCache] addImage:@"snow.png"]; //Set the texture to use our fire_particle.png
        
        // position the emitter (top-middle)
        emitter.position = ccp (winSize.width/2, winSize.height);
        
        emitter.life = 10;
        emitter.lifeVar = 1;
        
        
        // make the particles bigger for the ipad
        emitter.scale = 1.2;
        
        // set the gravity direction
        emitter.gravity = ccp(0,-10);
		
        // speed of particles
        emitter.speed = 15;
        emitter.speedVar = 30;
        
        [self addChild:emitter];
        // EMITTER SETUP END ///////////////////////////////////////////////////////
        
        // retrieve the state of the game for user preference
        /// int scene = [[NSUserDefaults standardUserDefaults] integerForKey:@"lastViewedScene"];
        
        // create and initialize a Label
		CCLabelTTF *logo = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:64];

		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
	
		// position the label on the center of the screen
		logo.position =  ccp( size.width /2 , size.height/1.3 );
		
		// add the label as a child to this Layer
		[self addChild: logo];
        
        [self setUpMenus];
	}
	return self;
}

// UIAlertView implementation
// The button index will allow us to use logic triggered by button's clicks
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        // since we're resuming, retrieve user preference from NSUserDefaults
        int lastSceneViewed = [[NSUserDefaults standardUserDefaults] integerForKey:@"lastViewedScene"];
        
        StoryStateManager *lastScene = [[StoryStateManager alloc] init];
        [lastScene resumeStoryToScene:lastSceneViewed];
    } else if (buttonIndex == 1) {
        PreBookScene *preBookScene = [PreBookScene node];
        [[CCDirector sharedDirector] replaceScene:preBookScene];
    } else if (buttonIndex == 2) {
        NSLog(@"Cancel button to UIAlertView was touched");
    }
}

- (void) promptToResumeOrStartOver
{
    // retrieve the last viewed scene from NSUserDefaults
    int lastSceneViewed = [[NSUserDefaults standardUserDefaults] integerForKey:@"lastViewedScene"];
    
    // check to see if the last viewed scene is the first scene of the book
    // if the last viewed scene is the first scene, skip the dialog/prompt 
    // and go directly to the first scene.
    if (lastSceneViewed > -1) {
        // UIAlertView usage
        UIAlertView *alert = [[UIAlertView alloc] init];
        [alert setTitle:@"Would you like to resume where you left off?"];
        [alert setDelegate:self];
        [alert addButtonWithTitle:@"Resume"]; // button index 0
        [alert addButtonWithTitle:@"Start Over"]; // button index 1
        [alert addButtonWithTitle:@"Cancel"]; 
        [alert show];
        [alert release];
    } else {
        // initialize data for story state then load first scene 
        // with resumeStoryToScene:(integer) function
        StoryStateManager *lastScene = [[StoryStateManager alloc] init];
        [lastScene resumeStoryToScene:-1];
    }
}

- (void) setReadToMeFlagAndGoToBook: (CCMenuItem *) menuitem 
{
    // set story play mode to "Read to Me"
    GlobalDataManager *data = [[GlobalDataManager alloc] init];
    [data setStoryPlayMode:@"readToMe"];
    
    [self promptToResumeOrStartOver];
}

- (void) setReadItMyselfFlagAndGoToBook: (CCMenuItem *) menuitem 
{
    // set story play mode to string
    GlobalDataManager *data = [[GlobalDataManager alloc] init];
    [data setStoryPlayMode:@"readItMyself"];
    
    [self promptToResumeOrStartOver];
}

- (void) setAutoPlayFlagAndGoToBook: (CCMenuItem *) menuitem 
{
    // set story play mode to auto play
    GlobalDataManager *data = [[GlobalDataManager alloc] init];
    [data setStoryPlayMode:@"autoPlay"];
    
    
    [self promptToResumeOrStartOver];
}

-(void) imageLoaded: (CCTexture2D*) sitw {

}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	[super dealloc];
}
@end
