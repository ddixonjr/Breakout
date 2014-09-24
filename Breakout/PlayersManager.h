//
//  Players.h
//  Breakout
//
//  Created by Dennis Dixon on 5/26/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@interface PlayersManager : NSObject

- (NSMutableArray *)allPlayers;
- (void)addPlayer:(Player *)playerName;
- (void)removePlayer:(Player *)player;

@end
