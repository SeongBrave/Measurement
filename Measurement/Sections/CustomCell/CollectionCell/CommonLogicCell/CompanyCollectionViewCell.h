//
//  CollectionViewCell.h
//  Test
//
//  Created by beik on 12/24/14.
//  Copyright (c) 2014 beik. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CompanyCollectionViewCell;

@protocol SwipeCellDelegate <NSObject>

- (void)cell:(CompanyCollectionViewCell *)cell didShowMenu:(BOOL)isShowingMenu;

- (void)cellDidEndScrolling:(CompanyCollectionViewCell *)cell;

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;


- (void)cellSharePress:(CompanyCollectionViewCell *)cell;

- (void)cellTopPress:(CompanyCollectionViewCell *)cell;

@end



@interface CompanyCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id<SwipeCellDelegate> delegate;

- (void)configureCellWithItem:(id )product;

- (void)hideUtilityButtonsAnimated:(BOOL)animated;





@end
