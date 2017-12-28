//
//  ViewController.m
//  task2-1-12
//
//  Created by 新井岩生 on 2017/12/25.
//  Copyright © 2017年 新井岩生. All rights reserved.
//

#import "ViewController.h"
#import "SampleCollectionViewCell.h"

@interface ViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, retain) NSMutableArray *imageNameArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // xibの読み込み
    UINib *nib = [UINib nibWithNibName:@"SampleCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"Cell"];
    [self arraySetUp];
}

- (void)arraySetUp {
    self.imageNameArray = [NSMutableArray arrayWithArray: @[@"image1",@"image2",@"image3",@"image4",@"image5",@"image6",@"image7",@"image8",@"image9"]];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageNameArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SampleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.cellImageView.image = [UIImage imageNamed:self.imageNameArray[indexPath.row]];
    return cell;
}
// cellサイズとグリッド間の間隔を定義
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat CellSize = 0;
    CellSize = collectionView.bounds.size.width/4;
    CGSize size = CGSizeMake(CellSize, CellSize);
    
    return size;
}

@end
