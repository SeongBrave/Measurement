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




/**
 *  删除
 *
 *  @param cell 
 */
- (void)deletePress:(MyPlanViewCell *)cell;

/**
 *  编辑
 *
 *  @param cell
 */
- (void)editorPress:(MyPlanViewCell *)cell;

/**
 *  标记完成
 *
 *  @param cell
 */
- (void)markCompletedPress:(MyPlanViewCell *)cell;

@end

@interface MyPlanViewCell : UICollectionViewCell


/**
 *  保存数据
 */
@property(nonatomic , strong)NSDictionary * dataDict;

@property (nonatomic, weak) id<SwipeMyPlanViewCellDelegate> delegate;

- (void)configureCellWithItem:(id )product;

- (void)hideUtilityButtonsAnimated:(BOOL)animated;

@end
