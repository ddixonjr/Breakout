//
//  Block.h
//  Breakout
//
//  Created by Dennis Dixon on 5/23/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Block : NSObject

@property (assign, nonatomic) NSInteger hitsToDestroy;
@property (assign, readonly, nonatomic) NSInteger pointValue;
@property (assign, readonly, nonatomic) BOOL hasBeenDestroyed;

-(void)logHit;

@end
