//
//  BRKOBlockDescriptor.h
//  Breakout
//
//  Created by Dennis Dixon on 5/23/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  A class that generically encapsulates identification information about a specific block model object for associating view layer objects with corresponding model layer objects.
 */
@interface BRKOBlockDescriptor : NSObject

/**
 *  Property that identifies the corresponding block row within the game model.
 */
@property (assign, nonatomic) NSInteger blockRow;


/**
 *  Property that identifies the corresponding block's position within the row in the game model.
 */
@property (assign, nonatomic) NSInteger blockPosition;


/**
 *  Property that identifies the block strength indicator of the corresponding block within the game model.
 */
@property (assign, nonatomic) NSInteger blockStrength;


/**
 *  An initializer that facilitates assignment of all of the essential properties to ensure the corresponding block within the game model is identified by instances of this class.
 *
 *  @param row      identifier of the corresponding block row within the game model.
 *  @param position identifier of the corresponding block's position within the row in the game model.
 *  @param strength identifies the block strength indicator of the corresponding block within the game model.
 *
 *  @return Pointer to a newly instantiated BRKOBlockDescriptor instance with the assigned identifiers to bind it with the corresponding block within the breakout game model.
 */
-(id)initWithRow:(NSInteger)row andPosition:(NSInteger)position andStrength:(NSInteger)strength;

@end
