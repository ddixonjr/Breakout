//
//  Block.m
//  Breakout
//
//  Created by Dennis Dixon on 5/23/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import "Block.h"

@implementation Block

-(NSInteger)pointValue
{
    return (self.hitsToDisentegrate * self.hitsToDisentegrate) * 5;
}

@end
