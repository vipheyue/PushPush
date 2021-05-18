//
//  ConfigViewController.m
//  Pushpush
//
//  Created by YC X on 2021/5/13.
//

#import "ConfigViewController.h"
#import <SVProgressHUD.h>

@interface ConfigViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *linkButton;

@end

@implementation ConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.model.acceptTime) {
        self.title = self.model.acceptTime;
        self.linkButton.hidden = YES;
        self.textView.text = self.model.contentMsg;
        self.textView.editable = NO;
    }
}

- (IBAction)buttonEvent:(UIButton *)sender {
    
    if (self.textView.text.length && [[NSUserDefaults.standardUserDefaults objectForKey:@"PushKey"] length]) {
        UIPasteboard *pab = [UIPasteboard generalPasteboard];
        pab.string = [NSString stringWithFormat:@"http://s.welightworld.com:8083/push/%@?send=%@", [NSUserDefaults.standardUserDefaults objectForKey:@"PushKey"], self.textView.text];
        if (pab) {
            NSLog(@"复制成功");
            [SVProgressHUD showImage:nil status:@"生成链接成功，已复制"];
            [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.3]];
            [SVProgressHUD dismissWithDelay:2];
            
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
