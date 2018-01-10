//
//  ViewController.m
//  task2-4-8
//
//  Created by 新井岩生 on 2018/01/05.
//  Copyright © 2018年 新井岩生. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIDocumentInteractionControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic,strong) UIDocumentInteractionController *documetController;
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

//フォトライブラリを開く
- (IBAction)selectImageAction:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate =self;
    imagePicker.allowsEditing =YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:NO completion:nil];
}

// imageViewから写真をDocumentsに渡す。UIDocumentInteractionControllerでインスタグラム側に渡す。
- (IBAction)toInstagramAction:(id)sender {
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://app"];
    
    if([[UIApplication sharedApplication] canOpenURL:instagramURL])
    {
        NSString *documentDirectory=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *saveImagePath=[documentDirectory stringByAppendingPathComponent:@"Image.igo"];
        
        if (![UIImagePNGRepresentation(self.imageView.image) writeToFile:saveImagePath atomically:YES]) {
            NSLog(@"image save failed to path %@", saveImagePath);
            return;
        } else {

        }

        NSURL *fileURL = [NSURL fileURLWithPath:saveImagePath];
        self.documetController = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
        self.documetController.delegate = self;
        (self.documetController).UTI = @"com.instagram.exclusivegram";
        //インスタグラムを開くメニュー
        [self.documetController presentOpenInMenuFromRect:CGRectMake(0, 0, 320, 480) inView:self.view animated:YES];
    }
    else
    {
        NSLog (@"Instagram not found");
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    //フォトライブラリから選んだ写真をimageViewに書き込む
    self.imageView.image  =  info[UIImagePickerControllerEditedImage];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
