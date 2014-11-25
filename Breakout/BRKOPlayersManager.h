//
//  BRKOPlayersManager.h
//  Breakout
//
//  Created by Dennis Dixon on 5/26/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRKOPlayer.h"

/**
 *  A controller class that facilitates access to and management of a group of players of a game of breakout.
 */
@interface BRKOPlayersManager : NSObject

/**
 *  Returns a reference to the array of players within the instance of BRKOPlayersManager.
 *
 *  @return a reference to the array of players within the instance of BRKOPlayersManager.
 */
- (NSArray *)allPlayers;


/**
 *  Adds a player to the list of players within the players manager.
 *
 *  @param playerName The name of the player to be added.
 */
- (void)addPlayer:(BRKOPlayer *)playerName;


/**
 *  Removes a player from the list of players within the players manager.
 *
 *  @param player The name of the player to be removed.
 */
- (void)removePlayer:(BRKOPlayer *)player;

@end
