//
//  CommonLogicCell.h
//  Measurement
//
//  Created by DTSoft on 14/12/23.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommonLogicCell;

@protocol SwipeCellDelegate <NSObject>

- (void)cell:(CommonLogicCell *)cell didShowMenu:(BOOL)isShowingMenu;

- (void)cellDidEndScrolling:(CommonLogicCell *)cell;

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;


- (void)cellSharePress:(CommonLogicCell *)cell;

- (void)cellTopPress:(CommonLogicCell *)cell;

@end



@interface CommonLogicCell : UICollectionViewCell

@property (nonatomic, weak) id<SwipeCellDelegate> delegate;
@property (nonatomic, strong) IBOutlet UIButton *topToButton;

- (void)configureCellWithItem:(id )product;

- (void)hideUtilityButtonsAnimated:(BOOL)animated;



-(void)updateCommonLogicCellWith:(NSDictionary*) commonLogicDict;

-(void)updateOldCollectionCell;

@end
