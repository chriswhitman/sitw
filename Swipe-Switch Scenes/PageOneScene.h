//
//  PageOneScene.h
//  Swipe-Switch Scenes
//
//  Created by Christopher Whitman on 3/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Gestures.h"


@interface PageOneMenuLayer : CCColorLayer <GestureComplete> {
    
    bool touched;

}

@end

@interface PageOneLayer : CCColorLayer <GestureComplete> {
    
    UITextView *_textView;
    
    bool touched;
    CCLabelTTF *_label;
    // 1st paragph labels (lines of)
    CCLabelTTF *_p1l1text;
    CCLabelTTF *_p1l2text;
    CCLabelTTF *_p1l3text;
    CCLabelTTF *_p1l4text;
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
    // 4th paragph labels (lines of)
    CCLabelTTF *_p4l1text;
    CCLabelTTF *_p4l2text;
    
    
}


@property (nonatomic, retain) UITextView *textView;

@property (nonatomic, retain) CCLabelTTF *label;
// 1st paragraph
@property (nonatomic, retain) CCLabelTTF *p1l1text;
@property (nonatomic, retain) CCLabelTTF *p1l2text;
@property (nonatomic, retain) CCLabelTTF *p1l3text;
@property (nonatomic, retain) CCLabelTTF *p1l4text;
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
// 4rth paragraph
@property (nonatomic, retain) CCLabelTTF *p4l1text;
@property (nonatomic, retain) CCLabelTTF *p4l2text;


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

// Handles the paragraph text displaying
// this should be moved into it's own class
- (void) paragraphAndPageManager:(int)paragraphToShow;

// this will deal with controlling text
- (void) textController:(int)swipeCount:(bool)swipeIsForward;

@end

@interface PageOneScene : CCScene {
    PageOneLayer *_layer;
    PageOneMenuLayer *_menuLayer;
}
@property (nonatomic, retain) PageOneLayer *layer;
@property (nonatomic, retain) PageOneMenuLayer *menuLayer;

+ (id) scene;
- (void) swipeRightComplete;
- (void) swipeLeftComplete;
- (void) enableSwipes;
- (void) disableSwipes;



// this will help us  manage our text
// based on the number  of swipes the
// user has made on the current scene
- (void) storyManager:(int)swipeCount;

@end
