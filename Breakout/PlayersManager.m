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
        [self loadPlayers];
    }
    return self;
}


- (NSMutableArray *)allPlayers;
{
    return self.players;
}


- (void)addPlayer:(Player *)player
{
    Player *newPlayer = [[Player alloc] init];
    newPlayer = player;
    [self.players addObject:newPlayer];
}


- (void)loadPlayers
{
    //  Temp code to load some placeholder players into the array
    Player *testPlayer = [[Player alloc] initWithName:@"Dennis" andTurnsAtStart:kDefaultNumberOfTurns];
    [self.players addObject:testPlayer];
}

@end
