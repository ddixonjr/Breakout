//
//  BRKOBreakoutGameViewController.m
//  Breakout
//
//  This version of Breakout implements an MVC-designed version of the Breakout game built using
//    lessons on Dynamics learned from Mobile Makers on 5/22/14.
//  This code will be stored on Github at https://github.com/ddixonjr/Breakout.git
//
//  Created by Dennis Dixon on 5/23/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import "BRKOBreakoutGameViewController.h"
#import "BRKOPaddleView.h"
#import "BRKOBallView.h"
#import "BRKOBlockView.h"
#import "BRKORowView.h"
#import "BRKOBlockDescriptor.h"

#define kDebugOn NO
#define kBottomBoundaryIdString @"BottomBoundary"
#define kGamePiecePaddleStartCenterPosition 267.0
#define kGamePieceBlockHeight 14.0
#define kGamePieceBlockRowSpacing 2.0
#define kGamePieceBlockInterblockSpacing 2.0


@interface BRKOBreakoutGameViewController () <BRKOBreakoutGameDelegate,UICollisionBehaviorDelegate,UIAlertViewDelegate>

// View Related Properties
@property (weak, nonatomic) IBOutlet UILabel *playerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *turnLabel;
@property (weak, nonatomic) IBOutlet BRKOPaddleView *paddleView;
@property (weak, nonatomic) IBOutlet BRKOBallView *ballView;
@property (weak, nonatomic) IBOutlet UIView *rowView0;
@property (weak, nonatomic) IBOutlet UIView *rowView1;
@property (weak, nonatomic) IBOutlet UIView *rowView2;
@property (weak, nonatomic) IBOutlet UIView *rowView3;
@property (weak, nonatomic) IBOutlet UIView *rowView4;
@property (strong,nonatomic) NSArray *rowViewArray;
@property (strong, nonatomic) NSMutableArray *allBlockViewsArray;
@property (strong, nonatomic) NSMutableArray *destroyedBlockViewsArray;

// Dynamics Related Properties
@property (strong,nonatomic) UIDynamicAnimator *dynamicAnimator;
@property (strong,nonatomic) UIPushBehavior *pushBehavior;
@property (strong,nonatomic) UICollisionBehavior *collisionBehavior;
@property (strong,nonatomic) UIDynamicItemBehavior *paddleItemBehavior;
@property (strong,nonatomic) UIDynamicItemBehavior *ballItemBehavior;
@property (strong,nonatomic) UIDynamicItemBehavior *blockItemBehavior;

// Breakout Game Object Properties
@property (strong, nonatomic) BRKOBreakoutGame *breakoutGame;

@end



@implementation BRKOBreakoutGameViewController


#pragma mark - View Controller Lifecycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.breakoutGame = [[BRKOBreakoutGame alloc] init];
    self.breakoutGame.delegate = self;
    self.breakoutGame.playersManager = self.playersManager;
    self.allBlockViewsArray = [[NSMutableArray alloc] init];
    self.destroyedBlockViewsArray = [[NSMutableArray alloc] init];

    [self initRowViewArray];
    [self initializeBreakoutAnimation];
    [self.breakoutGame startGame:kIsNewGame];
}

#pragma mark - IBAction Methods

- (IBAction)onDragPaddle:(UIPanGestureRecognizer *)panGestureRecognizer
{
    self.paddleView.center = CGPointMake([panGestureRecognizer locationInView:self.view].x,self.paddleView.center.y); // Move the paddle only horizontally
    [self.dynamicAnimator updateItemUsingCurrentState:self.paddleView];
}

- (IBAction)onExitGameActionPerformed:(id)sender
{
    [self removeBehaviorsFromDynamicAnimator];
    [self displayAlertViewWithTitle:kGameStringExitPrompt andMessage:@"Are you sure you want to end the game?" withNoButton:YES];
}


#pragma mark - UICollisionBehaviorDelegate Methods

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    NSString *boundaryIdString = (NSString *) identifier;

    if ([boundaryIdString isEqualToString:kBottomBoundaryIdString] && [item isEqual:self.ballView])
    {
//      NSLog(@"Ball hit bottom");
        [self.breakoutGame turnEnded];
        [self removeBehaviorsFromDynamicAnimator];
        [self resetPaddleToStartPosition];

        if ([self.breakoutGame turnsLeftForCurrentPlayer] > 0)
        {
            [self displayAlertViewWithTitle:kGameStringTurnOver andMessage:@"Start next turn!" withNoButton:NO];
        }
    }
}


- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 atPoint:(CGPoint)p
{
    BRKOBlockView *blockViewHit = nil;

    if ([item1 isKindOfClass:[BRKOBlockView class]])
        blockViewHit = (BRKOBlockView *) item1;
    else if ([item2 isKindOfClass:[BRKOBlockView class]])
        blockViewHit = (BRKOBlockView *) item2;

    if (blockViewHit !=nil)
    {
        if ([self.breakoutGame destroyHitBlockWithBlockDescriptor:blockViewHit.blockDescriptor])
        {
            [self animateBlockBeforeRemoval:blockViewHit];
            [self.destroyedBlockViewsArray addObject:blockViewHit];
        }
    }
}


#pragma mark - BreakoutGameDelegate Methods

- (void)breakoutGame:(BRKOBreakoutGame *)breakoutGame blockGridHasNumberOfRows:(NSInteger)rows
{
//    NSLog(@"in breakoutGame:blockGridHasNumberOfRows");
//    I'll use this later to vary the number of block rows based on the game object!
}


- (void)breakoutGame:(BRKOBreakoutGame *)breakoutGame blockGridRow:(NSInteger)row hasBlocksWithBlockDescriptors:(NSArray *)blockRowDescriptorArray
{
//    NSLog(@"in breakoutGame:blockGridRow:hasBlockWithDescriptors - curBlkDescriptorArray has %ld elements", (long)blockRowDescriptorArray.count);
    UIView *curRowView = [self.rowViewArray objectAtIndex:row];
    CGFloat curRowViewWidth = curRowView.frame.size.width;
    CGFloat adjustedRowViewWidthForBlockSpacing = curRowViewWidth - ((CGFloat)((kGamePieceBlockInterblockSpacing * blockRowDescriptorArray.count) + kGamePieceBlockInterblockSpacing));
    CGFloat totalBlockStrengthInRow = 0;
    CGFloat widthPerStrengthUnitFactor = 0;
    CGFloat curRowXPosition = kGamePieceBlockInterblockSpacing;

    for (BRKOBlockDescriptor *curBlockDescriptor in blockRowDescriptorArray)
        totalBlockStrengthInRow += curBlockDescriptor.blockStrength;

    widthPerStrengthUnitFactor = adjustedRowViewWidthForBlockSpacing / totalBlockStrengthInRow;
//    NSLog(@"widthPerStrengthUnitFactor = %f curRowViewWidth = %f adjustedRowWidth %f totalBlockStrengthInRow = %f", widthPerStrengthUnitFactor, curRowViewWidth, adjustedRowViewWidthForBlockSpacing, totalBlockStrengthInRow);

    // For each block descriptor in the current row of blocks passed in from the BreakoutGame object,
    //   create a row of BlockViews (each having a width proportional to its 'strength') and pass in the BlockView
    //   for later identification to the block grid in the BreakoutGame object
    for (BRKOBlockDescriptor *curBlockDescriptor in blockRowDescriptorArray)
    {
        BRKOBlockView *curNewBlock = [[BRKOBlockView alloc] initWithBlockDescriptor:curBlockDescriptor];
        CGFloat curBlockWidth = curNewBlock.blockDescriptor.blockStrength * widthPerStrengthUnitFactor;
//        NSLog(@"curBlockStrength = %d  curBlockWidth is %f  curRowXPosition %f",curNewBlock.blockDescriptor.blockStrength, curBlockWidth, curRowXPosition);
        curNewBlock.frame = CGRectMake((curRowView.frame.origin.x + curRowXPosition),
                                       (curRowView.frame.origin.y + kGamePieceBlockRowSpacing),
                                       curBlockWidth, kGamePieceBlockHeight);

        int randomNumber = arc4random_uniform(12) + 1;
        CGFloat randomRed = 1.0/((CGFloat)randomNumber);
        randomNumber = arc4random_uniform(7) + 1;
        CGFloat randomGreen = 1.0/((CGFloat)randomNumber);
        randomNumber = arc4random_uniform(9) + 1;
        CGFloat randomBlue = 1.0/((CGFloat)randomNumber);
        curNewBlock.backgroundColor = [UIColor colorWithRed:randomRed green:randomGreen blue:randomBlue alpha:1.0];

        // load the current blockView object into the allBlocks array, superview, and UICollisionBehavior object
        [self.allBlockViewsArray addObject:curNewBlock];
        [self.view addSubview:curNewBlock];
        [self.collisionBehavior addItem:curNewBlock];
        [self.dynamicAnimator updateItemUsingCurrentState:curNewBlock];
        curRowXPosition = curRowXPosition + curNewBlock.frame.size.width + kGamePieceBlockInterblockSpacing;
    }

    // If the current row being processed was the last then create the
    //   DynamicItemBehavior object for the blockViews and update the DynamicAnimator objects
    if (row == (self.rowViewArray.count - 1))
    {
        self.blockItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:self.allBlockViewsArray];
        self.blockItemBehavior.density = 1000;
        self.blockItemBehavior.allowsRotation = NO;
        [self.dynamicAnimator addBehavior:self.blockItemBehavior];
    }
}


