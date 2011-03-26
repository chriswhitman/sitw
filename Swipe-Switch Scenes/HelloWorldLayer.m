//
//  HelloWorldLayer.m
//  Swipe-Switch Scenes
//
//  Created by Christopher Whitman on 3/22/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "PageOneScene.h"
#import "PageThreeScene.h"
#import "CCTransition.h"
#import "PageTwoScene.h"

BOOL gUserInBook = FALSE;

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
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
        
        PageOneScene *action = [[PageOneScene alloc]init];
        [action makeUserBeInBook];
        
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
        /// int scene = [[NSUserDefaults standardUserDefaults] integerForKey:@"currentScene"];
        
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
    if (buttonIndex == 0) // if user wants to resume
    {
        PageOneScene *pageOneScene = [PageOneScene node];
        [[CCDirector sharedDirector] replaceScene:pageOneScene];
    }
    else if (buttonIndex == 1) // if user wants to start over
    {
        PageOneScene *pageOneScene = [PageOneScene node];
        [[CCDirector sharedDirector] replaceScene:pageOneScene];
    }
    else if (buttonIndex == 2) // cancel (stay on main menu)
    {
        NSLog(@"Cancel button to UIAlertView was touched");
    }
}

- (void) promptToResumeOrStartOver
{
    extern BOOL isInBook;
    NSLog(@"%s", (isInBook)?"true":"false");
    PageOneScene *action = [[PageOneScene alloc]init];
    [action removeUserFromBook];
    NSLog(@"%s", (isInBook)?"true":"false");
    
    
    // UIAlertView usage
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setTitle:@"Would you like to resume where you left off?"];
    [alert setDelegate:self];
    [alert addButtonWithTitle:@"Resume"]; // button index 0
    [alert addButtonWithTitle:@"Start Over"]; // button index 1
    [alert addButtonWithTitle:@"Cancel"]; 
    [alert show];
    [alert release];
}

- (void) setReadToMeFlagAndGoToBook: (CCMenuItem *) menuitem 
{
    [self promptToResumeOrStartOver];
}

- (void) setReadItMyselfFlagAndGoToBook: (CCMenuItem *) menuitem 
{
    [self promptToResumeOrStartOver];
    
    // PageOneScene *pageOneScene = [PageOneScene node];
    // [[CCDirector sharedDirector] replaceScene:pageOneScene];
}

- (void) setAutoPlayFlagAndGoToBook: (CCMenuItem *) menuitem 
{
    [self promptToResumeOrStartOver];
    
    // PageOneScene *pageOneScene = [PageOneScene node];
    // [[CCDirector sharedDirector] replaceScene:pageOneScene];
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
