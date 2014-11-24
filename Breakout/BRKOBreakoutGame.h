//
//  BRKOBreakoutGame.h
//  Breakout
//
//  Created by Dennis Dixon on 5/23/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRKOBlockDescriptor.h"
#import "BRKOPlayersManager.h"

@class BRKOBreakoutGame;

/**
 *  Conformance to this protocol facilitates feedback from a BRKOBreakoutGame game model object to a view controller providing presentation logic of the game to the user.
 */
@protocol BRKOBreakoutGameDelegate <NSObject> // Without explicit conformance to <NSObject> respondsToSelector: on the delegate will not compile

/**
 *  Provides the number of rows of blocks modeled by the BRKOBreakoutGame game model instance.
 *
 *  @param breakoutGame The BRKOBreakoutGame instance that invoked the delegate method call.
 *  @param rows         The number of rows being modeled.
 */
- (void)breakoutGame:(BRKOBreakoutGame *)breakoutGame blockGridHasNumberOfRows:(NSInteger)rows;


/**
 *  Provides an array of BRKOBlockDescriptor objects belonging to the specified row.
 *
 *  @param breakoutGame            The BRKOBreakoutGame instance that invoked the delegate method call.
 *  @param row                     The row number this group of BRKOBlockDescriptor objects belongs to.
 *  @param blockRowDescriptorArray An array of BRKOBlockDescriptor objects belonging to the specified row.
 */
- (void)breakoutGame:(BRKOBreakoutGame *)breakoutGame blockGridRow:(NSInteger)row hasBlocksWithBlockDescriptors:(NSArray *)blockRowDescriptorArray;


/**
 *  This delegate method call is made in response to every invokation of destroyHitBlockWithBlockDescriptor: by the presenting view controller to provide a real-time status update on the current player's turns remaining, score, and whether or not the board has been cleared.
 *
 *  @param breakoutGame   The BRKOBreakoutGame instance that invoked the delegate method call.
 *  @param player         The name of the player this update is associated with this information.
 *  @param turnsLeft      The number of turns left for the specified player.
 *  @param isBoardCleared An indicator of whether or not the board has been cleared.
 *  @param score          The current score for the specified player.
 */
- (void)breakoutGame:(BRKOBreakoutGame *)breakoutGame playerName:(NSString *)player hasTurnsLeft:(NSInteger)turnsLeft withClearBoardStatus:(BOOL)isBoardCleared andCurrentScore:(NSInteger)score;

/**
 *  This delegate method call is made in response to an invokation of turnEnded: by the presenting view controller when the current player has been determined to be out of turns.  This allows the BRKOBreakoutGame game object  to provide the view controller with information on the next player needed to start that players set of turns.
 *
 *  @param breakoutGame   The BRKOBreakoutGame instance that invoked the delegate method call.
 *  @param player         The name of the player that has become the current player.
 *  @param turnsLeft      The number of turns for the specified player.
 *  @param previousPlayer The name of the player that has become the previous player.
 */
- (void)breakoutGame:(BRKOBreakoutGame *)breakoutGame startNewPlayerNamed:(NSString *)player withTurnsLeft:(NSInteger)turnsLeft fromPreviousPlayer:(NSString *)previousPlayer;


/**
 *  This delegate method is called to inform the presenting view controller when the current game has ended (i.e. when all players have expired all of their turns).
 *
 *  @param breakoutGame The BRKOBreakoutGame instance that invoked the delegate method call.
 *  @param player       The name of the player that had the highest score.
 *  @param winningScore The score of the specified winning player.
 */
-(void)breakoutGame:(BRKOBreakoutGame *)breakoutGame gameOverWithWinner:(NSString *)player andScore:(NSInteger)winningScore;


@end

