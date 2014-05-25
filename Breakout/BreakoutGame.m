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
@property (assign, nonatomic) NSInteger curPlayerIndex;
@property (strong, nonatomic) BlockGrid *blockGrid;

@end

@implementation BreakoutGame

-(void)startGame;
{
    NSLog(@"in BreakoutGame: startGame");
    self.curPlayerIndex = 0;
    self.blockGrid = [[BlockGrid alloc] initRandomBlockGridWithDifficulty:1];

    NSLog(@"BlockGrid:\n%@",[self.blockGrid description]);
    Player *testPlayer1 = [[Player alloc] init];
    self.players = [NSMutableArray arrayWithArray:@[testPlayer1]];

    if ([self.delegate respondsToSelector:@selector(breakoutGame:blockGridHasNumberOfRows:)] &&
        [self.delegate respondsToSelector:@selector(breakoutGame:blockGridRow:hasBlocksWithBlockDescriptors:)])
    {
        [self.delegate breakoutGame:self blockGridHasNumberOfRows:self.blockGrid.blockRows];

        for (int curBlockRowNumber=0; curBlockRowNumber<self.blockGrid.blockRows; curBlockRowNumber++)
        {
            NSMutableArray *curBlockRowDescriptorArray = [[NSMutableArray alloc] init];
            BlockDescriptor *curBlockDescriptor = [[BlockDescriptor alloc] init];

            curBlockDescriptor.blockRow = curBlockRowNumber;
            NSInteger blocksInCurRow = [self.blockGrid numberOfBlocksInRowWithBlockDescriptor:curBlockDescriptor];

            for (int curBlockPositionNumber=0; curBlockPositionNumber<blocksInCurRow; curBlockPositionNumber++)
            {
                curBlockDescriptor.blockPosition = curBlockPositionNumber;
                NSLog(@"curBlockDescriptor (%d,%d)",curBlockDescriptor.blockRow,curBlockDescriptor.blockPosition);
                NSInteger curBlockStrength = [self.blockGrid blockStrengthOfBlockWithBlockDescriptor:curBlockDescriptor];
                curBlockDescriptor.blockStrength = curBlockStrength;
                [curBlockRowDescriptorArray addObject:curBlockDescriptor];
            }
            [self.delegate breakoutGame:self blockGridRow:curBlockRowNumber hasBlocksWithBlockDescriptors:curBlockRowDescriptorArray];
        }
    }
}


-(void)stopGame
{
    self.blockGrid = nil;
}


-(void)restartGame
{
    [self stopGame];
    [self startGame];
}


-(BOOL)destroyHitBlockWithBlockDescriptor:(BlockDescriptor *)BlockDescriptor
{
    BOOL blockHitHasBeenDestroyed = NO;
    NSInteger pointsGainedIfBlockDestroyed =[self.blockGrid destroyBlockWithBlockDescriptor:BlockDescriptor];

    if (pointsGainedIfBlockDestroyed > 0)
    {
        Player *curPlayer = [self.players objectAtIndex:self.curPlayerIndex];
        curPlayer.score += pointsGainedIfBlockDestroyed;
        blockHitHasBeenDestroyed = YES;
        if ([self.delegate respondsToSelector:@selector(breakoutGame:playerName:hasTurnsLeft:withClearBoardStatus:andCurrentScore:)])
        {
            // CRITICAL QUESTION: Is it ok for me to call a delegate method on my delegate now
            //    while this method hasn't yet returned to my delegate???  ...seems to work fine but I have to confirm if this is good design practice
            [self.delegate breakoutGame:self playerName:curPlayer.name hasTurnsLeft:curPlayer.turnsLeft withClearBoardStatus:NO andCurrentScore:curPlayer.score];
        }
    }
    return blockHitHasBeenDestroyed;
}


-(void)turnEnded
{
    Player *curPlayer = [self.players objectAtIndex:self.curPlayerIndex];
    curPlayer.turnsLeft--;
    self.curPlayerIndex++;
    self.curPlayerIndex %= self.players.count;

    if ([self.delegate respondsToSelector:@selector(breakoutGame:playerName:hasTurnsLeft:withClearBoardStatus:andCurrentScore:)])
    {
        // CRITICAL QUESTION: Is it ok for me to call a delegate method on my delegate now
        //    while this method hasn't yet returned to my delegate???  ...seems to work fine but I have to confirm if this is good design practice
        [self.delegate breakoutGame:self playerName:curPlayer.name hasTurnsLeft:curPlayer.turnsLeft withClearBoardStatus:NO andCurrentScore:curPlayer.score];
    }

}


-(NSInteger)turnsLeftForCurrentPlayer
{
    return [[self.players objectAtIndex:self.curPlayerIndex] turnsLeft];
}


@end
