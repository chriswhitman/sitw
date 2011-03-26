//
//  PageTwoScene.h
//  Swipe-Switch Scenes
//
//  Created by Christopher Whitman on 3/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Gestures.h"

@interface PageTwoLayer : CCColorLayer <GestureComplete> {
    bool touched;
    
    CCLabelTTF *_label;
}
@property (nonatomic, retain) CCLabelTTF *label;
@end

@interface PageTwoScene : CCScene {
    PageTwoLayer *_layer;
}
@property (nonatomic, retain) PageTwoLayer *layer;

+(id) scene;
-(void) swipeRightComplete;
-(void) swipeLeftComplete;
@end