/**
 *  A facade class implementing an entire model of a game of Breakout.  Breakout is a game where a player is given a paddle at the bottom end of a screen, a set of blocks at the top end of a screen, and a moving ball that (when kept bouncing in the area of play) hits and destroys the blocks.  The object is to continue hitting and destroying blocks to increase score and continue clearing "boards" of blocks.  This class uses a BKROPlayersManager instance, and manages BKROBlockGrid, BRKOBlock, BKROBlockDescriptor, and BRKOPlayer objects to implement entire games of breakout between one or more playing users.
 */
@interface BRKOBreakoutGame : NSObject

/**
 *  An object conforming to the BRKOBreakoutGameDelegate protocol in order to be informed of changes to the game model.  This will typically be a view controller responsible for the view hierarchy presenting the game board to the user.
 */
@property (strong, nonatomic) id<BRKOBreakoutGameDelegate> delegate;


/**
 *  An instance of BRKOPlayersManager that provides an interface for managing the players in the current game.
 */
@property (weak, nonatomic) BRKOPlayersManager *playersManager;


/**
 *  A method that initializes a new game.  This consists of the following.  1. Instantiating a BRKOBlockGrid object.  2. Creating an array of BRKOBlockDescriptor objects representing the BRKOBlock objects for each row of blocks in the BRKOBlockGrid object.  (This facilitates a way to relay block data abstractly to decouple the presenting view controller from the details of the BRKOBlock class interface.  The goal being to minimize the classes to which the presenting view controller has to be coupled.)  3.  Calls the breakoutGame:blockGridRow:hasBlocksWithBlockDescriptors: delegate method to relay the block row information to the presenting view controller.  4. When completed, the initial breakoutGame:playerName:hasTurnsLeft:withClearBoardStatus:andCurrentScore: delegate method call is invoked to start the set of turns for the current player.
 *
 *  @param isNewGame An indication of whether this a completely new game or just the start of a set of turns for another player.
 */
- (void)startGame:(BOOL)isNewGame;

/**
 *  A method that stops the game by releasing references to objects representing the current game: the current instances of BRKOBlockGrid, BRKOPlayersManager, and a local property referencing the array of players within the BRKOPlayersManager object.
 */
- (void)stopGame;


/**
 *  A convenience method to release the current block grid and trigger either the start of a new game or of a new set of turns for the next player.
 *
 *  @param isNewGame The flag to trigger either the start of a new game or of a new set of turns for the next player.
 */
- (void)restartGame:(BOOL)isNewGame;


/**
 *  Allows the presenting view controller to indicate when a player has missed the ball and (as a result) lost their turn.  This triggers a corresponding call to either the breakoutGame:playerName:hasTurnsLeft:withClearBoardStatus:andCurrentScore:, breakoutGame:startNewPlayerNamed:withTurnsLeft:fromPreviousPlayer:, or breakoutGame:gameOverWithWinner:andScore: method based on whether the player still has remaining turns, those turns have expired, or the game is over, respectively.
 *
 */
- (void)turnEnded;

/**
 *  Allows the presenting view controller to indicate when a block has been hit by the ball in the view representing the game board to the user.  breakoutGame:playerName:hasTurnsLeft:withClearBoardStatus:andCurrentScore:, breakoutGame:startNewPlayerNamed:withTurnsLeft:fromPreviousPlayer:, or breakoutGame:gameOverWithWinner:andScore: method based on whether the player still has remaining turns, those turns have expired, or the game is over, respectively.
 *
 *  @param BlockDescriptor A BRKOBlockDescriptor object describing the exact block in the block grid that has been hit by the ball.
 *
 *  @return An indicator of whether or not the hit has destroyed the block instance (BRKOBlock) in the model of the block grid (BRKOBlockGrid).
 */
- (BOOL)destroyHitBlockWithBlockDescriptor:(BRKOBlockDescriptor *)BlockDescriptor;

/**
 *  Determines the number of turns left for the current player.
 *
 *  @return The number of turns left for the current player.
 */
- (NSInteger)turnsLeftForCurrentPlayer;

@end
