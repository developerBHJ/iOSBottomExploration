//
//  ExplorationListController.m
//  OCExploration
//
//  Created by hj B on 2021/9/11.
//  底层探索

#import "ExplorationListController.h"
#import "RuntimeExplorationViewController.h"

@interface ExplorationListModel : NSObject

@property (nonatomic, strong) NSNumber *sort;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *list;

@end

@implementation ExplorationListModel


@end

@interface ExplorationListController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ExplorationListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"底层探索";
}


- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"dataSource" ofType:@".json"];
        NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
        NSDictionary *sourceDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
        NSArray *list = sourceDic[@"data"];
        for (NSDictionary *itemDic in list) {
            ExplorationListModel *model = [[ExplorationListModel alloc]init];
            model.sort = itemDic[@"sort"];
            model.title = itemDic[@"title"];
            model.list = itemDic[@"list"];
            [_dataSource addObject:model];
        }
    }
    return _dataSource;
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataSource.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    ExplorationListModel *model = self.dataSource[section];
    return model.list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    ExplorationListModel *model = self.dataSource[indexPath.section];
    cell.textLabel.text = model.list[indexPath.row];
    cell.textLabel.textColor = [UIColor grayColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    ExplorationListModel *model = self.dataSource[section];
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, 50)];
    titleLabel.text = model.title;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:22 weight:UIFontWeightMedium];
    headView.backgroundColor = [UIColor whiteColor];
    [headView addSubview:titleLabel];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 49, kScreenWidth - 15, 1)];
    lineView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
    [headView addSubview:lineView];
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ExplorationListModel *model = self.dataSource[indexPath.section];
    NSInteger sort = [model.sort integerValue];
    switch (sort) {
        case 0:{
            RuntimeExplorationViewController *runtimeVC = [[RuntimeExplorationViewController alloc] init];
            runtimeVC.navigationItem.title = model.title;
            [self.navigationController pushViewController:runtimeVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */



@end
