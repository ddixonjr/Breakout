//
//  BreakoutGame.m
//  Breakout
//
//  Created by Dennis Dixon on 5/23/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import "BreakoutGame.h"
#import "Player.h"
#import "BlockGrid.h"

@interface BreakoutGame ()

@property (strong, nonatomic) NSMutableArray *players;
@property (assign, nonatomic) NSInteger numberOfPlayers;
@property (assign, nonatomic) NSInteger curPlayerIndex;
@property (strong, nonatomic) BlockGrid *blockGrid;

@end

@implementation BreakoutGame

-(void)startGame;
{
    self.curPlayerIndex = 0;
    self.blockGrid = [[BlockGrid alloc] initRandomBlockGrid];

}


-(NSInteger)destroyHitBlockAtBlockIndexPath:(BlockIndexPath *)blockIndexPath
{
    NSInteger pointsGainedIfBlockDestroyed =[self.blockGrid destroyBlockAtBlockIndexPath:blockIndexPath];
    if (pointsGainedIfBlockDestroyed > 0)
    {
        // What was I going to code on this line (37)???
        Player *curPlayer = [self.players objectAtIndex:self.curPlayerIndex];
        curPlayer.score += pointsGainedIfBlockDestroyed;
        return pointsGainedIfBlockDestroyed;
    }

    return 0;
}


-(void)turnEnded
{
    self.curPlayerIndex++;
    self.curPlayerIndex %= self.numberOfPlayers;
}


@end
