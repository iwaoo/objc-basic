//
//  ViewController.m
//  Task2-1-13
//
//  Created by 新井岩生 on 2017/12/26.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "ViewController.h"
#import "SampleCollectionViewCell.h"
#import "SampleCollectionReusableView.h"

@interface ViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, retain) NSMutableArray *imageNameArray;
@property (nonatomic, retain) NSArray *titles;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // カスタマーcellを呼び込み
    UINib *cellNibFile = [UINib nibWithNibName:@"SampleCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellNibFile forCellWithReuseIdentifier:@"Cell"];
    // カスタマーheaderを呼び込み
    UINib *headerNibFile = [UINib nibWithNibName:@"SampleCollectionReusableView" bundle:nil];
    [self.collectionView registerNib:headerNibFile forSupplementaryViewOfKind:UICollectionElementKindSectionHeader      withReuseIdentifier:@"Title"];
    
    self.titles = @[
                @"Group1",
                @"Ggroup2",
                @"Ggroup3",
                @"Ggroup4",
                @"Ggroup5",
                ];
    self.imageNameArray = [NSMutableArray arrayWithArray: @[
                                                            @[@"image1",@"image2",],
                                                            @[@"image3",@"image4",],
                                                            @[@"image5",@"image6",],
                                                            @[@"image7",@"image8",],
                                                            @[@"image9",@"image10",]
                                                          ]];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.titles.count;
}

- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView
          viewForSupplementaryElementOfKind:(NSString *)kind
                                atIndexPath:(NSIndexPath *)indexPath {
    
    SampleCollectionReusableView *title = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Title" forIndexPath:indexPath];
    
    title.titleLabel.text = self.titles[indexPath.section];
    
    return title;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.imageNameArray[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SampleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    UIImage *image = [UIImage imageNamed:self.imageNameArray[indexPath.section][indexPath.row]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    CGRect rect = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    imageView.frame = rect;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [cell.contentView addSubview:imageView];
    return cell;
}

// セルの大きさを指定
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat CellSize = self.collectionView.bounds.size.width/2.5;
    CGSize size = CGSizeMake(CellSize, CellSize);
    return size;
}

@end

