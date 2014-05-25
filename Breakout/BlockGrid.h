//
//  BlockGrid.h
//  Breakout
//
//  Created by Dennis Dixon on 5/23/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlockDescriptor.h"

@interface BlockGrid : NSObject

@property (strong, nonatomic) NSMutableArray *blockCountPerRowArray;
@property (assign, nonatomic) NSInteger blockRows;

- (id)initRandomBlockGridWithDifficulty:(NSInteger)difficulty;
- (NSInteger)destroyBlockWithBlockDescriptor:(BlockDescriptor *)BlockDescriptor;
- (NSInteger)numberOfBlocksInRowWithBlockDescriptor:(BlockDescriptor *)BlockDescriptor;
- (NSInteger)blockStrengthOfBlockWithBlockDescriptor:(BlockDescriptor *)BlockDescriptor;

@end
