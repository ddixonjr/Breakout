//
//  BRKOBlockGrid.h
//  Breakout
//
//  Created by Dennis Dixon on 5/23/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRKOBlockDescriptor.h"

/**
 *  A model class that represents a grid of blocks for a round of Breakout.  A block grid is a set of rows each of which contains a set of Breakout game blocks (BRKOBlock objects).  This class facilitates management of and access to information about the blocks within the grid throughout one full round of Breakout.
 */
@interface BRKOBlockGrid : NSObject

/**
 *  An array containing the number of blocks in each row of the grid.
 */
@property (strong, nonatomic) NSMutableArray *blockCountPerRowArray;


/**
 *  A convenience property to return the number rows in the block grid.
 */
@property (assign, nonatomic) NSInteger blockRows;


/**
 *  An initializer that instantiates a BRKOBlockGrid instance with a specified difficulty level where difficulty influences the number of blocks in each row and the number of hits required to destroy each block.
 *
 *  @param difficulty An integer influencing the overall difficulty of destroying the block grid.
 *
 *  @return A new instance of BRKOBlockGrid.
 */
- (id)initRandomBlockGridWithDifficulty:(NSInteger)difficulty;


/**
 *  A call indicating a hit/an attempt to destroy a block in the grid as indicated by the specified block descriptor.
 *
 *  @param BlockDescriptor The block hit and possibly destroyed.
 *
 *  @return An integer representing the point value of the block if has been destroyed.  A return value of zero indicates that the hit did not yet destroy the block.
 */
- (NSInteger)destroyBlockWithBlockDescriptor:(BRKOBlockDescriptor *)BlockDescriptor;


/**
 *  Returns the number of blocks in the same row as the block descriptor passed as an argument.
 *
 *  @param BlockDescriptor The BRKOBlockDescriptor instance carrying the row number for which the number of blocks is to be returned.
 *
 *  @return The number of blocks in the same row as the block descriptor passed as an argument.
 */
- (NSInteger)numberOfBlocksInRowWithBlockDescriptor:(BRKOBlockDescriptor *)BlockDescriptor;


/**
 *  Returns an integer representing the strength level of the block specified by the BRKOBlockDescriptor argument. Strength level is a value indicating the remaining staying power of the block.  Currently, that is the number of hits to destroy the block but could be enhanced to be a more complex measure of strength.
 *
 *  @param BlockDescriptor The BRKOBlockDescriptor indicating the block whose strength is being requested.
 *
 *  @return The strength level of the block specified by the BRKOBlockDescriptor argument.
 */
- (NSInteger)blockStrengthOfBlockWithBlockDescriptor:(BRKOBlockDescriptor *)BlockDescriptor;


/**
 *  Allows the board clear status to be queried.
 *
 *  @return An indicator of whether or not all the blocks in the board has been cleared.
 */
- (BOOL)isBlockGridCleared;


@end
