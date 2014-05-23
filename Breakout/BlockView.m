//
//  BlockView.m
//  Breakout
//
//  Created by Dennis Dixon on 5/23/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import "BlockView.h"

@implementation BlockView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.tag = kGamePieceTagBlock;
    }
    NSLog(@"in initWithCoder for a BlockView");
    return self;
}


-(id)init
{
    self = [super init];
    if (self)
    {
        self.tag = kGamePieceTagBlock;
    }
    NSLog(@"in init for a BlockView");
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
