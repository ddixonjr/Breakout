//
//  BlockGrid.m
//  Breakout
//
//  Created by Dennis Dixon on 5/23/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import "BlockGrid.h"
#import "Block.h"

#define kDefaultMaxBlockGridRows  5
#define kDefaultMaxBlockGridBlocksPerRow  10
#define kDefaultMaxBlockHitsToDestroy  2


@interface BlockGrid ()

@property (strong, nonatomic) NSMutableArray *blockGridRowArray;

@end

@implementation BlockGrid

- (id)init
{
    return [self initRandomBlockGridWithDifficulty:1];
}

- (id)initRandomBlockGridWithDifficulty:(NSInteger)difficulty
{
    self = [super init];
    if (self)
    {
        [self buildRandomBlockGridWithDifficulty:difficulty];
    }
    return self;
}


- (void)buildRandomBlockGridWithDifficulty:(NSInteger)difficulty
{
    self.blockRows = kDefaultMaxBlockGridRows;
    self.blockCountPerRowArray = [[NSMutableArray alloc] init];
    self.blockGridRowArray = [[NSMutableArray alloc] init];

    for (int curBlockRow=0; curBlockRow<self.blockRows; curBlockRow++)
    {
        int curRandomNumberOfBlocks = (arc4random_uniform(kDefaultMaxBlockGridBlocksPerRow * difficulty) + 1);
        [self.blockCountPerRowArray addObject:[NSNumber numberWithInt:curRandomNumberOfBlocks]];
        NSMutableArray *curNewBlockRowArray = [[NSMutableArray alloc] init];

        for (int curBlockRow=0; curBlockRow<curRandomNumberOfBlocks; curBlockRow++)
        {
            Block *curNewBlock = [[Block alloc] init];
            NSInteger curHitsToDestroy = (arc4random_uniform(kDefaultMaxBlockHitsToDestroy * difficulty) + 1);
            curNewBlock.hitsToDestroy = curHitsToDestroy;
            [curNewBlockRowArray addObject:curNewBlock];
        }
        [self.blockGridRowArray addObject:curNewBlockRowArray];
    }
}

- (NSInteger)numberOfBlocksInRowWithBlockDescriptor:(BlockDescriptor *)BlockDescriptor
{
    NSMutableArray *curBlockRow = [self.blockGridRowArray objectAtIndex:BlockDescriptor.blockRow];
    return [curBlockRow count];
}


- (NSInteger)destroyBlockWithBlockDescriptor:(BlockDescriptor *)BlockDescriptor
{
    NSInteger pointsIfDestroyed = 0;
    NSMutableArray *curBlockRowArray = [self.blockGridRowArray objectAtIndex:BlockDescriptor.blockRow];
    Block *curBlockHit = [curBlockRowArray objectAtIndex:BlockDescriptor.blockPosition];
    [curBlockHit logHit];
    NSLog(@"block at (%d,%d) hit and hasBeenDestroyed = %d",BlockDescriptor.blockRow,BlockDescriptor.blockPosition,curBlockHit.hasBeenDestroyed);

    if (curBlockHit.hasBeenDestroyed)
    {
        pointsIfDestroyed = curBlockHit.pointValue;
        [curBlockRowArray removeObjectAtIndex:BlockDescriptor.blockPosition];
    }

    return pointsIfDestroyed;
}

- (NSInteger)blockStrengthOfBlockWithBlockDescriptor:(BlockDescriptor *)BlockDescriptor
{
    NSMutableArray *curBlockRowArray = [self.blockGridRowArray objectAtIndex:BlockDescriptor.blockRow];
    Block *polledBlock = [curBlockRowArray objectAtIndex:BlockDescriptor.blockPosition];
    return polledBlock.hitsToDestroy;
}


//-(NSString *)description
//{
//    NSString *message = nil;
//    for (NSMutableArray *curRowArray in self.blockGridRowArray)
//    {
//        [message stringByAppendingString:@"Block Row Begin:\n"];
//        for (Block *curBlock in curRowArray)
//            [message stringByAppendingString:[curBlock description]];
//
//        message = @"";
//    }
//    return message;
//}


@end
