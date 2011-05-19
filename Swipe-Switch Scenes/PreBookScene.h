//
//  PreBookScene.h
//  Stranger in the Woods Storybook
//
//  Created by Christopher Whitman on 4/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Gestures.h"

@interface PreBookLayer : CCColorLayer <GestureComplete> {
    
    bool touched;
    
    CCLabelTTF *_label;
    
}
@property (nonatomic, retain) CCLabelTTF *label;
@end

@interface PreBookScene : CCScene {
    PreBookLayer *_layer;
}
@property (nonatomic, retain) PreBookLayer *layer;

+(id) scene;
-(void) swipeRightComplete;
-(void) swipeLeftComplete;
-(void) goToHomeScreen;

@end
