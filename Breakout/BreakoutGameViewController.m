//
//  BreakoutGameViewController.m
//  Breakout
//
//  This version of Breakout implements an MVC-designed version of the Breakout game built using
//    lessons on Dynamics learned from Mobile Makers on 5/22/14.
//  This code will be stored on Github at https://github.com/ddixonjr/Breakout.git
//
//  Created by Dennis Dixon on 5/23/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import "BreakoutGameViewController.h"
#import "PaddleView.h"
#import "BallView.h"
#import "BlockView.h"
#import "RowView.h"
#import "BlockDescriptor.h"

#define kBottomBoundaryIdString @"BottomBoundary"
#define kGamePiece

@interface BreakoutGameViewController () <UICollisionBehaviorDelegate>

// View Related Properties
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *turnLabel;
@property (weak, nonatomic) IBOutlet PaddleView *paddleView;
@property (weak, nonatomic) IBOutlet BallView *ballView;
@property (weak, nonatomic) IBOutlet RowView *rowView0;
@property (weak, nonatomic) IBOutlet RowView *rowView1;
@property (weak, nonatomic) IBOutlet RowView *rowView2;
@property (weak, nonatomic) IBOutlet RowView *rowView3;
@property (weak, nonatomic) IBOutlet RowView *rowView4;
@property (strong, nonatomic) NSMutableArray *allBlockViewsArray;
@property (strong,nonatomic) NSArray *rowViewArray;

// Dynamics Related Properties
@property (strong,nonatomic) UIDynamicAnimator *dynamicAnimator;
@property (strong,nonatomic) UIPushBehavior *pushBehavior;
@property (strong,nonatomic) UICollisionBehavior *collisionBehavior;
@property (strong,nonatomic) UIDynamicItemBehavior *paddleItemBehavior;
@property (strong,nonatomic) UIDynamicItemBehavior *ballItemBehavior;
@property (strong,nonatomic) UIDynamicItemBehavior *blockItemBehavior;

// Breakout Game Object Properties
@property (strong, nonatomic) BreakoutGame *breakoutGame;

// Temp Properties
@property (strong, nonatomic) BlockView *blockView;  // Ditch this when I get the game model and programmatic blocks up and running

@end



@implementation BreakoutGameViewController


#pragma mark - View Controller Lifecycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.breakoutGame = [[BreakoutGame alloc] init];
    self.breakoutGame.delegate = self;
    self.allBlockViewsArray = [[NSMutableArray alloc] init];
    [self initRowViewArray];
    
    [self initializeBreakoutAnimation];
    [self.breakoutGame startGame];
}

#pragma mark - IBAction Methods

- (IBAction)onDragPaddle:(UIPanGestureRecognizer *)panGestureRecognizer
{
    self.paddleView.center = CGPointMake([panGestureRecognizer locationInView:self.view].x,self.paddleView.center.y); // Move the paddle only horizontally
    [self.dynamicAnimator updateItemUsingCurrentState:self.paddleView];
}



#pragma mark - UICollisionBehaviorDelegate Methods

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    NSString *boundaryIdString = (NSString *) identifier;
    //    NSLog(@"Ball hit boundary (%f,%f)",p.x,p.y);

    if ([boundaryIdString isEqualToString:kBottomBoundaryIdString])
    {
//        NSLog(@"Ball hit bottom");
        self.ballView.center = self.view.center;
        [self.dynamicAnimator updateItemUsingCurrentState:self.ballView];
    }
}

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 atPoint:(CGPoint)p
{
    BlockView *blockViewHit = nil;

    if ([item1 isKindOfClass:[BlockView class]])
        blockViewHit = (BlockView *) item1;
    else if ([item2 isKindOfClass:[BlockView class]])
        blockViewHit = (BlockView *) item2;

    if (blockViewHit !=nil && blockViewHit.tag == 3)
    {
        if ([self.breakoutGame destroyHitBlockAtBlockDescriptor:blockViewHit.blockDescriptor])
        {
            [self removeBlockViewFromPlayView:blockViewHit];
            NSLog(@"the block hit had a position of row %d : position %d and strength of %d", blockViewHit.blockDescriptor.blockRow, blockViewHit.blockDescriptor.blockPosition, blockViewHit.blockDescriptor.blockStrength);
            [self updateScore];
        }
    }
}


#pragma mark - BreakoutGameDelegate Methods

-(void)breakoutGame:(BreakoutGame *)breakoutGame blockGridHasNumberOfRows:(NSInteger)rows
{
    NSLog(@"in breakoutGame:blockGridHasNumberOfRows");
    // I'll use this later to vary the number of block rows based on the game object!
}


