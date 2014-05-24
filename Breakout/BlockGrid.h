//
//  BlockGrid.h
//  Breakout
//
//  Created by Dennis Dixon on 5/23/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlockIndexPath.h"

@interface BlockGrid : NSObject

@property (assign, nonatomic) NSInteger maxBlockGridRows;
@property (assign, nonatomic) NSInteger maxBlockGridBlocksPerRow;

-(id)initRandomBlockGrid;
-(NSInteger)destroyBlockAtBlockIndexPath:(BlockIndexPath *)blockIndexPath;

@end
