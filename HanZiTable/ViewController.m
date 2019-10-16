//
//  ViewController.m
//  HanZiTable
//
//  Created by 轨迹 on 2019/10/16.
//  Copyright © 2019 轨迹. All rights reserved.
//

#import "ViewController.h"
#import "PYTableViewIndexModel.h"
#import "PYTableViewIndexManager.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;
@property (strong,nonatomic) NSMutableArray *sectionTitles;//头标题数组
@property (strong,nonatomic) NSMutableArray *contentArrs;//内容数组

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.sectionTitles = [[NSMutableArray alloc]initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"#", nil];
    
    NSArray *Arr = @[@"找",@"钱",@"孙",@"离",@"周",@"五",@"正",@"网",@"风",@"陈",@"出",@"为",@"讲",@"身",@"汗",@"样",@"住",@"亲",@"又",@"许",@"和",@"刘",@"是",@"张",@"空",@"苍",@"眼",@"话",@"祝",@"喂",@"套",@"江"];
    
    NSMutableArray *jsonArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 50; i++) {
        int one = arc4random()%32;
        int two = arc4random()%32;
        int three = arc4random()%32;
        
        PYTableViewIndexModel *model = [[PYTableViewIndexModel alloc]init];
        model.nickName = [NSString stringWithFormat:@"%@%@%@",Arr[one],Arr[two],Arr[three]];
        
        [jsonArray addObject:model];
    }
    
    self.contentArrs = [[NSMutableArray alloc]initWithArray:[PYTableViewIndexManager archiveNumbers:jsonArray]];
    
    for (int i = (int)self.contentArrs.count-1; i>=0; i--) {
        if ([self.contentArrs[i] count] == 0) {
            [self.sectionTitles removeObjectAtIndex:i];
            [self.contentArrs removeObjectAtIndex:i];
        }
    }
    
    [self.tableview reloadData];
    
    [self.view addSubview:self.tableview];
    
}
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        for (UIView *subview in [_tableview subviews]) { if ([subview isKindOfClass:NSClassFromString(@"UITableViewIndex")]) { [subview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"line.jpg"]]]; } }
    }
    return _tableview;
}

- (NSMutableArray *)sectionTitles{
    if (!_sectionTitles) {
        _sectionTitles = [[NSMutableArray alloc]init];
    }
    return _sectionTitles;
}

- (NSMutableArray *)contentArrs{
    if (!_contentArrs) {
        _contentArrs = [[NSMutableArray alloc]init];
    }
    return _contentArrs;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.contentArrs.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.contentArrs[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    PYTableViewIndexModel *model = self.contentArrs[indexPath.section][indexPath.row];
    cell.textLabel.text = model.nickName;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//点击索引跳转到相应位置
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    
    NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:index];
    
    if (![self.contentArrs[index] count]) {
        return 0;
        
    }else{
        
        [tableView scrollToRowAtIndexPath:selectIndexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
        
        return index;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

//分区标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
if ([self.contentArrs[section] count] == 0) {
return nil;
}else{
return [self.sectionTitles objectAtIndex:section];
}
}

//索引标题
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.sectionTitles;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
