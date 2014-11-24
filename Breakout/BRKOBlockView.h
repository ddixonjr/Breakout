//
//  BRKOBlockView.h
//  Breakout
//
//  Created by Dennis Dixon on 5/23/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRKOBlockDescriptor.h"

@interface BRKOBlockView : UIView

@property (strong, nonatomic) BRKOBlockDescriptor *blockDescriptor;

-(id)initWithBlockDescriptor:(BRKOBlockDescriptor *)blockDescriptor;

@end
