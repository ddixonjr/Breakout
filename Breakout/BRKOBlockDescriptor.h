//
//  BRKOBlockDescriptor.h
//  Breakout
//
//  Created by Dennis Dixon on 5/23/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BRKOBlockDescriptor : NSObject

@property (assign, nonatomic) NSInteger blockRow;
@property (assign, nonatomic) NSInteger blockPosition;
@property (assign, nonatomic) NSInteger blockStrength;

-(id)initWithRow:(NSInteger)row andPosition:(NSInteger)position andStrength:(NSInteger)strength;

@end
