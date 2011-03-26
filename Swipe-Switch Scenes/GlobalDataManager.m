//
//  GlobalDataManager.m
//  Swipe-Switch Scenes
//
//  Created by Christopher Whitman on 3/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GlobalDataManager.h"


@implementation GlobalDataManager

- (void) makeUserBeInBook{
    extern BOOL isInBook;
    isInBook = TRUE;
}

- (void) removeUserFromBook{
    extern BOOL isInBook;
    isInBook = FALSE;
}

@end
