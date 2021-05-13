//
//  ViewController.m
//  Pushpush
//
//  Created by YC X on 2021/4/26.
//

#import "ViewController.h"
#import "MsgeTableViewCell.h"
//Key ID：HB5VG23TWC
//Team ID：7TM5U36L66
//Bundle ID：com.Pushpush1

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(MsgeTableViewCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(MsgeTableViewCell.class)];
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:@"2021年5月13日 23:00" forKey:@"time"];
        [dict setValue:@"服务器已经编译完成服务器已经编译完成服务器已经编译完成服务器已经编译完成服务器已经编译完成" forKey:@"content"];
        [_dataArray addObject:dict];
        [_dataArray addObject:dict];
        [_dataArray addObject:dict];


    }
    return _dataArray;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MsgeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(MsgeTableViewCell.class) forIndexPath:indexPath];
    if (self.dataArray.count > indexPath.row) {
        cell.timeLabel = self.dataArray[indexPath.row][@"time"];
        cell.contentLabel.text = self.dataArray[indexPath.row][@"content"];

    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

@end
