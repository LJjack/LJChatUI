//
//  LJLoginController.m
//  LJChatView
//
//  Created by 刘俊杰 on 16/9/14.
//  Copyright © 2016年 刘俊杰. All rights reserved.
//

#import "LJLoginController.h"
#import "LJIMManager.h"
#import "LJMessageController.h"

@interface LJLoginController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indView;

@end

@implementation LJLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)clickLoginBtn:(UIButton *)sender {
    [self.indView startAnimating];
    LJIMLoginParam *loginParam = [LJIMLoginParam loginParamWithUserID:@"14672627101018" userToken:@"eJxFkFFPgzAQx78Lz0aPAi2Y*NAR3IbDGDcNPjUMilaU1rZuzMXvLmtYzL39fne5-93R26zWl5VSomGVZYFuvGsPvAuH*aCE5qxqLdcjRlGCAM5yx7URsj9x8CMfBQD-UjS8t6IVbs4PMUEYER-GiqcOI15HVWRP6TKVt2aBldbzWWwetoUSRpXx82NK6OZ*q-mKHmocfbX7D0pFRvUu7YqrOxlm77OfIKSLNfXzsgzkfj7kXf6SmSGlb2SZQ3FzXtZ0zN3o0pxyhjjGk7TikztOEogTgGDiVV3L794ye1DcPeX3DwuDV-8_"];
    NSLog(@"开始登陆");
   [[LJIMManager sharedInstance] loginIM:loginParam succ:^{
        NSLog(@"登录 成功");
       [self.indView stopAnimating];
       [self performSegueWithIdentifier:@"ChatMain" sender:self];
       
   } fail:^(NSInteger code, NSString *msg) {
       NSLog(@"登录 失败: code=%d err=%@", (int)code, msg);
   }];
    
}
- (IBAction)clickLogoutBtn:(UIButton *)sender {
    
    [[LJIMManager sharedInstance] logoutIM:^{
        NSLog(@"logout succ");
    } fail:^(NSInteger code, NSString *msg) {
        NSLog(@"logout fail: code=%d err=%@", (int)code, msg);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
