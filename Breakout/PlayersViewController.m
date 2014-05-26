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

@interface PlayersViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PlayersViewController 


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.players = [NSMutableArray arrayWithObject:@"Player 1"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.players.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayerCell"];
    cell.textLabel.text = [self.players objectAtIndex:indexPath.row];

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PlayerDetailSegue"])
    {
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        [self.tableView deselectRowAtIndexPath:selectedIndexPath animated:NO];
        PlayerDetailViewController *playerDetailVC = segue.destinationViewController;
        playerDetailVC.playerName = (selectedIndexPath != nil) ? [self.players objectAtIndex:selectedIndexPath.row] :  kEmptyNSString;

    }
    else if ([segue.identifier isEqualToString:@"PlayBreakoutSegue"])
    {
        //  prepare to segue to the game VC
    }
}

- (IBAction)unwindToPlayerListWithSegue:(UIStoryboardSegue *)segue
{
    
}

@end
