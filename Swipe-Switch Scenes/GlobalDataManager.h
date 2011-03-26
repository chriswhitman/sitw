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
	//Temporary values
	int currentScene;
	
	//Saved values
	BOOL gamePlayed;
	BOOL musicOn, sfxOn;
	
	//unused
	NSMutableArray *data;	
}

@property (nonatomic, readwrite) int currentScene;
@property (nonatomic, readwrite) BOOL gamePlayed;
@property (nonatomic, readwrite) BOOL musicOn, sfxOn;
@property (nonatomic, retain) NSMutableArray *data;


-(void) clearData;
+ (GlobalDataManager*)sharedDataManager;

@end

