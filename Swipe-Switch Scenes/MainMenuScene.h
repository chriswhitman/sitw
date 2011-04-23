//
//  MainMenuScene.h
//  Swipe-Switch Scenes
//
//  Created by Christopher Whitman on 3/22/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "CCParticleSystemPoint.h"
#import "CCParticleSystemQuad.h"



// MainMenuLayer
@interface MainMenuLayer : CCColorLayer
{
    CCParticleSystem *emitter;
}

// returns a CCScene that contains the MainMenuLayer as the only child
+(CCScene *) scene;

- (void) resumeOrStartOverAlert;
@end