- (void)breakoutGame:(BRKOBreakoutGame *)breakoutGame playerName:(NSString *)player hasTurnsLeft:(NSInteger)turnsLeft withClearBoardStatus:(BOOL)isBoardCleared andCurrentScore:(NSInteger)score
{
//    NSLog(@"in breakoutGame:playerName:hasTurnsLeft:withClearBoardStatus:andCurrentScore turnsLeft = %d",turnsLeft);
    self.turnLabel.text = [NSString stringWithFormat:@"%ld",(long)turnsLeft];
    self.playerNameLabel.text = player;
    self.scoreLabel.text = [NSString stringWithFormat:@"%ld",(long)score];

    if (isBoardCleared)
    {
        [self removeBehaviorsFromDynamicAnimator];
        [self displayAlertViewWithTitle:kGameStringClearedBoard andMessage:@"Great Job!\nKeep Going!" withNoButton:NO];

    }
}


-(void)breakoutGame:(BRKOBreakoutGame *)breakoutGame startNewPlayerNamed:(NSString *)player withTurnsLeft:(NSInteger)turnsLeft fromPreviousPlayer:(NSString *)previousPlayer 
{
    self.turnLabel.text = [NSString stringWithFormat:@"%ld",(long)turnsLeft];
    self.playerNameLabel.text = player;
    self.scoreLabel.text = @"0";

    [self removeAllBlockViewsFromView];
    [self.breakoutGame restartGame:kIsNotNewGame];
    [self addBehaviorsToDynamicAnimator];
}


-(void)breakoutGame:(BRKOBreakoutGame *)breakoutGame gameOverWithWinner:(NSString *)player andScore:(NSInteger)winningScore;
{
    [self removeBehaviorsFromDynamicAnimator];
    NSString *winnerString = [NSString stringWithFormat:@"%@ won with %ld points!\nPlay Again?",player,(long)winningScore];
    [self displayAlertViewWithTitle:kGameStringGameOver andMessage:winnerString withNoButton:YES];
}

#pragma mark - UIView Animation Delegate Methods

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
//    NSLog(@"in animationDidStop:finished:context:");
    for (UIView *curBlockView in self.destroyedBlockViewsArray)
    {
        [curBlockView removeFromSuperview];
        [self.collisionBehavior removeItem:curBlockView];
        [self.dynamicAnimator updateItemUsingCurrentState:curBlockView];
    }
    [self.destroyedBlockViewsArray removeAllObjects];
}


#pragma mark - UIAlertViewDelegate Method

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0: // Yes to alertView prompt
            [self resetPaddleToStartPosition];

            if ([alertView.title isEqualToString:kGameStringClearedBoard])
            {
                [self removeAllBlockViewsFromView];
                [self.breakoutGame restartGame:kIsNotNewGame];
                [self addBehaviorsToDynamicAnimator];
            }
            else if ([alertView.title isEqualToString:kGameStringGameOver])
            {
                [self removeAllBlockViewsFromView];
                [self.breakoutGame restartGame:kIsNewGame];
                [self addBehaviorsToDynamicAnimator];
            }
            else if ([alertView.title isEqualToString:kGameStringTurnOver])
            {
                [self addBehaviorsToDynamicAnimator];
            }
            else if ([alertView.title isEqualToString:kGameStringExitPrompt])
            {
                [self removeBehaviorsFromDynamicAnimator];
                [self.breakoutGame stopGame];
                [self performSegueWithIdentifier:@"GameUnwindSegue" sender:nil];
            }

            break;

        case 1:  // No to alertView prompt
            if ([alertView.title isEqualToString:kGameStringGameOver] ||
                [alertView.title isEqualToString:kGameStringClearedBoard] ||
                [alertView.title isEqualToString:kGameStringTurnOver])
            {
                [self removeBehaviorsFromDynamicAnimator];
                [self.breakoutGame stopGame];
                [self performSegueWithIdentifier:@"GameUnwindSegue" sender:nil];
            }
            else if ([alertView.title isEqualToString:kGameStringExitPrompt])
            {
                [self addBehaviorsToDynamicAnimator];
            }
            break;

        default:
            break;
    } // End of switch
}


