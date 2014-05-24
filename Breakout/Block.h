//
//  Block.h
//  Breakout
//
//  Created by Dennis Dixon on 5/23/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Block : NSObject

@property (assign, nonatomic) NSInteger hitsToDisentegrate;
@property (assign, readonly, nonatomic) NSInteger pointValue;

@end
