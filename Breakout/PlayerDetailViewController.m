//
//  PlayerDetailViewController.m
//  Breakout
//
//  Created by Dennis Dixon on 5/25/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import "PlayerDetailViewController.h"


@interface PlayerDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *playerNameTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *updateButton;
@property (assign, nonatomic) BOOL isExistingPlayer;

@end

@implementation PlayerDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.newPlayerAdded = NO;
    if (self.player != nil)
    {
        self.editing = NO;
        self.isExistingPlayer = YES;
        self.playerNameTextField.userInteractionEnabled = NO;
        self.playerNameTextField.text = self.player.name;
        [self.updateButton setTitle:@"Edit"];
    }
    else
    {
        self.editing = YES;
        self.isExistingPlayer = NO;
        self.playerNameTextField.userInteractionEnabled = YES;
        [self.playerNameTextField becomeFirstResponder];
        [self.updateButton setTitle:@"Done"];
    }
}


- (IBAction)onEditButtonPressed:(id)sender
{
    self.editing = !self.editing;
    if (self.editing)
    {
        self.playerNameTextField.userInteractionEnabled = YES;
        [self.playerNameTextField becomeFirstResponder];
        [self.updateButton setTitle:@"Done"];
    }
    else
    {
        if ([self.playerNameTextField.text length] > 0)
        {
            [self.playerNameTextField resignFirstResponder];
            if (self.isExistingPlayer ||
               (!self.isExistingPlayer && self.newPlayerAdded))
            {
                self.player.name = self.playerNameTextField.text;
                self.playerNameTextField.userInteractionEnabled = NO;
                self.playerNameTextField.text = self.player.name;
                [self.updateButton setTitle:@"Edit"];
            }
            else if (!self.isExistingPlayer && !self.newPlayerAdded)
            {
                self.player = [[Player alloc] init];
                self.player.name = self.playerNameTextField.text;
                self.newPlayerAdded = YES;
                [self.playersManager addPlayer:self.player];
            }
        }
    }
}


- (IBAction)onBackgroundTapped:(id)sender
{
    [self.playerNameTextField resignFirstResponder];
}

@end