-(void)breakoutGame:(BreakoutGame *)breakoutGame blockGridRow:(NSInteger)row hasBlocksWithBlockDescriptors:(NSArray *)blockRowDescriptorArray
{
    NSLog(@"in breakoutGame:blockGridRow:hasBlockWithDescriptors - curBlkDescriptorArray has %d elements", blockRowDescriptorArray.count);
    UIView *curRowView = [self.rowViewArray objectAtIndex:row];
    CGFloat curRowViewWidth = curRowView.frame.size.width;
    CGFloat totalBlockStrengthInRow = 0;
    CGFloat widthPerStrengthUnitFactor = 0;
    CGFloat curRowXPosition = 0;

    for (BlockDescriptor *curBlockDescriptor in blockRowDescriptorArray)
        totalBlockStrengthInRow += curBlockDescriptor.blockStrength;

    widthPerStrengthUnitFactor = curRowViewWidth / totalBlockStrengthInRow;
    NSLog(@"widthPerStrengthUnitFactor = %f curRowViewWidth = %f  totalBlockStrengthInRow = %f", widthPerStrengthUnitFactor, curRowViewWidth, totalBlockStrengthInRow);

    for (BlockDescriptor *curBlockDescriptor in blockRowDescriptorArray)
    {
        BlockView *curNewBlock = [[BlockView alloc] initWithBlockDescriptor:curBlockDescriptor];
        CGFloat curBlockWidth = curNewBlock.blockDescriptor.blockStrength * widthPerStrengthUnitFactor;
        NSLog(@"curBlockStrength = %d  curBlockWidth is %f",curNewBlock.blockDescriptor.blockStrength, curBlockWidth);
        curNewBlock.frame = CGRectMake((curRowView.frame.origin.x + curRowXPosition),
                                       (curRowView.frame.origin.y + 2.0),
                                       curBlockWidth, 10.0);
        int randomNumber = arc4random_uniform(12) + 1;
        CGFloat randomRed = 1.0/((CGFloat)randomNumber);
        randomNumber = arc4random_uniform(12) + 1;
        CGFloat randomGreen = 1.0/((CGFloat)randomNumber);
        randomNumber = arc4random_uniform(12) + 1;
        CGFloat randomBlue = 1.0/((CGFloat)randomNumber);
        NSLog(@"randomNumber = %d random red = %f green = %f blue = %f",randomNumber, randomRed, randomGreen,randomBlue);
        curNewBlock.backgroundColor = [UIColor colorWithRed:randomRed green:randomGreen blue:randomBlue alpha:1.0];

        // load the current blockView object into the allBlocks array, superview, and UICollisionBehavior object
        [self.allBlockViewsArray addObject:curNewBlock];
        [self.view addSubview:curNewBlock];
        [self.collisionBehavior addItem:curNewBlock];
        curRowXPosition += curNewBlock.frame.size.width;
    }

    if (row == (self.rowViewArray.count - 1))   // if the current row being processed is the last
    {                                           // then update the UICollisionBehavior and DynamicAnimator objects
        self.blockItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:self.allBlockViewsArray];
        self.blockItemBehavior.density = 1000;
        self.blockItemBehavior.allowsRotation = NO;
        [self.dynamicAnimator addBehavior:self.blockItemBehavior];

    }
}


-(void)breakoutGame:(BreakoutGame *)breakoutGame playerName:(NSString *)player hasTurnsLeft:(NSInteger)turnsLeft withClearBoardStatus:(BOOL)isBoardCleared andCurrentScore:(NSInteger)score
{
    NSLog(@"in breakoutGame:playerName:hasTurnsLeft:withClearBoardStatus:andCurrentScore");
}



#pragma mark - Helper Methods

-(void)updateScore
{
    self.scoreLabel.text = [NSString stringWithFormat:@"%d",([self.scoreLabel.text intValue]+100)];
}

- (void)removeBlockViewFromPlayView:(UIView *)blockView
{
    [self.collisionBehavior removeItem:blockView];
    [blockView removeFromSuperview];  // since I never established a property for the object referenced by blockView, the superview has the only strong reference, so this alone should reduce retain count to zero
}

- (void)initRowViewArray
{
    self.rowViewArray = @[self.rowView0,
                          self.rowView1,
                          self.rowView2,
                          self.rowView3,
                          self.rowView4];

    for (RowView *curRowView in self.rowViewArray)
    {
        curRowView.backgroundColor = [UIColor clearColor];
    }
}

-(void)initializeBreakoutAnimation
{
    // Test try at programmatic placement of a block in the content view of this view controller using the rowViewX UIViews as a reference point...WORKS!!!
    //  I'm also using my custom class BlockDescriptor to convey block position...WORKS!!!
//    BlockDescriptor *blockDescriptor = [[BlockDescriptor alloc] initWithRow:2 andPosition:5 andStrength:1];
//    self.blockView = [[BlockView alloc] initWithBlockDescriptor:blockDescriptor];
//    self.blockView.frame = CGRectMake(self.rowView0.frame.origin.x+2,
//                                      self.rowView0.frame.origin.y+2,
//                                      200.0,10.0);
//    self.blockView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.blockView];
    // End of test code

    self.scoreLabel.text = @"0";

    self.ballView.center = self.view.center;
    self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];

    self.pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.ballView] mode:UIPushBehaviorModeInstantaneous];
    self.pushBehavior.pushDirection = CGVectorMake(0.5,1.0);
    self.pushBehavior.magnitude = 0.02;
    self.pushBehavior.active = YES;
    [self.dynamicAnimator addBehavior:self.pushBehavior];

    self.collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.paddleView,self.ballView]];
    self.collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    self.collisionBehavior.collisionDelegate = self;
    [self.collisionBehavior addBoundaryWithIdentifier:kBottomBoundaryIdString fromPoint:CGPointMake(0.0,480.0) toPoint:CGPointMake(320.0,480.0)];
    [self.dynamicAnimator addBehavior:self.collisionBehavior];

    self.paddleItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.paddleView]];
    self.paddleItemBehavior.density = 1000;
    self.paddleItemBehavior.allowsRotation = NO;
    [self.dynamicAnimator addBehavior:self.paddleItemBehavior];

    self.ballItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.ballView]];
    self.ballItemBehavior.friction = 0.0;
    self.ballItemBehavior.resistance = 0.0;
    self.ballItemBehavior.elasticity = 1.0;
    self.ballItemBehavior.allowsRotation = NO;
    [self.dynamicAnimator addBehavior:self.ballItemBehavior];
}


@end

