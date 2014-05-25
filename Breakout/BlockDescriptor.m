//
//  BlockDescriptor.m
//  Breakout
//
//  Created by Dennis Dixon on 5/23/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import "BlockDescriptor.h"

@implementation BlockDescriptor

-(id)init
{
    return [self initWithRow:0 andPosition:0 andStrength:1];
}

-(id)initWithRow:(NSInteger)row andPosition:(NSInteger)position andStrength:(NSInteger)strength
{
    self = [super init];
    if (self)
    {
        _blockRow = row;
        _blockPosition = position;
        _blockStrength = strength;
    }
    return self;

}

@end
