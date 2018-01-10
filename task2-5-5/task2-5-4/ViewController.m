//
//  ViewController.m
//  task2-5-4
//
//  Created by 新井岩生 on 2018/01/10.
//  Copyright © 2018年 新井岩生. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *filterBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property CIImage* ciImage;
@property CIFilter *cifilter ;
@property CIImage* filteredImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.filterBtn.hidden =YES;
}

- (IBAction)pickimageAction:(id)sender {
    if([UIImagePickerController
        isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing=YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }
}

- (IBAction)filteredImageAction:(id)sender {
    CIColor *coreColor = [[CIColor alloc] initWithColor:[UIColor redColor]];
    
    
    self.cifilter = [CIFilter filterWithName:@"CIColorMonochrome"
                               keysAndValues: kCIInputImageKey,self.ciImage,
                     @"inputColor", coreColor, @"inputIntensity", @2,nil];
    
    self.filteredImage = self.cifilter.outputImage;
    
    self.imageView.image = [UIImage imageWithCIImage:self.filteredImage];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    self.imageView.image  = [info valueForKey:UIImagePickerControllerEditedImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    self.filterBtn.hidden =NO;
    self.ciImage = [[CIImage alloc]initWithImage:self.imageView.image];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
