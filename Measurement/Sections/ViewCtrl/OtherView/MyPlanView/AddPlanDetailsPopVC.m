//
//  AddPlanDetailsPopVC.m
//  Measurement
//
//  Created by DTSoft on 15/1/4.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "AddPlanDetailsPopVC.h"

@interface AddPlanDetailsPopVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate>



/**
 *  科室负责人
 */
@property (weak, nonatomic) IBOutlet UITableView *headTableView;
/**
 *  科室人员
 */
@property (weak, nonatomic) IBOutlet UITableView *mansTableView;


/**
 *  备注
 */
@property (weak, nonatomic) IBOutlet UITextView *noteTF;
/**
 *  单位名称
 */
@property (weak, nonatomic) IBOutlet UITextField *nameOFEntityTF;

/**
 *  单位地址
 */
@property (weak, nonatomic) IBOutlet UITextField *addrOFEntity;
/**
 *  联系人
 */
@property (weak, nonatomic) IBOutlet UITextField *contactTF;

/**
 *  联系电话
 */
@property (weak, nonatomic) IBOutlet UITextField *ContactTELTF;

/**
 *  所在区
 */
@property (weak, nonatomic) IBOutlet UITextField *districtTF;

/**
 *  行业类别
 */
@property (weak, nonatomic) IBOutlet UITextField *IndustryCategoriesTF;

/**
 *  邮编
 */
@property (weak, nonatomic) IBOutlet UITextField *zipCodeTF;

/**
 *  业务负责科室
 */
@property (weak, nonatomic) IBOutlet UITextField *responsibleDepTF;

/**
 *  业务负责人
 */
@property (weak, nonatomic) IBOutlet UITextField *headOFTF;

/**
 *  取证日期
 */
@property (weak, nonatomic) IBOutlet UITextField *evidenceDateTF;

/**
 *  特殊要求
 */
@property (weak, nonatomic) IBOutlet UITextField *specialReqTF;
@property (weak, nonatomic) IBOutlet UIView *fromDateView;

@property (weak, nonatomic) IBOutlet UIView *toDateView;

@end

@implementation AddPlanDetailsPopVC
#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self SetUpData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

// TODO: 使用autolayout 布局界面
- (void)updateViewConstraints
{
    [super updateViewConstraints];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark - 自定义方法

-(void)awakeFromNib
{
    
}
//TODO: 添加视图
-(void)layoutMainCustomView
{
    /**
     *  绘制分割线
     *
     */
    self.headTableView.layer.borderWidth = 2.0;
    self.headTableView.layer.borderColor = UIColorFromRGB(217, 217, 217).CGColor;

    self.mansTableView.layer.borderWidth = 2.0;
    self.mansTableView.layer.borderColor = UIColorFromRGB(217, 217, 217).CGColor;

    self.noteTF.layer.borderWidth = 2.0;
    self.noteTF.layer.borderColor = UIColorFromRGB(217, 217, 217).CGColor;
    
    
    self.toDateView.layer.borderWidth = 2.0;
    self.toDateView.layer.borderColor = UIColorFromRGB(217, 217, 217).CGColor;
    
    self.fromDateView.layer.borderWidth = 2.0;
    self.fromDateView.layer.borderColor = UIColorFromRGB(217, 217, 217).CGColor;
    

    /**
     *  ios7以后需要专门设置下分割线要不然不是从每行的开始绘制的
     *
     */
//    [self.headTableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
//    [self.mansTableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
//    
}

-(void)SetUpData
{
    [self layoutMainCustomView];
  
    
}


- (IBAction)dismissClick:(id)sender {
    
    if ([self.m_popDelegate respondsToSelector:@selector(dismissPopoverSelected)]) {
        [self.m_popDelegate dismissPopoverSelected];
    }
}
- (IBAction)cancleClick:(id)sender {
    
    if ([self.m_popDelegate respondsToSelector:@selector(dismissPopoverSelected)]) {
        [self.m_popDelegate dismissPopoverSelected];
    }
}
- (IBAction)okClick:(id)sender {
    
    [Dialog toast:@"确定"];
    
    
}

#pragma mark - 代理协议方法

#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
/*
 -(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
 {
 
 return nil;
 }
 
 -(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
 {
 
 return nil;
 }
 -(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
 {
 return 0;
 }
 */

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    
}

#pragma mark - UITableView Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier;
    if (tableView == self.headTableView) {
        cellIdentifier = @"headTableViewCell";
          UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
//        radio-defauit
        
        if(indexPath.row == 0)
        {
            cell.imageView.image = [UIImage imageNamed:@"radio-selected"];
        }else
        {
            cell.imageView.image = [UIImage imageNamed:@"radio-defauit"];
        }
        
        
        cell.textLabel.text = @"检验科室A组";
        return cell;
    }else
    {
        cellIdentifier = @"mansTableView";
          UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.imageView.image = [UIImage imageNamed:@"checkbox-selected"];
        
        cell.textLabel.text = @"检验科室A组";
        return cell;
        
    }
 
    
  
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

/*
 //设置cell的行高
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 return 70;
 }
 
 //设置cell的隔行换色
 - (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if ([indexPath row] % 2 == 0) {
 cell.backgroundColor = [UIColor blueColor];
 } else {
 cell.backgroundColor = [UIColor greenColor];
 }
 }
 //滑动选择的行后删除
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 NSLog(@"执行删除操作");
 }
 
 */






@end
