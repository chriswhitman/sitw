//
//  GlobalDataManager.h
//  Swipe-Switch Scenes
//
//  Created by Christopher Whitman on 3/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//This is a singleton, responsible for storing data that is accessible by anyone in the game
@interface GlobalDataManager : NSObject {

}

- (void) makeUserBeInBook;
- (void) removeUserFromBook;

@end

