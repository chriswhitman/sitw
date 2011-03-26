//
//  Page.m
//  Swipe-Switch Scenes
//
//  Created by Christopher Whitman on 3/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//#import "Page.h"

@implementation Page

+(id) scene
{
	CCScene *scene = [CCScene node];
	Page *layer = [Page node];
	[scene addChild: layer];
	return scene;
}

-(id) init
{
	if( (self=[super init] )) {
		self.isTouchEnabled=YES;
		touched=FALSE;
        
		[Gestures sharedGestures].swipeTolerance = 40;
		[Gestures sharedGestures].pointResetLimit = 10;
		[Gestures sharedGestures].delegate = self;
		[Gestures sharedGestures].useX = NO;
		[Gestures sharedGestures].useCircle = NO;
		[Gestures sharedGestures].useSquare = NO;
	}
	return self;
}

-(void) registerWithTouchDispatcher{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:kCCMenuTouchPriority swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
	[[Gestures sharedGestures] reset];
	return TRUE;
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
	CGPoint point = [touch locationInView: [touch view]];
	CGPoint converted = [[CCDirector sharedDirector] convertToGL:point];
	[[Gestures sharedGestures] addPoint:converted];
}

-(void) swipeUpComplete{
	NSLog(@"Swipe up.");
	if(!touched){
		touched=!touched;
		//do the transition
	}
}

-(void) swipeDownComplete{
	NSLog(@"Swipe down.");
	if(!touched){
		touched=!touched;
		//do the transition
	}
}

- (void) dealloc {
	[[CCTextureCache sharedTextureCache] removeUnusedTextures];
	[[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
	[[CCDirector sharedDirector] purgeCachedData];
	[self removeAllChildrenWithCleanup:YES];
	[super dealloc];
}
@end