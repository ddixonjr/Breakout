//
//  BRKOPlayer.h
//  Breakout
//
//  Created by Dennis Dixon on 5/23/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  A model class that encapsulates information regarding a single game player.
 */
@interface BRKOPlayer : NSObject

/**
 *  The name of the player.
 */
@property (strong, nonatomic) NSString *name;


/**
 *  The number of turns the player has remaining.
 */
@property (assign, nonatomic) NSInteger turnsLeft;


/**
 *  The current score the player has earned.
 */
@property (assign, nonatomic) NSInteger score;


/**
 *  The highest round the player has achieved during the current game.
 */
@property (assign, nonatomic) NSInteger round;


/**
 *  A convenience flag that indicates whether or not the players turns have expired.
 */
@property (assign, readonly, nonatomic) BOOL turnsGone;


/**
 *  An initializer that allows the essential player properties to be set
 *
 *  @param name         The name of the player.
 *  @param turnsAtStart The initial number of turns.
 *
 *  @return A reference to a newly instantiated BRKOPlayer object.
 */
- (id)initWithName:(NSString *)name andTurnsAtStart:(NSInteger)turnsAtStart;


/**
 *  A method that allows a player object to be informed of a loss of turn.
 */
- (void)turnLost;


/**
 *  Allows a player object to be reset to a zero score and a default number of turns.
 */
- (void)resetForStartOfPlay;

@end
