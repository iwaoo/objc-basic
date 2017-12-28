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
    @property (nonatomic, retain) NSArray *titles;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self arraySetUp];
    _titles = @[
                @"かわいい犬",
                @"美味しい食べ物",
                ];
}

- (void)arraySetUp {
    self.imageNameArray = [NSMutableArray arrayWithArray: @[
                                                            @[@"image1",@"image2",@"image3",@"image4",],
                                                            @[@"image5",@"image6",@"image7",@"image8"]
                                                          ]
                           ];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.titles.count;
}

// セルの数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.imageNameArray[section] count];
}

// セクション・タイトル
- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView
          viewForSupplementaryElementOfKind:(NSString *)kind
                                atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView* reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        // --- ヘッダ
        UICollectionReusableView* headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                  withReuseIdentifier:@"HeaderView"
                                                                                         forIndexPath:indexPath];
        UILabel *label = [headerView viewWithTag:1];
        label.text = _titles[indexPath.section];
        
        reusableview = headerView;
    }
    return reusableview;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // セルに画像を書き込む
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //[cell setBackgroundColor:[UIColor blueColor]];
    UIImage *image = [UIImage imageNamed:_imageNameArray[indexPath.section][indexPath.row]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    CGRect rect = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    imageView.frame = rect;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [cell.contentView addSubview:imageView];
    return cell;
}

@end
