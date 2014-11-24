//
//  BRKOPlayersManager.m
//  Breakout
//
//  Created by Dennis Dixon on 5/26/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import "BRKOPlayersManager.h"


@interface BRKOPlayersManager ()

@property (strong, nonatomic) NSMutableArray *players;

@end


@implementation BRKOPlayersManager

- (id)init
{
    self = [super init];
    if (self)
    {
        _players = [[NSMutableArray alloc] init];
    }
    return self;
}


- (NSArray *)allPlayers;
{
    return self.players;
}


- (void)addPlayer:(BRKOPlayer *)player
{
    BRKOPlayer *newPlayer = [[BRKOPlayer alloc] init];
    newPlayer = player;
    [self.players addObject:newPlayer];
}

- (void)removePlayer:(BRKOPlayer *)player
{
    for (int curIndex=0; curIndex<self.players.count; curIndex++)
    {
        BRKOPlayer *curPlayer = self.players[curIndex];
        if ([curPlayer isEqual:player])
        {
            [self.players removeObject:player];
        }
    }
}


@end
