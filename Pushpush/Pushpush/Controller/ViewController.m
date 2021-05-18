//
//  ViewController.m
//  Pushpush
//
//  Created by YC X on 2021/4/26.
//

#import "ViewController.h"
#import "MsgeTableViewCell.h"
#import "ConfigViewController.h"

//Key ID：HB5VG23TWC
//Team ID：7TM5U36L66
//Bundle ID：com.Pushpush1

#import "RlmData.h"

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
    
    NSURL *groupURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.smsgroupExt"];
    NSURL *fileURL = [groupURL URLByAppendingPathComponent:@"push.realm"];
    
    RLMRealmConfiguration *config = [[RLMRealmConfiguration alloc] init];
    config.fileURL = fileURL;
    config.schemaVersion = 1.0;
    config.migrationBlock = ^(RLMMigration * _Nonnull migration, uint64_t oldSchemaVersion) {

    };
    RLMRealm *realm = [RLMRealm realmWithConfiguration:config error:nil];
    
    RLMResults *otherDogs = [RlmData allObjectsInRealm:realm]; // 从该 Realm 数据库中，检索所有狗狗
        
    for (RlmData *tanD in otherDogs) {
        NSLog(@"tand:%@", tanD);
        [self.dataArray addObject:tanD];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"PushPush";
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.title = @"";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MsgeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(MsgeTableViewCell.class) forIndexPath:indexPath];
    if (self.dataArray.count > indexPath.row) {

        RlmData *model = self.dataArray[self.dataArray.count - 1 - indexPath.row];
        cell.timeLabel.text = model.acceptTime;
        cell.contentLabel.text = model.contentMsg;

    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray.count > indexPath.row) {
        
        RlmData *model = self.dataArray[indexPath.row];
        ConfigViewController *configView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass(ConfigViewController.class)];
        configView.model = model;
        [self.navigationController pushViewController:configView animated:YES];
    }
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
