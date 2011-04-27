//
//  GestureConfig.h
//  Swipe-Switch Scenes
//
//  Created by Christopher Whitman on 3/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

// gesture recognition configuration
[Gestures sharedGestures].swipeTolerance = 220;
[Gestures sharedGestures].pointResetLimit = 10;
[Gestures sharedGestures].delegate = self;
[Gestures sharedGestures].useX = NO;
[Gestures sharedGestures].useCircle = NO;
[Gestures sharedGestures].useSquare = NO;