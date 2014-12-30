//
//  MyPlanViewCell.h
//  Measurement
//
//  Created by DTSoft on 14/12/26.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MyPlanViewCell;

@protocol SwipeMyPlanViewCellDelegate <NSObject>

- (void)MyPlanViewCell:(MyPlanViewCell *)cell didShowMenu:(BOOL)isShowingMenu;

- (void)MyPlanViewCellDidEndScrolling:(MyPlanViewCell *)cell;

- (void)MyPlanViewcollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;


- (void)MyPlanViewCellSharePress:(MyPlanViewCell *)cell;

- (void)MyPlanViewCellTopPress:(MyPlanViewCell *)cell;

@end

@interface MyPlanViewCell : UICollectionViewCell

@property (nonatomic, weak) id<SwipeMyPlanViewCellDelegate> delegate;

- (void)configureCellWithItem:(id )product;

- (void)hideUtilityButtonsAnimated:(BOOL)animated;

@end
