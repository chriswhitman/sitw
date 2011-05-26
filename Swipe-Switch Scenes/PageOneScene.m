#import "IntroScene.h"
#import "PageOneScene.h"
#import "PageTwoScene.h"
#import "CCTransition.h"
#import "CCTransitionPageTurn.h"
#import "MainMenuScene.h"
#import "GlobalDataManager.h"
#import "InStoryMenuManager.h"
#import "CGYAML.h"

int swipeCount = 0;
bool isForwardSwipe;
int paragraphToShow = 0;
int paragraphIndex = 0;
int count  = 0;
int count2 = 0;

@implementation PageOneScene
@synthesize layer = _layer;
@synthesize menuLayer = _menuLayer;

#define LINE_HEIGHT_SPACING = 28

- (id)init {
    
    if ((self = [super init])) {
        self.menuLayer = [PageOneMenuLayer node];
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

@implementation PageOneMenuLayer

-(id) init
{
    if( (self=[super initWithColor:ccc4(255,255,255,255)] )) {
        
        CCSprite* whiteBg = [CCSprite spriteWithFile:@"1024Filler-ipad.png"];
        //backgroundBluejay.tag = 1;
        // backgroundBluejay.anchorPoint = ccp(0,0);
        [whiteBg setScale:1.0]; 
        whiteBg.position = ccp(512, 384);
        // [self addChild:whiteBg];
    }	
    return self;
}
@end


@implementation PageOneLayer

@synthesize textView = _textView;

@synthesize label = _label;

@synthesize p1l1text = _p1l1text;
@synthesize p1l2text = _p1l2text;
@synthesize p1l3text = _p1l3text;
@synthesize p1l4text = _p1l4text;

@synthesize p2l1text = _p2l1text;
@synthesize p2l2text = _p2l2text;
@synthesize p2l3text = _p2l3text;

@synthesize p3l1text = _p3l1text;
@synthesize p3l2text = _p3l2text;
@synthesize p3l3text = _p3l3text;
@synthesize p3l4text = _p3l4text;
@synthesize p3l5text = _p3l5text;

@synthesize p4l1text = _p4l1text;
@synthesize p4l2text = _p4l2text;



-(id) init
{
    if( (self=[super initWithColor:ccc4(255,255,255,255)] ))
    {
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

        // Add our first paragraph 
        [self paragraphAndPageManager:paragraphToShow];

        CCSprite* background = [CCSprite spriteWithFile:@"Page1-ipad-small.jpeg"];
        [background setScale:1.0]; 
        background.position = ccp(s.width/2, s.height/2);
        [self addChild:background];
        // allow touches on scene
        self.isTouchEnabled=YES;
		touched=FALSE;
        
        // place back home button
        #include "PlaceBackHomeButton.h"
        
        // for panning/zooming simultaneously      
        //id action = [CCSpawn actions:
        //                 [CCDelayTime actionWithDuration:3.0],
        //                 [CCScaleTo actionWithDuration:12.0 scale:0.83],
        //                 [CCMoveTo actionWithDuration:12.0 position:ccp(s.width/2,s.width/2 - 125)],
        //                 nil];
        //[background runAction:action];
    
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"lastViewedScene"];
        
        int currentScene = [[NSUserDefaults standardUserDefaults] integerForKey:@"lastViewedScene"];
        NSLog(@"Current scene retrieved from NSUserDefaults: %i", currentScene);
        
    }	
    return self;
}

#include "GestureSetup.h"

- (void) paragraphAndPageManager: (int)paragraphToShow
{
    count2++;
    NSLog(@"Count2 -------------------------------- %i", count2);
    int numOfParagaphs = 0;
    
    CGYAML *yaml = [[CGYAML alloc] initWithPath:@"Page1.yaml"];
    
    NSDictionary *mapNode = [yaml documentRootNodeAtIndex:0]; 
    NSDictionary *paragraphs = [mapNode objectForKey:@"paragraphs"];
    
    // Sort out our keys alphabetically
    NSArray *paragraphsKeys = [paragraphs allKeys];
    NSArray *sortedKeys = [paragraphsKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    int heightSpacing = 0;
    
    for(NSDictionary *pgd in paragraphs)
    {
        numOfParagaphs++;
    }
    
    for(NSDictionary *pgd in paragraphs)
    {
        id object = [paragraphs objectForKey: [sortedKeys objectAtIndex:count]];
        // NSLog(@"%@", object);
        
        // Get our variables applicable to the entire paragraph
        NSString *startPosX = [object objectForKey:@"startPosX"];
        NSString *startPosY = [object objectForKey:@"startPosY"];
        
        // get the dictionary of all the lines of text
        NSDictionary *linesOfText = [object objectForKey:@"content"];
        
        // retrieve original set of dictionary's keys
        NSArray *linesOfTextKeys = [linesOfText allKeys];
        
        // create a new set of arrange keys based on original 
        NSArray *sortedKeys = [linesOfTextKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
        
        // line count, to keep track of which paragraph
        int pCount = 0;
        
        // Tracks the progressively increasing spacing between lines
        int lineHeightSpacing = 0;
        NSLog(@"paragraphToShow: %i", paragraphToShow);
        NSLog(@"Count inside objToRemove loop: %i", count);

        if (count == paragraphToShow)
        {   
            for(NSDictionary *l in linesOfText)
            {
                // make a new object with our lines of text now sorted (with our sorted keys)
                id lineData = [linesOfText objectForKey: [sortedKeys objectAtIndex:pCount]];

                //
                // Get our variables from YAML file for this paragraph
                //
                // gets the actual line of text content from object
                NSString *lineOfText = [lineData objectForKey:@"text"];
                // gets indent variable if there should be in text file
                NSString *lineIndent = [lineData objectForKey:@"indentAmount"];
                
                //
                // Cast our retrieved variables so they're usable
                //
                int startPosXCasted = [startPosX intValue];
                int startPosYCasted = [startPosY intValue];
                int lineIndentCasted = [lineIndent intValue];
                
                // build out label
                CCLabelTTF *label = [CCLabelTTF labelWithString:lineOfText fontName:@"PopplPontifexBE-Regular" fontSize:21];
                label.position = ccp(startPosXCasted+=lineIndentCasted, startPosYCasted+=lineHeightSpacing);
                label.color = ccc3(0,0,0); 
                label.tag = pCount;
                [self addChild:label z:1];	
                
                
                NSLog(@"%@", lineOfText);
                NSLog(@"Number of paragraphs: %i", numOfParagaphs);
                
                pCount++;
                
                // this controls the spacing between lines
                lineHeightSpacing = lineHeightSpacing - 30;
            }
            break;
        }
        count++;
    }
    
    paragraphToShow++;
}



- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"Swipe count: %i", swipeCount);
    

    [[CCDirector sharedDirector] setDepthTest:YES]; 
    
    // forward swipe, moves story forward
    // maybe debug and check direction of swipe
    [self paragraphAndPageManager:paragraphToShow+1];
    
    
//    if(isForwardSwipe)
//    {
//        swipeCount++;
//
//        [self paragraphAndPageManager:paragraphToShow+1];
//                
//        if (swipeCount == 4)
//        {        
//            swipeCount = 0;
//            
//            PageTwoScene *pageTwoScene = [PageTwoScene node];
//            [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn 
//                                                       transitionWithDuration:1.0 
//                                                       scene:pageTwoScene 
//                                                       backwards:FALSE]];
//        }
//    // backward swipe, moves story backward
//    } else {
//        swipeCount--;
//        
//        switch (swipeCount)
//        {
//            case 0:
//            {
//                [self hideP2];
//                
//                [self showP1];
//                
//                break;
//            }
//            case 1:
//            {   
//                [self hideP3];
//                
//                [self showP2];
//                
//                break;
//            }
//            case 2:
//            {
//                break;
//            }
//            default:
//                break;
//        }
//        
//        if (swipeCount == -1)
//        {
//            swipeCount = 0;
//            
//            IntroScene *introScene = [IntroScene node];
//            [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn 
//                                                       transitionWithDuration:1.0 
//                                                       scene:introScene 
//                                                       backwards:TRUE]];
//        }
//        
//    }
//    
//	NSLog(@"Touch Ended:%@", touch);
}


#include "addBackHomeButton.h"

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
- (void) showP4{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    // let's play with our properties!
    self.p4l1text = [CCLabelTTF labelWithString:@"The birds" fontName:@"PopplPontifexBE-Regular" fontSize:21];
    _p4l1text.position = ccp(winSize.width/3.6, winSize.height/6.1);
    _p4l1text.color = ccc3(0,0,0);
    _p4l1text.opacity = 0.0;
    [self addChild:_p4l1text];
    
    self.p4l2text = [CCLabelTTF labelWithString:@"were the first to notice" fontName:@"PopplPontifexBE-Regular" fontSize:21];
    _p4l2text.position = ccp(winSize.width/3.15, winSize.height/8);
    _p4l2text.color = ccc3(0,0,0);
    _p4l2text.opacity = 0.0;
    [self addChild:_p4l2text];
    
    // make an object out of the action for reuse
    id delay4 = [CCDelayTime actionWithDuration:0.450];
    id fadeIn4 = [CCFadeIn actionWithDuration:0.250];
    id fadeP4 = [CCSequence actions:delay4, fadeIn4, nil];
    
    [_p4l1text runAction:fadeP4];
    [_p4l2text runAction:[[fadeP4 copy] autorelease]];
}

// messages for hiding our paragraphs
- (void) hideP1{
    // make an object out of the action for reuse
    id fadeOut = [CCFadeOut actionWithDuration:0.250];
    
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
- (void) hideP4{
    // make an object out of the action for reuse
    id fadeOut4 = [CCFadeOut actionWithDuration:0.250];
    
    [_p4l1text runAction:fadeOut4];
    [_p4l2text runAction:[[fadeOut4 copy] autorelease]];
}


-(void) swipeRightComplete{
    if (!touched)
    {
        touched=!touched;
    }
    
    isForwardSwipe = NO;
}

-(void) swipeLeftComplete
{
    if (!touched)
    {
        touched=!touched;
    }        
    
    isForwardSwipe = YES;
}

- (void)dealloc
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