//
//  PlayersViewController.m
//  Breakout
//
//  Created by Dennis Dixon on 5/25/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import "PlayersViewController.h"
#import "BreakoutGameViewController.h"
#import "PlayerDetailViewController.h"
#import "PlayersManager.h"
#import "Player.h"


@interface PlayersViewController () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) PlayersManager *playersManager;

@end


@implementation PlayersViewController 


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.playersManager = [[PlayersManager alloc] init];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.players = [self.playersManager allPlayers];
    [self.tableView reloadData];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.players.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayerCell"];
    Player *curPlayer = [self.players objectAtIndex:indexPath.row];
    cell.textLabel.text = curPlayer.name;
    return cell;
}


- (IBAction)onAddButtonPressed:(id)sender
{
    [self performSegueWithIdentifier:@"PlayerDetailSegue" sender:sender];
}


- (IBAction)onPlayButtonPressed:(id)sender
{
    [self performSegueWithIdentifier:@"PlayBreakoutSegue" sender:sender];
}

// Refactor this interaction between this and the players detail view controller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PlayerDetailSegue"])
    {
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        [self.tableView deselectRowAtIndexPath:selectedIndexPath animated:NO];
        PlayerDetailViewController *playerDetailVC = segue.destinationViewController;
        if (selectedIndexPath != nil)
        {
            Player *selectedPlayer = [self.players objectAtIndex:selectedIndexPath.row];
            playerDetailVC.player = selectedPlayer;
         }
        else
        {
            playerDetailVC.playersManager = self.playersManager;
            playerDetailVC.player = nil;
        }
    }
    else if ([segue.identifier isEqualToString:@"PlayBreakoutSegue"])
    {
        //  prepare to segue to the game VC
        BreakoutGameViewController *breakoutGameVC = segue.destinationViewController;
        breakoutGameVC.playersManager  = self.playersManager;
    }
}

- (IBAction)unwindToPlayerListWithSegue:(UIStoryboardSegue *)segue
{
//    PlayerDetailViewController *playerDetailVC = segue.sourceViewController;
//
//    if (playerDetailVC.newPlayerAdded)
//    {
//        [self.players addObject:playerDetailVC.player];
//    }
//    [self.tableView reloadData];
}

@end
