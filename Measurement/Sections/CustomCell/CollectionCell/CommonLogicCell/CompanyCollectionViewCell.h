//
//  CollectionViewCell.h
//  Test
//
//  Created by beik on 12/24/14.
//  Copyright (c) 2014 beik. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  下厂任务cell
 */
@class CompanyCollectionViewCell;

@protocol SwipeCompanyCollectionViewCellDelegate <NSObject>

- (void)cell:(CompanyCollectionViewCell *)cell didShowMenu:(BOOL)isShowingMenu;

- (void)cellDidEndScrolling:(CompanyCollectionViewCell *)cell;

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  检测
 *
 *  @param cell
 */
- (void)cellDetectionPress:(CompanyCollectionViewCell *)cell;

/**
 *  驳回
 *
 *  @param cell
 */
- (void)cellRejectedPress:(CompanyCollectionViewCell *)cell;

/**
 *  标记已完成
 *
 *  @param cell
 */
- (void)cellMarkCompletedPress:(CompanyCollectionViewCell *)cell;

@end



@interface CompanyCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id<SwipeCompanyCollectionViewCellDelegate> m_delegate;

- (void)configureCellWithItem:(id )product;

- (void)hideUtilityButtonsAnimated:(BOOL)animated;





@end
