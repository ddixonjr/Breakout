//
//  PlayersViewController.m
//  Breakout
//
//  Created by Dennis Dixon on 5/25/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import "PlayersViewController.h"

@interface PlayersViewController () <UITableViewDataSource,UITableViewDelegate>

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

@end
