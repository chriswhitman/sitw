//
//  Page.h
//  Swipe-Switch Scenes
//
//  Created by Christopher Whitman on 3/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Gestures.h"

@interface Page : CCLayer <GestureComplete> {
	bool touched;
}

+(id) scene;
-(void) swipeUpComplete;
-(void) swipeDownComplete;

@end