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

#define kBottomBoundaryIdString @"BottomBoundary"
#define kGamePiece

@interface BreakoutGameViewController () <UICollisionBehaviorDelegate>

@property (weak, nonatomic) IBOutlet PaddleView *paddleView;
@property (weak, nonatomic) IBOutlet BallView *ballView;
@property (weak, nonatomic) IBOutlet BlockView *blockView;
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

    if (collidedView1.tag == 3)
    {
        collidedView1.hidden = YES;
        [self.collisionBehavior removeItem:item1];
    }

    if (collidedView2.tag == 3)
    {
        collidedView2.hidden = YES;
        [self.collisionBehavior removeItem:item2];
    }
}


#pragma mark - Helper Methods

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

