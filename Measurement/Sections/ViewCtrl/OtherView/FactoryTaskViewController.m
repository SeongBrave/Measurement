//
//  FactoryTaskViewController.m
//  Measurement
//
//  Created by DTSoft on 14/12/22.
//  Copyright (c) 2014年 成勇. All rights r    eserved.
//

#import "FactoryTaskViewController.h"
#import "FactoryTaskCell.h"
#import <UIColor+HexString.h>

@interface FactoryTaskViewController ()<UITableViewDataSource, UITableViewDelegate, SWTableViewCellDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation FactoryTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}

//-(void)SetUpData
//{
//    [super SetUpData];
//    self.title = @"下厂任务";
//    self.view.backgroundColor = [UIColor blueColor];
//    
//}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithHexString:@"99958a"] title:@"检测"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithHexString:@"99958a"] title:@"驳回"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithHexString:@"99958a"] title:@"标记完成"];
    
    return rightUtilityButtons;
}


#pragma mark - Table view Delegate Method


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"FactoryTaskCell";
    FactoryTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.rightUtilityButtons = [self rightButtons];
    [cell configureCellWithItem:nil andIndex:indexPath.row + 1];
    cell.delegate = self;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
            NSLog(@"More button was pressed");
            break;
        case 1:
        {
          
            break;
        }
        default:
            break;
    }
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
