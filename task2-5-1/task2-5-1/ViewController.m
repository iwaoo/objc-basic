//
//  ViewController.m
//  task2-5-1
//
//  Created by 新井岩生 on 2018/01/05.
//  Copyright © 2018年 新井岩生. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// メール送信処理完了時のイベント
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    switch (result)
    {
            // キャンセル
        case MFMailComposeResultCancelled:
            break;
            // 保存
        case MFMailComposeResultSaved:
            break;
            // 送信
        case MFMailComposeResultSent:
        {
            NSLog(@"送信に成功しました。");
            break;
        }
            // 送信失敗
        case MFMailComposeResultFailed:
        {
            NSLog(@"送信に失敗しました。");
            break;
        }
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendAction:(id)sender {
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
        mailPicker.mailComposeDelegate = self;
        [mailPicker setSubject:@"アプリからメール送信"];
        
        [mailPicker setMessageBody:@"ここに本文を入力してください。" isHTML:NO];
        
        [mailPicker setToRecipients:[ NSArray arrayWithObject:@"i.arai@st-ventures.jp" ]];
        
        [self presentViewController:mailPicker animated:TRUE completion:nil];
    }
    else
    {
        NSLog(@"This device cannot send email");
    }
}
@end
