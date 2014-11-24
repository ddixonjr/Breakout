//
//  BRKOPlayersManager.h
//  Breakout
//
//  Created by Dennis Dixon on 5/26/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRKOPlayer.h"


@interface BRKOPlayersManager : NSObject

- (NSArray *)allPlayers;
- (void)addPlayer:(BRKOPlayer *)playerName;
- (void)removePlayer:(BRKOPlayer *)player;

@end
