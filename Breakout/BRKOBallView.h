//
//  BRKOBallView.h
//  Breakout
//
//  Created by Dennis Dixon on 5/23/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  A UIView subclass that represents a ball in the presentation of the game board.  It's major purpose is to ensure the tag property is assigned to the kGamePieceTagBall value so that it can be distiguished by the UIKit Dynamics logic that detects collisions.
 */
@interface BRKOBallView : UIView

@end
