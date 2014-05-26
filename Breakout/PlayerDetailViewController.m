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

@end

@implementation PlayerDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.playerNameTextField.text = self.playerName;

}

- (IBAction)onDoneButtonPressed:(id)sender
{

}


- (IBAction)onBackgroundTapped:(id)sender
{
    [self.playerNameTextField resignFirstResponder];
}


@end
