//
//  Player.h
//  Breakout
//
//  Created by Dennis Dixon on 5/23/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger turnsLeft;
@property (assign, nonatomic) NSInteger score;

@end
