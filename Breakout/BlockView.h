//
//  BlockView.h
//  Breakout
//
//  Created by Dennis Dixon on 5/23/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlockDescriptor.h"

@interface BlockView : UIView

@property (strong, nonatomic) BlockDescriptor *blockDescriptor;

-(id)initWithBlockDescriptor:(BlockDescriptor *)blockDescriptor;

@end
