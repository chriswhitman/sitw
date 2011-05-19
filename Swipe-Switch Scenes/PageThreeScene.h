//
//  PageThreeScene.h
//  Swipe-Switch Scenes
//
//  Created by Christopher Whitman on 3/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Gestures.h"


@interface PageThreeLayer : CCColorLayer <GestureComplete> {
    bool touched;
    
    CCLabelTTF *_label;
}
@property (nonatomic, retain) CCLabelTTF *label;
@end

@interface PageThreeScene : CCScene {
    PageThreeLayer *_layer;
}
@property (nonatomic, retain) PageThreeLayer *layer;


+(id) scene;
-(void) swipeRightComplete;
-(void) swipeLeftComplete;
@end