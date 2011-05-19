//
//  PageTwoScene.h
//  Swipe-Switch Scenes
//
//  Created by Christopher Whitman on 3/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Gestures.h"


@interface PageTwoBgLayer : CCColorLayer {
    bool touched;
}
@end


@interface PageTwoLayer : CCColorLayer <GestureComplete> {
    bool touched;
    
    // 1st paragph labels (lines of)
    CCLabelTTF *_p1l1text;
    CCLabelTTF *_p1l2text;
    CCLabelTTF *_p1l3text;
    CCLabelTTF *_p1l4text;
    CCLabelTTF *_p1l5text;
    CCLabelTTF *_p1l6text;
    // 2nd paragph labels (lines of)
    CCLabelTTF *_p2l1text;
    CCLabelTTF *_p2l2text;
    CCLabelTTF *_p2l3text;
    // 3rd paragph labels (lines of)
    CCLabelTTF *_p3l1text;
    CCLabelTTF *_p3l2text;
    CCLabelTTF *_p3l3text;
    CCLabelTTF *_p3l4text;
    CCLabelTTF *_p3l5text;
    
    CCLabelTTF *_label;
}


@property (nonatomic, retain) CCLabelTTF *label;
// 1st paragraph
@property (nonatomic, retain) CCLabelTTF *p1l1text;
@property (nonatomic, retain) CCLabelTTF *p1l2text;
@property (nonatomic, retain) CCLabelTTF *p1l3text;
@property (nonatomic, retain) CCLabelTTF *p1l4text;
@property (nonatomic, retain) CCLabelTTF *p1l5text;
@property (nonatomic, retain) CCLabelTTF *p1l6text;
// 2nd paragraph
@property (nonatomic, retain) CCLabelTTF *p2l1text;
@property (nonatomic, retain) CCLabelTTF *p2l2text;
@property (nonatomic, retain) CCLabelTTF *p2l3text;
// 3rd paragraph
@property (nonatomic, retain) CCLabelTTF *p3l1text;
@property (nonatomic, retain) CCLabelTTF *p3l2text;
@property (nonatomic, retain) CCLabelTTF *p3l3text;
@property (nonatomic, retain) CCLabelTTF *p3l4text;
@property (nonatomic, retain) CCLabelTTF *p3l5text;

// prototypes for showing paragraphs
- (void) showP1;
- (void) showP2;
- (void) showP3;
- (void) showP4;

// prototypes for hiding paragraphs
- (void) hideP1;
- (void) hideP2;
- (void) hideP3;
- (void) hideP4;

// this will deal with controlling text
- (void) textController:(int)swipeCount:(bool)swipeIsForward;
@end


@interface PageTwoScene : CCScene {
    PageTwoBgLayer *_bgLayer;
    PageTwoLayer *_layer;

}

@property (nonatomic, retain) PageTwoBgLayer *bgLayer;
@property (nonatomic, retain) PageTwoLayer *layer;

+(id) scene;
-(void) swipeRightComplete;
-(void) swipeLeftComplete;
-(void) turnDepthTestOn;
-(void) turnDepthTestOff;

@end