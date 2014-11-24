//
//  BRKOBlock.h
//  Breakout
//
//  Created by Dennis Dixon on 5/23/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  A model class that represents a single block in a game of Breakout.
 */
@interface BRKOBlock : NSObject


/**
 *  The number of hits remaining for the block to be destroyed.
 */
@property (assign, nonatomic) NSInteger hitsToDestroy;


/**
 *  The number of points to be gained when the block has been destroyed.
 */
@property (assign, readonly, nonatomic) NSInteger pointValue;


/**
 *  A flag indicating whether or not a block instance has been destroyed.
 */
@property (assign, readonly, nonatomic) BOOL hasBeenDestroyed;


/**
 *  A method call that tells the block instance it has been hit.
 */
-(void)logHit;

@end
