//
//  Block.m
//  Breakout
//
//  Created by Dennis Dixon on 5/23/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import "Block.h"

@interface Block ()

@property (assign, nonatomic) NSInteger hitCount;
@property (assign, nonatomic) BOOL hasBeenDestroyed;

@end

@implementation Block

-(NSInteger)pointValue
{
    return (self.hitsToDestroy * self.hitsToDestroy);
}

-(void)logHit
{
    self.hitCount++;

    // >= just in case something in the game logic doesn't remove the block
    // when the isDestroy flag is originally set, keep setting isDestroyed to YES.  :)
    self.hasBeenDestroyed = (self.hitCount >= self.hitsToDestroy) ? YES : NO;
    NSLog(@"\nin Block - logHit...hitCount %d, hitsToDestroy %d, isDestroyed %d",self.hitCount,self.hitsToDestroy,self.hasBeenDestroyed);

}

-(NSString *)description
{
    return [NSString stringWithFormat:@"This block has hitCount: %d, pointValue: %d, and hasBeenDestroyed = %d", self.hitCount,self.pointValue,self.hasBeenDestroyed];
}

@end
