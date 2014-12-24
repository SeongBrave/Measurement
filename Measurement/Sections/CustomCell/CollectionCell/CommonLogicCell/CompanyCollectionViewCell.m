//
//  CollectionViewCell.m
//  Test
//
//  Created by beik on 12/24/14.
//  Copyright (c) 2014 beik. All rights reserved.
//

#import "CompanyCollectionViewCell.h"

static CGFloat BUTTONWIDTH = 90.0f;

@interface CompanyCollectionViewCell ()<UIScrollViewDelegate>


@property (nonatomic, strong) IBOutlet UIView *scrollViewContentView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIView *scrollViewButtonView;


/**
 *  日期 ：今天
 */
@property(nonatomic , strong) IBOutlet UILabel *m_dateL;

/**
 *  公司姓名： ***有限公司
 */
@property(nonatomic , strong) IBOutlet UILabel *m_companyNameL;

/**
 *  公司地址
 */
@property(nonatomic , strong) IBOutlet UILabel *m_companyAddrL;

/*
 *  联系人姓名
 */
@property(nonatomic , strong) IBOutlet UILabel *m_contactNameL;


/**
 *  联系电话
 */
@property(nonatomic , strong) IBOutlet UILabel *m_contactTelL;

/**
 *  下厂时间
 */
@property(nonatomic , strong) IBOutlet UILabel *m_inFactoryTimeL;

/**
 *  负责人
 */
@property(nonatomic , strong) IBOutlet UILabel *m_headManNameL;

/**
 *  下厂人员
 */
@property(nonatomic , strong) IBOutlet UILabel *m_inFactoryMansL;

/**
 *  备注
 */
@property(nonatomic , strong) IBOutlet UILabel *m_noteL;

@property (nonatomic, assign) BOOL isShowingMenu;


@end

@implementation CompanyCollectionViewCell


- (void)configureCellWithItem:(id )product{
    
}

- (void)awakeFromNib{
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapped:)];
    [self.scrollViewContentView addGestureRecognizer:tapRecognizer];
    
}


- (void)hideUtilityButtonsAnimated:(BOOL)animated{
    [self.scrollView setContentOffset:CGPointZero animated:animated];
}


- (void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    self.scrollViewButtonView.alpha = highlighted ? 0.0f : 1.0f;
}


#pragma mark - Overridden Methods


- (void)prepareForReuse {
    [super prepareForReuse];
    [self.scrollView setContentOffset:CGPointZero animated:NO];
    [self.contentView sendSubviewToBack:_scrollViewButtonView];
}


#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (scrollView.contentOffset.x > BUTTONWIDTH){
        targetContentOffset->x = BUTTONWIDTH;
    }
    else {
        *targetContentOffset = CGPointZero;
        dispatch_async(dispatch_get_main_queue(), ^{
            [scrollView setContentOffset:CGPointZero animated:YES];
        });
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x < 0.0f) {
        scrollView.contentOffset = CGPointZero;
    }
    if (!_isShowingMenu) {
        [self.contentView sendSubviewToBack:_scrollViewButtonView];
    }
    
    if (scrollView.contentOffset.x >= BUTTONWIDTH) {
        if (!self.isShowingMenu) {
            self.isShowingMenu = YES;
            [self.contentView bringSubviewToFront:_scrollViewButtonView];
            if (_delegate && [self.delegate respondsToSelector:@selector(cellDidEndScrolling:)]) {
                [self.delegate cellDidEndScrolling:self];
            }
            if (_delegate && [self.delegate respondsToSelector:@selector(cell:didShowMenu:)]) {
                [self.delegate cell:self didShowMenu:self.isShowingMenu];
            }
        }
    }
    else if (scrollView.contentOffset.x < BUTTONWIDTH && scrollView.contentOffset.x != 0.0f){
        if (scrollView.contentOffset.x < BUTTONWIDTH) {
            self.isShowingMenu = NO;
        }
    }
    else{
        self.isShowingMenu = NO;
        [self.contentView sendSubviewToBack:_scrollViewButtonView];
        if (_delegate && [self.delegate respondsToSelector:@selector(cell:didShowMenu:)]) {
            [self.delegate cell:self didShowMenu:self.isShowingMenu];
        }
    }
}


- (IBAction)didShareButtonPress:(id)sender{
    if (_delegate && [self.delegate respondsToSelector:@selector(cellSharePress:)]) {
        [self.delegate cellSharePress:self];
    }
}

- (IBAction)didTopButtonPress:(id)sender{
    if (_delegate && [self.delegate respondsToSelector:@selector(cellTopPress:)]) {
        [self.delegate cellTopPress:self];
    }
}

- (void)cellTapped:(UITapGestureRecognizer*)tapGesture
{
    if (_isShowingMenu) {
        [self hideUtilityButtonsAnimated:YES];
    }
    else{
        if (_delegate && [self.delegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)]){
            
            UICollectionView *collectionView = (UICollectionView *)[self superview];
            
            if (![collectionView isKindOfClass:[UITableView class]]){
                collectionView = (UICollectionView *)self.superview;
            }
            NSIndexPath *indexPath = [collectionView indexPathForCell:self];
            
            [self.contentView sendSubviewToBack:_scrollViewButtonView];
            
            [self.delegate collectionView:collectionView didSelectItemAtIndexPath:indexPath];
        }
    }
}

@end
