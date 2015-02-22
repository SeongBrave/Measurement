//
//  MyPlanViewCell.m
//  Measurement
//
//  Created by DTSoft on 14/12/26.
//  Copyright (c) 2014年 成勇. All rights reserved.
//

#import "MyPlanViewCell.h"


static CGFloat BUTTONWIDTH = 70.0f;

@interface MyPlanViewCell ()<UIScrollViewDelegate>


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

@implementation MyPlanViewCell
- (void)configureCellWithItem:(id )product
{
    
    NSDictionary * commonLogicDict = (NSDictionary *)product;
    
    
    self.dataDict = commonLogicDict;
    
    self.m_dateL.text =[product GetLabelWithKey:@"今天"];
    self.m_companyNameL.text = [product GetLabelWithKey:@"WTDWMC"];
    self.m_companyAddrL.text = [product GetLabelWithKey:@"DWDZ"];
    self.m_contactNameL.text =  [product GetLabelWithKey:@"CJR"];
    self.m_contactTelL.text = [product GetLabelWithKey:@"LXDH"];
    NSString *str = [product GetLabelWithKey:@"XCSJQ"];
    NSRange range;
    range.location = 0;
    range.length = 10;
    if (str.length > 10) {
        str = [str substringWithRange:range];
    }
    self.m_inFactoryTimeL.text = str;
    self.m_headManNameL.text = [product GetLabelWithKey:@"YWFZR"];
   
    self.m_noteL.text =[product GetLabelWithKey:@"BZ"];
    
    NSMutableString *inFactoryMansStr = [[NSMutableString alloc]init];
    
    for(NSDictionary *dict in product[@"xcry"])
    {
        [inFactoryMansStr appendFormat:@",%@",dict[@"XCRY"]];
    }
    
     self.m_inFactoryMansL.text = inFactoryMansStr.length>=1?[inFactoryMansStr substringFromIndex:1]:@"无";
    
    if ([[product GetLabelWithKey:@"BY1"] isEqualToString:@"1"]) {
        [self.m_state_ImgV setImage:[UIImage imageNamed:@"right-card-title-yqz"]];
    }else
    {
        if ([[product GetLabelWithKey:@"RWWCQK"] isEqualToString:@"1"]) {
            [self.m_state_ImgV setImage:[UIImage imageNamed:@"right-card-title-ywc"]];
        }else
        {
            [self.m_state_ImgV setImage:[UIImage imageNamed:@"right-card-title-wwc"]];
            
        }
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
            if (_delegate && [self.delegate respondsToSelector:@selector(MyPlanViewCellDidEndScrolling:)]) {
                [self.delegate MyPlanViewCellDidEndScrolling:self];
            }
            if (_delegate && [self.delegate respondsToSelector:@selector(MyPlanViewCell:didShowMenu:)]) {
                [self.delegate MyPlanViewCell:self didShowMenu:self.isShowingMenu];
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
        if (_delegate && [self.delegate respondsToSelector:@selector(MyPlanViewCell:didShowMenu:)]) {
            [self.delegate MyPlanViewCell:self didShowMenu:self.isShowingMenu];
        }
    }
}

- (IBAction)editorPress:(id)sender {
    
    if (_delegate && [self.delegate respondsToSelector:@selector(editorPress:)]) {
        [self.delegate editorPress:self];
    }
}

- (IBAction)deletePress:(id)sender {
    
    if (_delegate && [self.delegate respondsToSelector:@selector(deletePress:)]) {
        [self.delegate deletePress:self];
    }
}

- (IBAction)markCompletedPress:(id)sender {
    
    if (_delegate && [self.delegate respondsToSelector:@selector(deletePress:)]) {
        [self.delegate deletePress:self];
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
            
            [self.delegate MyPlanViewcollectionView:collectionView didSelectItemAtIndexPath:indexPath];
        }
    }
}

@end
