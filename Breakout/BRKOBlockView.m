//
//  BRKOBlockView.m
//  Breakout
//
//  Created by Dennis Dixon on 5/23/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import "BRKOBlockView.h"

@implementation BRKOBlockView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.tag = kGamePieceTagBlock;
    }
//    NSLog(@"in initWithCoder for a BlockView");
    return self;
}


-(id)init
{
    return [self initWithBlockDescriptor:nil];
}

-(id)initWithBlockDescriptor:(BRKOBlockDescriptor *)blockDescriptor
{
    self = [super init];
    if (self)
    {
        self.tag = kGamePieceTagBlock;
        self.blockDescriptor = blockDescriptor;
    }
//    NSLog(@"in initWithBlockDescriptor for a BlockView");
    return self;
}

@end
