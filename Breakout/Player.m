//
//  Player.m
//  Breakout
//
//  Created by Dennis Dixon on 5/23/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import "Player.h"

@interface Player ()

@property (assign, nonatomic) BOOL turnsGone;

@end

@implementation Player

- (id)init
{
    return [self initWithName:@"Player 1" andTurnsAtStart:kDefaultNumberOfTurns];
}

- (id)initWithName:(NSString *)name andTurnsAtStart:(NSInteger)turnsAtStart
{
    self = [super init];
    if (self)
    {
        self.name = name;
        self.turnsLeft = turnsAtStart;
        self.turnsGone = NO;
    }

    return self;
}

- (void)turnLost
{
    self.turnsLeft--;
    if (self.turnsLeft <= 0)
    {
        self.turnsGone = YES;
    }
    else
        self.turnsGone = NO;
}


- (void)resetForStartOfPlay
{
    self.score = 0;
    self.turnsLeft = kDefaultNumberOfTurns;
}

@end
