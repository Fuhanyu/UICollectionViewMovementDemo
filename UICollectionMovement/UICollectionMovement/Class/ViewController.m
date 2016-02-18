//
//  ViewController.m
//  UICollectionMovement
//
//  Created by Fuhanyu on 16/2/17.
//  Copyright © 2016年 AParty. All rights reserved.
//

#import "ViewController.h"

#import "CommonCollectionViewController.h"


@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *cellTitles;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"FuhanyuMovementDemo";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.cellTitles = @[@"commonCollection"];
    [self setUpTableView];
}

- (void)setUpTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20) style:UITableViewStylePlain];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [self.view addSubview:_tableView];
}

#pragma mark UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellTitles = [_cellTitles objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
    }
    [cell.textLabel setText:cellTitles];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            CommonCollectionViewController *commonCollectionViewController = [CommonCollectionViewController new];
            [self.navigationController pushViewController:commonCollectionViewController animated:YES];
            break;
        }
        default:{
            break;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cellTitles.count;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
