//
//  ViewController.m
//  Pushpush
//
//  Created by YC X on 2021/4/26.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *devToken;

@end

@implementation ViewController

- (IBAction)touchEv:(UIButton *)sender {
    NSURL *url = [NSURL URLWithString:@"App-Prefs:root=Wallpaper"];
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
            NSLog(@"%d", success);
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self performSelector:@selector(tokenEvent) withObject:nil afterDelay:3];
}

- (void)tokenEvent
{
    self.devToken.text = [NSUserDefaults.standardUserDefaults objectForKey:@"PushKey"];

}

@end
