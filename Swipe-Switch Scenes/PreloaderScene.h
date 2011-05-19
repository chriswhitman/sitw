//
//  PreloaderScene.h
//  Stranger in the Woods Storybook
//
//  Created by Christopher Whitman on 5/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "CCParticleSystemPoint.h"
#import "CCParticleSystemQuad.h"
#import "ResourcesLoader.h"
#import "Gestures.h"

// Preloader layer
@interface PreloaderLayer : CCColorLayer
{
    bool touched;
    
    CCLabelTTF *_label;
	CCLabelTTF *_loadingLabel;
    
    CCProgressTimer *_progress;
}


// returns a CCScene that contains the MainMenuLayer as the only child
+(CCScene *) scene;


@property (nonatomic, retain) CCLabelTTF *label;
@end

@interface PreloaderScene : CCScene {
    PreloaderLayer *_layer;
}
@property (nonatomic, retain) PreloaderLayer *layer;

+ (id) scene;
- (void) resourcesFinishedLoading;
- (void) addTapToCont;
- (void) loadMainMenu;
- (void) initPreloader;

@end