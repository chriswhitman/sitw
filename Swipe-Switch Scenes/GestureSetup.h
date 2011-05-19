//
//  GestureSetup.h
//  Swipe-Switch Scenes
//
//  Created by Christopher Whitman on 3/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.

// functions to make gestures work

// NOTE: ccTouchEnded lies in each scene's class 

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