#pragma mark - Helper Methods

- (void)removeAllBlockViewsFromView
{
    for (UIView *curSubview in self.view.subviews)
    {
        if ([curSubview isKindOfClass:[BRKOBlockView class]])
        {
            [self.collisionBehavior removeItem:curSubview];
            [curSubview removeFromSuperview];
        }
    }
}

- (void)updateScore
{
    self.scoreLabel.text = [NSString stringWithFormat:@"%d",([self.scoreLabel.text intValue]+100)];
}

- (void)resetPaddleToStartPosition
{
    self.paddleView.center = CGPointMake(kGamePiecePaddleStartCenterPosition,self.paddleView.center.y);
    [self.dynamicAnimator updateItemUsingCurrentState:self.paddleView];
}


- (void)animateBlockBeforeRemoval:(UIView *)blockView;
{
//    NSLog(@"in animateBlockBeforeRemoval - backgroundColor on entry %@",blockView.backgroundColor);
    [UIView beginAnimations:@"BlockView Removal Animations" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    blockView.backgroundColor = [UIColor whiteColor];  // Gives the spot a white background on the 'curl up'...nice!
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:blockView cache:NO];
    [UIView commitAnimations];
}


- (void)removeBlockViewFromPlayView:(UIView *)blockView
{
    [blockView removeFromSuperview];
    [self.collisionBehavior removeItem:blockView];
}

- (void)initRowViewArray
{
    self.rowViewArray = @[self.rowView0,
                          self.rowView1,
                          self.rowView2,
                          self.rowView3,
                          self.rowView4];

    for (BRKORowView *curRowView in self.rowViewArray)
    {
        curRowView.backgroundColor = [UIColor clearColor];
    }
}


- (void)displayAlertViewWithTitle:(NSString *)title andMessage:(NSString *)message withNoButton:(BOOL)shouldHaveNoButton
{
    if (shouldHaveNoButton)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"Yes"
                                                  otherButtonTitles:@"No",nil];
        [alertView show];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"GameUnwindSegue"])
    {
        // put some code in here to pass player data into the player model
    }
}



#pragma mark - Dynamic Animator/Behavior Related Methods

- (void)initializeBreakoutAnimation
{
    self.scoreLabel.text = @"0";
    self.ballView.center = self.view.center;
    [self instantiateDynamicAnimatorAndBehaviors];
    [self addBehaviorsToDynamicAnimator];
}


- (void)instantiateDynamicAnimatorAndBehaviors
{
    self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.ballView] mode:UIPushBehaviorModeInstantaneous];
    self.collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.paddleView,self.ballView]];
    self.paddleItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.paddleView]];
    self.ballItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.ballView]];
}


- (void)addBehaviorsToDynamicAnimator
{
    self.pushBehavior.pushDirection = CGVectorMake(0.5,1.0);
    self.pushBehavior.magnitude = 0.02;
    self.pushBehavior.active = YES;
    [self.dynamicAnimator addBehavior:self.pushBehavior];

    self.collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    self.collisionBehavior.collisionDelegate = self;
    CGRect mainScreenRect = [[UIScreen mainScreen] bounds];
    CGFloat bottomBoundaryYCoord = mainScreenRect.size.height;

    [self.collisionBehavior addBoundaryWithIdentifier:kBottomBoundaryIdString fromPoint:CGPointMake(0.0,bottomBoundaryYCoord) toPoint:CGPointMake(320.0,bottomBoundaryYCoord)];
    [self.dynamicAnimator addBehavior:self.collisionBehavior];

    self.paddleItemBehavior.density = 1000;
    self.paddleItemBehavior.allowsRotation = NO;
    [self.dynamicAnimator addBehavior:self.paddleItemBehavior];

    self.ballItemBehavior.friction = 0.0;
    self.ballItemBehavior.resistance = 0.0;
    self.ballItemBehavior.elasticity = 1.0;
    self.ballItemBehavior.allowsRotation = NO;
    [self.dynamicAnimator addBehavior:self.ballItemBehavior];
}


- (void)removeBehaviorsFromDynamicAnimator
{
    [self.dynamicAnimator removeBehavior:self.pushBehavior];
    [self.dynamicAnimator removeBehavior:self.collisionBehavior];
    [self.dynamicAnimator removeBehavior:self.paddleItemBehavior];
    [self.dynamicAnimator removeBehavior:self.ballItemBehavior];
    self.ballView.center = self.view.center;
}

@end

