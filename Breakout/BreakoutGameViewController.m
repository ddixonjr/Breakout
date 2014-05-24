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
#import "BlockIndexPath.h"

#define kBottomBoundaryIdString @"BottomBoundary"
#define kGamePiece

@interface BreakoutGameViewController () <UICollisionBehaviorDelegate>

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *turnLabel;
@property (weak, nonatomic) IBOutlet PaddleView *paddleView;
@property (weak, nonatomic) IBOutlet BallView *ballView;
@property (weak, nonatomic) IBOutlet RowView *rowView0;
@property (weak, nonatomic) IBOutlet RowView *rowView1;
@property (weak, nonatomic) IBOutlet RowView *rowView2;
@property (weak, nonatomic) IBOutlet RowView *rowView3;
@property (weak, nonatomic) IBOutlet RowView *rowView4;

@property (strong,nonatomic) NSArray *rowViewArray;

@property (strong,nonatomic) UIDynamicAnimator *dynamicAnimator;
@property (strong,nonatomic) UIPushBehavior *pushBehavior;
@property (strong,nonatomic) UICollisionBehavior *collisionBehavior;
@property (strong,nonatomic) UIDynamicItemBehavior *paddleItemBehavior;
@property (strong,nonatomic) UIDynamicItemBehavior *ballItemBehavior;
@property (strong,nonatomic) UIDynamicItemBehavior *blockItemBehavior;

@property (strong, nonatomic) BlockView *blockView;  // Ditch this when I get the game model and programmatic blocks up and running

@end



@implementation BreakoutGameViewController


#pragma mark - View Controller Lifecycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initRowViewArray];
    [self initializeBreakoutAnimation];
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
    UIView *collidedView1 = (UIView *) item1;
    UIView *collidedView2 = (UIView *) item2;
    NSLog(@"Ball hit items %d and %d", collidedView1.tag, collidedView2.tag);
    BlockView *blockHit = nil;

    if (collidedView1.tag == kGamePieceTagBlock)
    {
        [self removeBlockFromPlay:collidedView1];
        blockHit = (BlockView *) collidedView1;
        NSLog(@"the block hit had a position of row %d : position %d", blockHit.blockIndexPath.blockRow, blockHit.blockIndexPath.blockPosition);
        [self updateScore];
    }

    if (collidedView2.tag == kGamePieceTagBlock)
    {
        [self removeBlockFromPlay:collidedView2];
        blockHit = (BlockView *) collidedView2;
        NSLog(@"the block hit had a position of row %d : position %d", blockHit.blockIndexPath.blockRow, blockHit.blockIndexPath.blockPosition);
        [self updateScore];
    }


}


#pragma mark - Helper Methods

-(void)updateScore
{
    self.scoreLabel.text = [NSString stringWithFormat:@"%d",([self.scoreLabel.text intValue]+100)];
}

- (void)removeBlockFromPlay:(UIView *)block
{
    block.hidden = YES;
    [self.collisionBehavior removeItem:block];

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
    //  I'm also using my custom class BlockIndexPath to convey block position...WORKS!!!
    BlockIndexPath *blockIndexPath = [[BlockIndexPath alloc] initWithRow:2 andPosition:5];
    self.blockView = [[BlockView alloc] initWithBlockIndexPath:blockIndexPath];
    self.blockView.frame = CGRectMake(self.rowView0.frame.origin.x+2,
                                      self.rowView0.frame.origin.y+2,
                                      100.0,10.0);
    self.blockView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.blockView];

    self.scoreLabel.text = @"0";

    self.ballView.center = self.view.center;
    self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];

    self.pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.paddleView,self.ballView,self.blockView] mode:UIPushBehaviorModeInstantaneous];
    self.pushBehavior.pushDirection = CGVectorMake(0.5,1.0);
    self.pushBehavior.magnitude = 0.02;
    self.pushBehavior.active = YES;
    [self.dynamicAnimator addBehavior:self.pushBehavior];

    self.collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.paddleView,self.ballView,self.blockView]];
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

    self.blockItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.blockView]];
    self.blockItemBehavior.density = 1000;
    self.blockItemBehavior.allowsRotation = NO;
    [self.dynamicAnimator addBehavior:self.blockItemBehavior];
}


@end

