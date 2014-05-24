//
//  BreakoutGame.h
//  Breakout
//
//  Created by Dennis Dixon on 5/23/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlockIndexPath.h"

@class BreakoutGame;

@protocol BreakoutGameDelegate

-(void)breakoutGame:(BreakoutGame *)breakoutGame blockGridHasNumberOfRows:(NSInteger)rows;
-(void)breakoutGame:(BreakoutGame *)breakoutGame blockGridRow:(NSInteger)row hasNumberOfBlocks:(NSInteger)blocks;
-(void)breakoutGame:(BreakoutGame *)breakoutGame player:(NSString *)player hasNumberOfTurnsLeft:(NSInteger)turnsLeft;

@end


@interface BreakoutGame : NSObject

-(void)startGame;
-(void)turnEnded;
-(NSInteger)destroyHitBlockAtBlockIndexPath:(BlockIndexPath *)blockIndexPath;

@end
