//
//  MainMenuSceneS.m
//  Swipe-Switch Scenes
//
//  Created by Christopher Whitman on 3/22/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// Import the interfaces
#import "MainMenuScene.h"
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
                                             itemFromNormalImage:@"read_to_me.png"
                                             selectedImage:@"read_to_me_selected.png"
                                             target:self
                                             selector:@selector(setReadToMeFlagAndGoToBook:)];


    // menu item to read the book
    CCMenuItemImage *menuItemReadItMyself = [CCMenuItemImage 
                                                itemFromNormalImage:@"read_to_me.png"
                                                selectedImage:@"read_to_me_selected.png"
                                                target:self
                                                selector:@selector(setReadItMyselfFlagAndGoToBook:)];
    
    // menu item to read the book
    CCMenuItemImage *menuItemAutoPlay = [CCMenuItemImage 
                                             itemFromNormalImage:@"auto_play.png"
                                             selectedImage:@"auto_play_selected.png"
                                             target:self
                                             selector:@selector(setAutoPlayFlagAndGoToBook:)];
    
    
    // create an instance of our menu
    CCMenu * mainMenu = [CCMenu menuWithItems:menuItemReadToMe, menuItemReadItMyself, menuItemAutoPlay, nil];
    
    // align our menu items
    [mainMenu alignItemsVertically];
    
    // add menu to our scene
    [self addChild:mainMenu];
    
}
// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        GlobalDataManager *action = [[GlobalDataManager alloc]init];
        [action setUserIsInBookFlag];
        
        // add a background to the layer
        CCSprite* background = [CCSprite spriteWithFile:@"main_menu_background.png"];
        background.tag = 1;
        background.anchorPoint = CGPointMake(0, 0);
        [self addChild:background];
        
        // PARTICLE SYSTEM EMITTER SETUP /////////////////////////////////////////
        // request window size
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        // initialize the particle system to be a snow system
        emitter = [CCParticleSnow  node]; 
        
        // add a texture (snowflake image in this case)
        emitter.texture = [[CCTextureCache sharedTextureCache] addImage:@"snow.png"]; //Set the texture to use our fire_particle.png
        
        // position the emitter (top-middle)
        emitter.position = ccp (winSize.width/2, winSize.height);
        
        emitter.life = 4;
        emitter.lifeVar = 1;
        
        // gravity
        emitter.gravity = ccp(0,-10);
		
        // speed of particles
        emitter.speed = 87;
        emitter.speedVar = 30;
        
        [self addChild:emitter];
        // EMITTER SETUP END ///////////////////////////////////////////////////////
        
        // retrieve the state of the game for user preference
        /// int scene = [[NSUserDefaults standardUserDefaults] integerForKey:@"lastViewedScene"];
        
        // create and initialize a Label
		CCLabelTTF *logo = [CCLabelTTF labelWithString:@"*Book Name*" fontName:@"Marker Felt" fontSize:64];

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
        // that has the last viewed scene
        int lastSceneViewed = [[NSUserDefaults standardUserDefaults] integerForKey:@"lastViewedScene"];
        
        StoryStateManager *lastScene = [[StoryStateManager alloc] init];
        [lastScene resumeStoryToScene:lastSceneViewed];
    } else if (buttonIndex == 1) {
        PageOneScene *pageOneScene = [PageOneScene node];
        [[CCDirector sharedDirector] replaceScene:pageOneScene];
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
    if (lastSceneViewed > 1) {
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
        [lastScene resumeStoryToScene:1];
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


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	[super dealloc];
}
@end
