//
//  BRKOBreakoutGameViewController.h
//  Breakout
//
//  Created by Dennis Dixon on 5/23/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRKOBreakoutGame.h"
#import "BRKOBlockDescriptor.h"
#import "BRKOPlayersManager.h"


/**
 *  A view controller that controls the view hierarchy displaying the game to the user.
 */
@interface BRKOBreakoutGameViewController : UIViewController


/**
 *  A populated instance of BRKOPlayersManager for a new game of breakout to be based on.
 */
@property (strong, nonatomic) BRKOPlayersManager *playersManager;

@end
