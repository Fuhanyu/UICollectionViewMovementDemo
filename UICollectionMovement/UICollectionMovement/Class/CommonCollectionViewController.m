//
//  CommonCollectionViewController.m
//  UICollectionMovement
//
//  Created by Fuhanyu on 16/2/17.
//  Copyright © 2016年 AParty. All rights reserved.
//

#import "CommonCollectionViewController.h"

#import "CommonCollectionViewCell.h"

@interface CommonCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation CommonCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSomeThing];
    [self setUpCollectionView];
    [self setUpMovement];
}

- (void)setUpSomeThing{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title = @"普通collection移动";
    self.dataArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 20; i++) {
        [_dataArray addObject:[NSString stringWithFormat:@"%ld", i]];
    }
}

- (void)setUpCollectionView{
    CGFloat itemWidth = (self.view.frame.size.width - 50) / 3;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(itemWidth, itemWidth)];
    [flowLayout setMinimumInteritemSpacing:10];
    [flowLayout setMinimumLineSpacing:10];
    [flowLayout setSectionInset:UIEdgeInsetsMake(10, 10, 0, 10)];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20) collectionViewLayout:flowLayout];
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CommonCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([CommonCollectionViewCell class])];
    [_collectionView setDelegate:self];
    [_collectionView setDataSource:self];
    [self.view addSubview:_collectionView];
}

- (void)setUpMovement{
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.collectionView addGestureRecognizer:longPressGestureRecognizer];
}

- (void)longPressAction:(UIGestureRecognizer *)gesture{
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[gesture locationInView:self.collectionView]];
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:{
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            break;
        }
        case UIGestureRecognizerStateChanged:{
            [self.collectionView updateInteractiveMovementTargetPosition:[gesture locationInView:self.collectionView]];
            break;
        }
        case UIGestureRecognizerStateEnded:{
            [self.collectionView endInteractiveMovement];
            break;
        }
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}

#pragma mark collectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *collectionViewTitle = [_dataArray objectAtIndex:indexPath.row];
    CommonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CommonCollectionViewCell class]) forIndexPath:indexPath];
    [cell.numberLabel setText:collectionViewTitle];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSString *temp = [_dataArray objectAtIndex:sourceIndexPath.row];
    [_dataArray removeObjectAtIndex:sourceIndexPath.row];
    [_dataArray insertObject:temp atIndex:destinationIndexPath.row];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
