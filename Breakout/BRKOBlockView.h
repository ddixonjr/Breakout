//
//  BRKOBlockView.h
//  Breakout
//
//  Created by Dennis Dixon on 5/23/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRKOBlockDescriptor.h"


/**
 *  A UIView subclass that represents a ball in the presentation of the game board.  It's major purpose is to store a reference to the BRKOBlockDescriptor object that uniquely identifies and binds it to its corresponding block model object.  It also ensures the tag property is assigned to the kGamePieceTagBlock value so that it can be distiguished by the UIKit Dynamics logic that detects collisions.
 */
@interface BRKOBlockView : UIView

@property (strong, nonatomic) BRKOBlockDescriptor *blockDescriptor;

-(id)initWithBlockDescriptor:(BRKOBlockDescriptor *)blockDescriptor;

@end
