//
//  JcrwcxCell.h
//  Measurement
//
//  Created by DTSoft on 15/3/4.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

/**
 *  检测类型查询
 */

@class JcrwcxCell;

@protocol SwipeJcrwcxCellDelegate <NSObject>

- (void)cell:(JcrwcxCell *)cell didShowMenu:(BOOL)isShowingMenu;

- (void)cellDidEndScrolling:(JcrwcxCell *)cell;

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  检测
 *
 *  @param cell
 */
- (void)cellDetectionPress:(JcrwcxCell *)cell;

/**
 *  驳回
 *
 *  @param cell
 */
- (void)cellRejectedPress:(JcrwcxCell *)cell;

/**
 *  标记已完成
 *
 *  @param cell
 */
- (void)cellMarkCompletedPress:(JcrwcxCell *)cell;

@end

@interface JcrwcxCell : UICollectionViewCell


@property (nonatomic, weak) id<SwipeJcrwcxCellDelegate> m_delegate;
@property(nonatomic , assign) BOOL isCanSwipe;
- (void)configureCellWithItem:(id )product;

- (void)hideUtilityButtonsAnimated:(BOOL)animated;


@end
