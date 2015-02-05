//
//  ZS_TemplatesListViewController.m
//  Measurement
//
//  Created by DTSoft on 15/2/5.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "ZS_TemplatesListViewController.h"
#import "zsmb_TableViewCell.h"
#import "zsmb_Model.h"

@interface ZS_TemplatesListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property(nonatomic , strong)NSArray *m_dataSourceArr;

@property(nonatomic , strong)NSIndexPath *lastIndex;

@property (weak, nonatomic) IBOutlet UILabel *m_headTitle_LB;

@property(nonatomic, strong)id data;

@end

@implementation ZS_TemplatesListViewController

#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

#pragma mark - 自定义方法

/**
 *  初始化一些数据 父类中调用了
 */
-(void)SetUpData
{
    [self layoutMainCustomView];
    
    [self Add_RAC_Attention];
    
    
    
}


/**
 *  添加视图
 */
-(void)layoutMainCustomView
{
    self.m_headTitle_LB.text = @"选择证书模板";
    
}

/**
 *  添加rac检测
 */
-(void)Add_RAC_Attention
{
    //dzjlmbID=7A77D3409DA34336A3FD6B65759BC026
//    NSDictionary *dict = @{@"dzjlmbID":self.m_zsParameterDict[@"jlid"]};
     NSDictionary *dict = @{@"dzjlmbID":@"7A77D3409DA34336A3FD6B65759BC026"};
    [[BaseNetWork getInstance] showDialog];
    @weakify(self)
    [[[[BaseNetWork getInstance] rac_postPath:@"findZsmb.do" parameters:dict]map:^(id responseData)
      {
          NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
          
          return dict[@"zsmb"];
      }]subscribeNext:^(NSArray *arr){
          @strongify(self)
          
          
          self.m_dataSourceArr = [arr linq_select:^id(NSDictionary *dict){
              
              zsmb_Model *model = [MTLJSONAdapter modelOfClass:[zsmb_Model class] fromJSONDictionary:dict error:nil];
              
              
              return model;
              
          }];
          
          [self.m_tableView reloadData];
          
      }error:^(NSError *error){
          
          
      }];
    
    
}

/**
 *  获取  的数据
 */
-(void)loadNetData
{
    
    
}
- (IBAction)BackToVC:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^(void){
        
    }];
}
- (IBAction)CancleBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^(void){
        
    }];
}

- (IBAction)OKBtnClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^(void){
        if ([self.m_delegate respondsToSelector:@selector(ZS_TemplatesListVC:didSelectedOKByObj:)]) {
            [self.m_delegate ZS_TemplatesListVC:self didSelectedOKByObj:self.data];
        }
    }];
    
    
}

#pragma mark - 代理协议方法*


#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _m_dataSourceArr.count +1;
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
 
 
 - (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
 
 return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
 
 }
 
 
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
 {
 return @"";
 
 }*/
#pragma mark - UITableView Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    if(tableView == _m_tableView)
    {
        /**
         *  表头
         */
        if (indexPath.row == 0) {
            
            static NSString *cellIdentifier = @"zsmb_TableViewCellTitle";
            UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
            return cell;
            
        }else
        {
            static NSString *cellIdentifier = @"zsmb_TableViewCell";
            
            zsmb_TableViewCell *cell = (zsmb_TableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
            [cell configureCellWithItem:_m_dataSourceArr[indexPath.row -1] andIndex:indexPath.row];
            
            return cell;
        }
    }
    
    return nil;
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        
    }else
        
    {
        zsmb_Model *model = self.m_dataSourceArr[indexPath.row -1];
        if (_lastIndex && (_lastIndex.row -1) !=  (indexPath.row -1))
        {
            
            model.isSelected = YES;
            
            zsmb_Model *lastModel = self.m_dataSourceArr[_lastIndex.row -1];
            lastModel.isSelected = NO;
            
            
        }else
        {
            model.isSelected = !model.isSelected;
        }
        
        _lastIndex = indexPath;
        
        self.data = model;
        
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0;
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
