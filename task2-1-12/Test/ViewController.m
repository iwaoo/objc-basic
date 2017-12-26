//
//  ViewController.m
//  Test
//
//  Created by 新井岩生 on 2017/12/16.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
    @property (nonatomic, retain) NSMutableArray *imageNameArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self arraySetUp];
}

- (void)arraySetUp {
    self.imageNameArray = [NSMutableArray arrayWithArray: @[@"image1",@"image2",@"image3",@"image4",@"image5",@"image6"]];
}

// セルの数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageNameArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // セルに画像を書き込む
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor blueColor]];
    UIImage *image = [UIImage imageNamed:_imageNameArray[indexPath.row]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    CGRect rect = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    imageView.frame = rect;
    [cell.contentView addSubview:imageView];
    return cell;
}

@end
