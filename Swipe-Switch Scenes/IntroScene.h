//
//  IntroScene.h
//  Stranger in the Woods Storybook
//
//  Created by Christopher Whitman on 4/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Gestures.h"

@interface IntroSceneMenuLayer : CCLayer <GestureComplete> {
    
    bool touched;
    
}

- (void)promptToGoHome;

@end

@interface IntroSceneLayer : CCColorLayer <GestureComplete> {
    
    bool touched;
    
    CCLabelTTF *_lineTwoText;
    CCLabelTTF *_lineThreeText;
    CCLabelTTF *_label;
    
}

@property (nonatomic, retain) CCLabelTTF *label;
@property (nonatomic, retain) CCLabelTTF *lineTwoText;
@property (nonatomic, retain) CCLabelTTF *lineThreeText;
@end

@interface IntroScene : CCScene {
    IntroSceneLayer *_layer;
    IntroSceneMenuLayer *_menuLayer;
}
@property (nonatomic, retain) IntroSceneLayer *layer;
@property (nonatomic, retain) IntroSceneMenuLayer *menuLayer;

+(id) scene;
-(void) swipeRightComplete;
-(void) swipeLeftComplete;

@end
