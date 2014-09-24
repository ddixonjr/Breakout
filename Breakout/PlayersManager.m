//
//  Players.m
//  Breakout
//
//  Created by Dennis Dixon on 5/26/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import "PlayersManager.h"


@interface PlayersManager ()

@property (strong, nonatomic) NSMutableArray *players;

@end


@implementation PlayersManager

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


- (void)addPlayer:(Player *)player
{
    Player *newPlayer = [[Player alloc] init];
    newPlayer = player;
    [self.players addObject:newPlayer];
}

- (void)removePlayer:(Player *)player
{
    for (int curIndex=0; curIndex<self.players.count; curIndex++)
    {
        Player *curPlayer = self.players[curIndex];
        if ([curPlayer isEqual:player])
        {
            [self.players removeObject:player];
        }
    }
}


@end
