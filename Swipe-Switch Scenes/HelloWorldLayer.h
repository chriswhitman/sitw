//
//  HelloWorldLayer.h
//  Swipe-Switch Scenes
//
//  Created by Christopher Whitman on 3/22/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "CCParticleSystemPoint.h"
#import "CCParticleSystemQuad.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
    CCParticleSystem *emitter;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
