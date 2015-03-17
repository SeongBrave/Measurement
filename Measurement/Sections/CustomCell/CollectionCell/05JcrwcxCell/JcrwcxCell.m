//
//  JcrwcxCell.m
//  Measurement
//
//  Created by DTSoft on 15/3/4.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "JcrwcxCell.h"
#import "Jcrwcx_Model.h"

static CGFloat BUTTONWIDTH = 70.0f;

@interface JcrwcxCell ()<UIScrollViewDelegate>


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

@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *lineViews;

@property (nonatomic, assign) BOOL isShowingMenu;

@property (weak, nonatomic) IBOutlet UIImageView *m_state_ImgV;

@end

@implementation JcrwcxCell

- (void)configureCellWithItem:(id )product
{
    Jcrwcx_Model* model = (Jcrwcx_Model*) product;
    
    debug_object(product);
//    self.m_dateL.text =[product GetLabelWithKey:@"今天"];
    
    
    self.m_companyNameL.text = [model.wtdw GetNotNullStr];

    self.m_companyAddrL.text = [model.dwdz GetNotNullStr];
    self.m_contactNameL.text =  [model.wtdbh GetNotNullStr];
    self.m_contactTelL.text = [model.yqmc GetNotNullStr];

    self.m_inFactoryTimeL.text = [model.jclx GetNotNullStr];
    self.m_headManNameL.text = [model.jdjg GetNotNullStr];
    
    self.m_inFactoryMansL.text = [model.jllx GetNotNullStr];
    
    self.m_noteL.text = [model.zsbh GetNotNullStr];
 
    
    if ([model.by1 isEqualToString:@"1"]) {
        [self.m_state_ImgV setImage:[UIImage imageNamed:@"right-card-title-ytj"]];
    }else
    {
         [self.m_state_ImgV setImage:[UIImage imageNamed:@"right-card-title-wtj"]];
        
//        if ([[product GetLabelWithKey:@"RYRWWCQK"] isEqualToString:@"1"]) {
//            [self.m_state_ImgV setImage:[UIImage imageNamed:@"right-card-title-ywc"]];
//        }else
//        {
//            [self.m_state_ImgV setImage:[UIImage imageNamed:@"right-card-title-wwc"]];
//            
//        }
    }
    
}

- (void)awakeFromNib{
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapped:)];
    [self.scrollViewContentView addGestureRecognizer:tapRecognizer];
    
    for (UIView *view  in _lineViews) {
        view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"collectionLabelLine"]];
    }
    
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
            if (_m_delegate && [self.m_delegate respondsToSelector:@selector(cellDidEndScrolling:)]) {
                [self.m_delegate cellDidEndScrolling:self];
            }
            if (_m_delegate && [self.m_delegate respondsToSelector:@selector(cell:didShowMenu:)]) {
                [self.m_delegate cell:self didShowMenu:self.isShowingMenu];
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
        if (_m_delegate && [self.m_delegate respondsToSelector:@selector(cell:didShowMenu:)]) {
            [self.m_delegate cell:self didShowMenu:self.isShowingMenu];
        }
    }
}

- (IBAction)cellDetectionPress:(id)sender{
    if (_m_delegate && [self.m_delegate respondsToSelector:@selector(cellDetectionPress:)]) {
        [self.m_delegate cellDetectionPress:self];
    }
}

- (IBAction)cellRejectedPress:(id)sender{
    if (_m_delegate && [self.m_delegate respondsToSelector:@selector(cellRejectedPress:)]) {
        [self.m_delegate cellRejectedPress:self];
    }
}

- (IBAction)cellMarkCompletedPress:(id)sender{
    if (_m_delegate && [self.m_delegate respondsToSelector:@selector(cellMarkCompletedPress:)]) {
        [self.m_delegate cellMarkCompletedPress:self];
    }
}

- (void)cellTapped:(UITapGestureRecognizer*)tapGesture
{
    if (_isShowingMenu) {
        [self hideUtilityButtonsAnimated:YES];
    }
    else{
        if (_m_delegate && [self.m_delegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)]){
            
            UICollectionView *collectionView = (UICollectionView *)[self superview];
            
            if (![collectionView isKindOfClass:[UITableView class]]){
                collectionView = (UICollectionView *)self.superview;
            }
            NSIndexPath *indexPath = [collectionView indexPathForCell:self];
            
            [self.contentView sendSubviewToBack:_scrollViewButtonView];
            
            [self.m_delegate collectionView:collectionView didSelectItemAtIndexPath:indexPath];
        }
    }
}


@end
