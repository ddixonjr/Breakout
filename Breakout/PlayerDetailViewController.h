//
//  PlayerDetailViewController.h
//  Breakout
//
//  Created by Dennis Dixon on 5/25/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayersManager.h"
#import "Player.h"

@interface PlayerDetailViewController : UIViewController

@property (strong, nonatomic) Player *player;
@property (strong, nonatomic) PlayersManager *playersManager;
@property (assign, nonatomic) BOOL newPlayerAdded;

@end
