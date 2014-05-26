//
//  BreakoutGameViewController.h
//  Breakout
//
//  Created by Dennis Dixon on 5/23/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BreakoutGame.h"
#import "BlockDescriptor.h"
#import "PlayersManager.h"

@interface BreakoutGameViewController : UIViewController

@property (strong, nonatomic) PlayersManager *playersManager;

@end
