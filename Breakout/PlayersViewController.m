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

typedef enum {
    kPlayersEditModeOff,
    kPlayersEditModeEdit,
    kPlayersEditModeAdd
} PlayersEditMode;

@interface PlayersViewController () <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *addPlayerTextField;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (strong, nonatomic) PlayersManager *playersManager;
@property (strong, nonatomic) NSArray *players;
@property (assign, nonatomic) PlayersEditMode playersEditMode;
@property (assign, nonatomic) NSInteger selectedRow;

@end


@implementation PlayersViewController 


#pragma mark - UIViewController Lifecycle Methods
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.playersManager = [[PlayersManager alloc] init];
    self.navigationController.navigationBar.topItem.title = @"Breakout Players";
    self.addPlayerTextField.delegate = self;
    self.playersEditMode = kPlayersEditModeOff;
    self.selectedRow = NSNotFound;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.players = [self.playersManager allPlayers];
    self.tableView.editing = NO;
    [self.tableView reloadData];
}


#pragma mark - UITableView Datasource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.players.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayerCell"];
    Player *curPlayer = self.players[indexPath.row];
    cell.textLabel.text = curPlayer.name;
    return cell;
}


#pragma mark - UITableView Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    [self.addButton setTitle:@"Done" forState:UIControlStateNormal];
    self.playersEditMode = kPlayersEditModeEdit;
    self.selectedRow = indexPath.row;
    Player *selectedPlayer = self.players[self.selectedRow];
    self.addPlayerTextField.text = selectedPlayer.name;
    [self.addPlayerTextField becomeFirstResponder];
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.playersManager removePlayer:self.players[indexPath.row]];
        [tableView reloadData];
    }
}

#pragma mark - UITextField Delegate Methods

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.text.length > 0)
    {
        self.playersEditMode = kPlayersEditModeEdit;
    }
    else
    {
        self.playersEditMode = kPlayersEditModeAdd;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - IBAction Methods

- (IBAction)onAddNewPlayerButtonPressed:(id)sender
{
    BOOL duplicatePlayerNameFound = [self isPlayerDuplicate:self.addPlayerTextField.text];

    if (self.addPlayerTextField.text.length > 0 && !duplicatePlayerNameFound)
    {

        if (self.playersEditMode == kPlayersEditModeAdd)
        {
            Player *newPlayer = [[Player alloc] initWithName:self.addPlayerTextField.text andTurnsAtStart:kDefaultNumberOfTurns];
            [self.playersManager addPlayer:newPlayer];
        }
        else if (self.playersEditMode == kPlayersEditModeEdit)
        {
            Player *selectedPlayer = self.players[self.selectedRow];
            selectedPlayer.name = self.addPlayerTextField.text;
        }
        self.addPlayerTextField.text = @"";
        [self.tableView reloadData];
        [self.addPlayerTextField resignFirstResponder];
        [self.addButton setTitle:@"Add" forState:UIControlStateNormal];
    }
    else if (self.addPlayerTextField.text.length > 0 && duplicatePlayerNameFound)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Duplicate Player Name" message:@"Please change the name and try again" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }

}


- (IBAction)onPlayButtonPressed:(id)sender
{
    if (!self.tableView.isEditing && [[self.playersManager allPlayers] count] > 0)
    {
        [self performSegueWithIdentifier:@"PlayBreakoutSegue" sender:sender];
    }
}


#pragma mark - Navigation Related Methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PlayBreakoutSegue"])
    {
        BreakoutGameViewController *breakoutGameVC = segue.destinationViewController;
        breakoutGameVC.playersManager  = self.playersManager;
    }
}

- (void)unwindToPlayerListWithSegue:(UIStoryboardSegue *)segue
{
    //  Exit segue to facilitate transition from breakout game view controller
}


#pragma mark - Helper Methods

- (BOOL)isPlayerDuplicate:(NSString *)playerName
{

    BOOL duplicatePlayerFound = NO;

    for (int curIndex=0; curIndex<self.players.count; curIndex++)
    {
        Player *curPlayer = self.players[curIndex];
        if ([curPlayer.name isEqualToString:playerName])
        {
            if ((self.playersEditMode == kPlayersEditModeAdd) ||
                (self.playersEditMode == kPlayersEditModeEdit && curIndex != self.selectedRow))
            {
                duplicatePlayerFound = YES;
                break;
            }
        }
    }

    return duplicatePlayerFound;
}



@end
