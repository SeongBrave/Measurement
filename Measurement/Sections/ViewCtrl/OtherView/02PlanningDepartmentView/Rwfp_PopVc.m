//
//  Rwfp_PopVc.m
//  Measurement
//
//  Created by DTSoft on 15/3/31.
//  Copyright (c) 2015年 成勇. All rights reserved.
//

#import "Rwfp_PopVc.h"
#import "rwfp_Cell.h"
#import "Rwfp_model.h"

@interface Rwfp_PopVc ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (nonatomic, strong) NSIndexPath *lastIndex;

@property(nonatomic, strong)NSMutableArray *m_didSelectedArr;

@end

@implementation Rwfp_PopVc



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

//TODO: 添加视图
-(void)layoutMainCustomView
{
    
}

-(void)SetUpData
{
    
    self.m_didSelectedArr = [[NSMutableArray alloc]init];
    [self layoutMainCustomView];
    
}

#pragma mark - 代理协议方法*

#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _m_dataSourceArr.count;
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

#pragma mark - UITableView Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier;
    
    cellIdentifier = @"rwfp_Cell";
    rwfp_Cell *cell = (rwfp_Cell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    
    
    [cell configureCellWithItem:self.m_dataSourceArr[indexPath.row]];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    rwfp_model *model = self.m_dataSourceArr[indexPath.row];
    
    if ([model.sffp intValue] == 1) {
        model.sffp = @"0";
    }else
    {
        model.sffp = @"1";
    }
    
    if ([model.sffp intValue] == 1) {
        
        [self.m_didSelectedArr addObject:model];
    }else
    {
        [self.m_didSelectedArr removeObject:model];
    }
    

    
    
    if ([self.m_delegate respondsToSelector:@selector(Rwfp_PopVc:didSelectedArr:)]) {
        
        
        [self.m_delegate Rwfp_PopVc:self didSelectedArr:_m_didSelectedArr];
        
    }

    
    
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


- (IBAction)BtnOkClick:(id)sender {
    
    NSMutableArray *rwbhArr = [[NSMutableArray alloc]init];
    for(rwfp_model *model in self.m_dataSourceArr)
    {
        if ([model.sffp intValue] == 1) {
            [rwbhArr addObject:model.usercode];
        }
        
    }
    
    NSString *rwbhStr = [rwbhArr componentsJoinedByString:@","];
    
    
//    findDutyRwfpqr.do
    
    [self dismissViewControllerAnimated:YES completion:^(void){
        
        
        
        
        LoginedUser *usr = [LoginedUser sharedInstance];
        /**
         *  获取任务分配
         */
        [[BaseNetWork getInstance] showDialogWithVC:self];
        [[[[[BaseNetWork getInstance] rac_postPath:@"findDutyRwfpqr1.do" parameters:@{@"rwbh":self.m_shaowDict[@"rwbh"],@"userCode":usr.usercode,@"xcrybhs":rwbhStr}]map:^(id responseData)
           {
               NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseData];
               
               return dict;
           }] deliverOn:[RACScheduler mainThreadScheduler]] //在主线程中更新ui
         subscribeNext:^(NSDictionary *retDict) {
             
             
             if ([retDict[@"ret"]intValue] == 1) {
                 
                 [Dialog toastSuccess];
             }else
             {
                 [Dialog toastError:@"保存失败!"];
             }
             
             
             
             
         }error:^(NSError *error){
             
             
         }];
        

        
        
    }];

    
    
}

- (IBAction)BackClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^(void){
        
    }];
    
}

@end
