//
//  BreakoutGame.h
//  Breakout
//
//  Created by Dennis Dixon on 5/23/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlockDescriptor.h"
#import "PlayersManager.h"

@class BreakoutGame;

@protocol BreakoutGameDelegate <NSObject> // Without explicit conformance to <NSObject> respondsToSelector: on the delegate will not compile

- (void)breakoutGame:(BreakoutGame *)breakoutGame blockGridHasNumberOfRows:(NSInteger)rows;
- (void)breakoutGame:(BreakoutGame *)breakoutGame blockGridRow:(NSInteger)row hasBlocksWithBlockDescriptors:(NSArray *)blockRowDescriptorArray;
- (void)breakoutGame:(BreakoutGame *)breakoutGame playerName:(NSString *)player hasTurnsLeft:(NSInteger)turnsLeft withClearBoardStatus:(BOOL)isBoardCleared andCurrentScore:(NSInteger)score;
- (void)breakoutGame:(BreakoutGame *)breakoutGame startNewPlayerNamed:(NSString *)player withTurnsLeft:(NSInteger)turnsLeft fromPreviousPlayer:(NSString *)previousPlayer;
-(void)breakoutGame:(BreakoutGame *)breakoutGame gameOverWithWinner:(NSString *)player andScore:(NSInteger)winningScore;


@end


@interface BreakoutGame : NSObject

@property (strong, nonatomic) id<BreakoutGameDelegate> delegate;
@property (strong, nonatomic) PlayersManager *playersManager;

- (void)startGame:(BOOL)isNewGame;
- (void)stopGame;
- (void)restartGame:(BOOL)isNewGame;
- (void)turnEnded:(NSInteger)updatedScore;
- (BOOL)destroyHitBlockWithBlockDescriptor:(BlockDescriptor *)BlockDescriptor;
- (NSInteger)turnsLeftForCurrentPlayer;

@end
