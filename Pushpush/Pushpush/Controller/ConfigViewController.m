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
@property (weak, nonatomic) IBOutlet UILabel *dispreLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightLayou;

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
        self.heightLayou.constant = self.view.frame.size.height-150;
        self.dispreLab.hidden = YES;
    }
}

- (IBAction)buttonEvent:(UIButton *)sender {
    
    if (self.textView.text.length && [[NSUserDefaults.standardUserDefaults objectForKey:@"PushKey"] length]) {
        
        NSString *urlStr = [NSString stringWithFormat:@"http://s.welightworld.com:8083/push/%@", [NSUserDefaults.standardUserDefaults objectForKey:@"PushKey"]];
        NSString *pramStr = [NSString stringWithFormat:@"send=%@", [self URLEncodedString:self.textView.text]];
        
        UIPasteboard *pab = [UIPasteboard generalPasteboard];
        pab.string = [NSString stringWithFormat:@"%@?%@", urlStr, pramStr];
        if (pab) {
            [SVProgressHUD showImage:nil status:@"已复制,您现在可以粘贴到自己的服务器上去请求"];
            [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.3]];
            [SVProgressHUD dismissWithDelay:2];
            
            [self pushEvent:urlStr withPram:pramStr];
        }
        else {
            NSLog(@"复制失败");
        }
    }
    else {
        NSLog(@"内容为空或者deviceToken为空");
    }
    
}

- (NSString *)URLEncodedString:(NSString *) unencodedString
{
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *encodeString = [unencodedString stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];

    return encodeString;
}

- (void)pushEvent:(NSString *) pushUrl withPram:(NSString *) pramStr
{
    NSURLSession *mySession = [NSURLSession sharedSession];
    NSURL *fullURL = [NSURL URLWithString:pushUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:fullURL cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval:7.0];
    request.HTTPMethod = @"POST" ;
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    request. HTTPBody = [pramStr dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionDataTask * task = [mySession dataTaskWithRequest :request completionHandler :^( NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 判断接口是否成功返回
        if (error) {
            // 接口访问失败
            NSLog(@"error:%@", error.localizedDescription);
        }
        else {
            // 接口访问成功
            NSLog(@"推送已发送");
        }
    }];
    [task resume ];
}

@end
