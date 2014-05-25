//
//  BlockGrid.m
//  Breakout
//
//  Created by Dennis Dixon on 5/23/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import "BlockGrid.h"
#import "Block.h"


@interface BlockGrid ()

@property (strong, nonatomic) NSMutableArray *blockGridRowArray;
@property (assign, nonatomic) NSInteger totalBlocksInGrid;
@property (assign, nonatomic) NSInteger totalBlocksDestroyed;

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


// Builds the structure comprising the BlockGrid object--an NSArray pointing to 'row' NSArrays with Block objects
- (void)buildRandomBlockGridWithDifficulty:(NSInteger)difficulty
{
    self.totalBlocksInGrid = 0;
    self.totalBlocksDestroyed = 0;
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
            self.totalBlocksInGrid++;
            Block *curNewBlock = [[Block alloc] init];
            NSInteger curHitsToDestroy = (arc4random_uniform(kDefaultMaxBlockHitsToDestroy * difficulty) + 1);
            curNewBlock.hitsToDestroy = curHitsToDestroy;
            [curNewBlockRowArray addObject:curNewBlock];
        }
        [self.blockGridRowArray addObject:curNewBlockRowArray];
    }
}

// Returns the number of blocks in the row number specified in the blockDescriptor argument passed in
- (NSInteger)numberOfBlocksInRowWithBlockDescriptor:(BlockDescriptor *)blockDescriptor
{
    NSMutableArray *curBlockRow = [self.blockGridRowArray objectAtIndex:blockDescriptor.blockRow];
    return [curBlockRow count];
}

// Returns the block.pointValue if the block is destroyed by the hit, 0 if not destroyed
- (NSInteger)destroyBlockWithBlockDescriptor:(BlockDescriptor *)blockDescriptor
{
    NSInteger pointsIfDestroyed = 0;
    NSMutableArray *curBlockRowArray = [self.blockGridRowArray objectAtIndex:blockDescriptor.blockRow];
    Block *curBlockHit = [curBlockRowArray objectAtIndex:blockDescriptor.blockPosition];
    [curBlockHit logHit];
    NSLog(@"block at (%d,%d) hit and hasBeenDestroyed = %d",blockDescriptor.blockRow,blockDescriptor.blockPosition,curBlockHit.hasBeenDestroyed);

    if (curBlockHit.hasBeenDestroyed)
    {
        pointsIfDestroyed = curBlockHit.pointValue;
        self.totalBlocksDestroyed++;
//        [curBlockRowArray removeObjectAtIndex:BlockDescriptor.blockPosition];
    }

    return pointsIfDestroyed;
}

// Allows easy lookup of a given Block object in the BlockGrid using a BlockDescriptor object
- (NSInteger)blockStrengthOfBlockWithBlockDescriptor:(BlockDescriptor *)blockDescriptor
{
    NSMutableArray *curBlockRowArray = [self.blockGridRowArray objectAtIndex:blockDescriptor.blockRow];
    Block *polledBlock = [curBlockRowArray objectAtIndex:blockDescriptor.blockPosition];
    return polledBlock.hitsToDestroy;
}

- (BOOL)isBlockGridCleared
{
    return ((self.totalBlocksDestroyed >= self.totalBlocksInGrid) ? YES : NO);
}


@end