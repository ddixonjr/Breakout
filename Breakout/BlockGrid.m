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

@interface BlockGrid ()

@property (strong, nonatomic) NSMutableArray *blockGridRowArray;

@end

@implementation BlockGrid

-(id)init
{
    return [self initRandomBlockGrid];
}

-(id)initRandomBlockGrid
{
    self = [super init];
    if (self)
    {
        [self buildRandomBlockGrid];
    }
    return self;
}


-(void)buildRandomBlockGrid
{
    for (int curBlockRow=0; curBlockRow<kDefaultMaxBlockGridRows; curBlockRow++)
    {
        int curRandomNumberOfBlocks = arc4random_uniform(kDefaultMaxBlockGridBlocksPerRow);
        NSMutableArray *curNewBlockRowArray = [[NSMutableArray alloc] init];

        for (int curBlockRow=0; curBlockRow<curRandomNumberOfBlocks; curBlockRow++)
        {
            Block *curNewBlock = [[Block alloc] init];
        }
        [self.blockGridRowArray addObject:curNewBlockRowArray];
    }

}

-(NSInteger)destroyBlockAtBlockIndexPath:(BlockIndexPath *)blockIndexPath
{
    return 0;
}

@end
