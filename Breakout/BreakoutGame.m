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

@property (strong, nonatomic) NSArray *players;
@property (assign, nonatomic) NSInteger curPlayerIndex;
@property (strong, nonatomic) BlockGrid *blockGrid;

@end

@implementation BreakoutGame

// Creates a new BlockGrid object and calls it's delegate to inform it of the grid's characteristics
//   only passing an integer number of rows and arrays of BlockDescriptors
- (void)startGame:(BOOL)isNewGame
{
    NSLog(@"in BreakoutGame: startGame");
    if (isNewGame)
    {
        self.curPlayerIndex = 0;
        self.players = [self.playersManager allPlayers];
        [self initPlayers];
        self.blockGrid = [[BlockGrid alloc] initRandomBlockGridWithDifficulty:1];
    }
    else
    {
        Player *curPlayer = [self.players objectAtIndex:self.curPlayerIndex];
        NSInteger difficulty = curPlayer.round > 2 ? 2 : curPlayer.round;
        self.blockGrid = [[BlockGrid alloc] initRandomBlockGridWithDifficulty:difficulty];
    }

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

            // Build an array of BlockDescriptors describing the current row in the BlockGrid
            //   to pass via delegate method to the view controller managing the game views
            for (int curBlockPositionNumber=0; curBlockPositionNumber<blocksInCurRow; curBlockPositionNumber++)
            {
                curBlockDescriptor.blockPosition = curBlockPositionNumber;
//                NSLog(@"curBlockDescriptor (%d,%d)",curBlockDescriptor.blockRow,curBlockDescriptor.blockPosition);
                NSInteger curBlockStrength = [self.blockGrid blockStrengthOfBlockWithBlockDescriptor:curBlockDescriptor];
                curBlockDescriptor.blockStrength = curBlockStrength;
                [curBlockRowDescriptorArray addObject:curBlockDescriptor];
            }
            [self.delegate breakoutGame:self blockGridRow:curBlockRowNumber hasBlocksWithBlockDescriptors:curBlockRowDescriptorArray];
        }
        if ([self.delegate respondsToSelector:@selector(breakoutGame:playerName:hasTurnsLeft:withClearBoardStatus:andCurrentScore:)])
        {
            Player *curPlayer = [self.players objectAtIndex:self.curPlayerIndex];
            [self.delegate breakoutGame:self playerName:curPlayer.name hasTurnsLeft:curPlayer.turnsLeft withClearBoardStatus:NO andCurrentScore:curPlayer.score];
        }
    }
}


- (void)stopGame
{
    self.blockGrid = nil;
    // do I need to do more here to support the new separate Players model component?
}


- (void)restartGame:(BOOL)isNewGame
{
    [self stopGame];
    [self startGame:isNewGame];
}


- (void)initPlayers
{
    for (Player *curPlayer in self.players)
        [curPlayer resetForStartOfPlay];
}


- (BOOL)destroyHitBlockWithBlockDescriptor:(BlockDescriptor *)BlockDescriptor
{
    BOOL blockHitHasBeenDestroyed = NO;
    NSInteger pointsGainedIfBlockDestroyed =[self.blockGrid destroyBlockWithBlockDescriptor:BlockDescriptor];

    if (pointsGainedIfBlockDestroyed > 0)
    {
        Player *curPlayer = [self.players objectAtIndex:self.curPlayerIndex];
        curPlayer.score += pointsGainedIfBlockDestroyed;
        blockHitHasBeenDestroyed = YES;
        BOOL boardCleared = NO;

        if ([self.blockGrid isBlockGridCleared])
        {
            boardCleared = YES;
            curPlayer.round++;
        }

        if ([self.delegate respondsToSelector:@selector(breakoutGame:playerName:hasTurnsLeft:withClearBoardStatus:andCurrentScore:)])
        {
            // CRITICAL QUESTION: Is it ok for me to call a delegate method on my delegate now
            //    while this method hasn't yet returned to my delegate???  ...seems to work fine but I have to confirm if this is good design practice
            [self.delegate breakoutGame:self playerName:curPlayer.name hasTurnsLeft:curPlayer.turnsLeft withClearBoardStatus:boardCleared andCurrentScore:curPlayer.score];
        }
    }
    return blockHitHasBeenDestroyed;
}


- (void)turnEnded:(NSInteger)updatedScore
{
    Player *curPlayer = [self.players objectAtIndex:self.curPlayerIndex];
    curPlayer.score = updatedScore;
    curPlayer.turnsLeft--;

    if (curPlayer.turnsLeft <= 0)
    {
        NSString *prevPlayerName = curPlayer.name;
        if ((self.curPlayerIndex+1) >= self.players.count) // Look ahead to see if there is a next player
        {
            // Whole Game is Over so find the winner and call the delegate to announce
            NSInteger curPolledHighestScore = 0;
            NSString *curPolledHighestScorePlayerName = nil;
            for (Player *curPolledPlayer in self.players)
            {
                if (curPolledPlayer.score > curPolledHighestScore)
                {
                    curPolledHighestScore = curPolledPlayer.score;
                    curPolledHighestScorePlayerName = curPolledPlayer.name;
                }
            }
            if ([self.delegate respondsToSelector:@selector(breakoutGame:gameOverWithWinner:andScore:)])
            {
                [self.delegate breakoutGame:self gameOverWithWinner:curPolledHighestScorePlayerName andScore:curPolledHighestScore];
            }

        }
        else
        {   //  Start next player
            self.curPlayerIndex++;
            curPlayer = [self.players objectAtIndex:self.curPlayerIndex];
            if ([self.delegate respondsToSelector:@selector(breakoutGame:startNewPlayerNamed:withTurnsLeft:fromPreviousPlayer:)])
            {
                [self.delegate breakoutGame:self startNewPlayerNamed:curPlayer.name withTurnsLeft:curPlayer.turnsLeft fromPreviousPlayer:prevPlayerName];
            }
        }
    }
    else
    {
        if ([self.delegate respondsToSelector:@selector(breakoutGame:playerName:hasTurnsLeft:withClearBoardStatus:andCurrentScore:)])
        {
            [self.delegate breakoutGame:self playerName:curPlayer.name hasTurnsLeft:curPlayer.turnsLeft withClearBoardStatus:NO andCurrentScore:curPlayer.score];
        }
    }
}


- (NSInteger)turnsLeftForCurrentPlayer
{
    return [[self.players objectAtIndex:self.curPlayerIndex] turnsLeft];
}

@end
