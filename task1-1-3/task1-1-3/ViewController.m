#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // if文
    BOOL answer = YES;
    if(answer==YES){
        NSLog(@"yes");
    }
    
    // if~else文
    NSInteger num = 5;
    if(num < 0){
        NSLog(@"message1");
    }else{
        NSLog(@"message2"); //こちらのみ実行される
    }
    
    // 三項演算子
    BOOL request = YES;
    NSLog(request ? @"Yes" : @"No");
    
    // for文
    NSDictionary *pc = @{@"mac":@"マック", @"windows":@"ウインドウズ"};
    for (id key in [pc keyEnumerator]) {
        NSLog(@"%@", [pc valueForKey:key]);
    }
    
    
    // 高速列挙構文
    NSArray *fruits = @[@"りんご", @"なし",@"みかん"];
    for(id s in fruits)
    {
        NSLog(@"%@",(NSString*)s);
    }
    
    NSDictionary *smartphone = @{@"iphone":@"アイフォーン", @"android":@"アンドロイド"};
    for (id key in [smartphone keyEnumerator]) {
        NSLog(@"%@", [smartphone valueForKey:key]);
    }
    
    // switch文
    NSInteger number = 2;
    switch (number) {
        case 1:
            NSLog(@"1");
            break;
        case 2:
            NSLog(@"2");
            break;
        default:
            NSLog(@"default");
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
