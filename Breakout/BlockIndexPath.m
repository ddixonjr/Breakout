//
//  BlockIndexPath.m
//  Breakout
//
//  Created by Dennis Dixon on 5/23/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import "BlockIndexPath.h"

@implementation BlockIndexPath

-(id)initWithRow:(NSInteger)row andPosition:(NSInteger)position
{
    self = [super init];
    if (self)
    {
        _blockRow = row;
        _blockPosition = position;
    }
    return self;

}

@end
