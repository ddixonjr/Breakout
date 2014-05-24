//
//  BlockIndexPath.h
//  Breakout
//
//  Created by Dennis Dixon on 5/23/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlockIndexPath : NSObject

@property (assign, nonatomic) NSInteger blockRow;
@property (assign, nonatomic) NSInteger blockPosition;

-(id)initWithRow:(NSInteger)row andPosition:(NSInteger)position;

@end
