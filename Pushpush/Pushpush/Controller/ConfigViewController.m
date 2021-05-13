//
//  ConfigViewController.m
//  Pushpush
//
//  Created by YC X on 2021/5/13.
//

#import "ConfigViewController.h"

@interface ConfigViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)buttonEvent:(UIButton *)sender {
    
    if (self.textView.text.length && [[NSUserDefaults.standardUserDefaults objectForKey:@"PushKey"] length]) {
        UIPasteboard *pab = [UIPasteboard generalPasteboard];
        pab.string = [NSString stringWithFormat:@"http://s.welightworld.com:8083/push/%@?send=%@", [NSUserDefaults.standardUserDefaults objectForKey:@"PushKey"], self.textView.text];
        if (pab) {
            NSLog(@"复制成功");
            
        }
        else {
            NSLog(@"复制失败");
        }
    }
    else {
        NSLog(@"内容为空或者deviceToken为空");
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
