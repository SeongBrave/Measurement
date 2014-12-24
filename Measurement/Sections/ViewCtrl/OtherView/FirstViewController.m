//
//  FirstViewController.m
//  Measurement
//
//  Created by 凌晨 on 12/24/14.
//  Copyright (c) 2014 成勇. All rights reserved.
//

#import "FirstViewController.h"
#import "CompanyCollectionViewCell.h"

@interface FirstViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, SwipeCellDelegate>

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView Delegate Method

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"CompanyCell";
    CompanyCollectionViewCell *cell = (CompanyCollectionViewCell  *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    return cell;
}

@end
