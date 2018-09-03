//
//  ZXWaterFallController.m
//  testWaterFall
//
//  Created by xu zhao on 2018/8/13.
//  Copyright © 2018年 xu zhao. All rights reserved.
//

#import "ZXWaterFallController.h"
#import "NSObject+YYModel.h"
#import "UIView+YYAdd.h"
#import "ZXWaterFallLayout.h"
#import "ZXWaterFallCell.h"
#import "UIColor+YYAdd.h"

@interface ZXWaterFallController ()<ZXWaterFallLayoutDelegate, UICollectionViewDataSource, UICollectionViewDelegate, ZXWaterFallLayoutDelegate>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UICollectionView *mainWaterFall;
@property (nonatomic, strong) ZXWaterFallLayout *fallLayout;

@end

@implementation ZXWaterFallController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareData];
    self.fallLayout = [[ZXWaterFallLayout alloc]init];
    self.fallLayout.delegate = self;
    self.fallLayout.cellWidth = (self.view.width - 30) * 0.5;
    self.fallLayout.edgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
    self.fallLayout.lineInterval = 10;
    self.fallLayout.columnInterval = 10;
    self.mainWaterFall = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64) collectionViewLayout:self.fallLayout];
    self.mainWaterFall.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    if (@available(iOS 11.0, *)) {
        self.mainWaterFall.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.mainWaterFall.delegate = self;
    self.mainWaterFall.dataSource = self;
    [self.mainWaterFall registerClass:[ZXWaterFallCell class] forCellWithReuseIdentifier:@"ZXWaterFallCellIdentifier"];
    [self.view addSubview:self.mainWaterFall];
}

- (void)prepareData{
    NSArray *data = [NSArray arrayWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"]];
    self.dataArray = [NSArray modelArrayWithClass:[dataModel class] json:data];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZXWaterFallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZXWaterFallCellIdentifier" forIndexPath:indexPath];
    
    cell.data = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - ZXWaterFallLayoutDelegate
- (CGFloat)cellhegihtAtIndexPath:(NSIndexPath *)indexPath{
    
    dataModel *model = [self.dataArray objectAtIndex:indexPath.row];
    CGFloat imageHeight = (self.mainWaterFall.width - 30) * 0.5;
    CGFloat maintitleLength = [self getLengthWithFontSize:14 string:model.title1];
    imageHeight = imageHeight + 10;
    
    CGFloat imageWidth = (self.mainWaterFall.width - 30) * 0.5;
    if (maintitleLength > (imageWidth - 20)) {
        imageHeight = imageHeight + 37.5;
    }
    else{
        imageHeight = imageHeight + 17;
    }
    imageHeight = imageHeight + 10;
    
    CGFloat subtitleLength = [self getLengthWithFontSize:12 string:model.title2];
    if (subtitleLength > (imageWidth - 20)) {
         imageHeight = imageHeight + 32.5;
    }
    else{
        imageHeight = imageHeight + 14.5;
    }
    
    imageHeight = imageHeight + 10 + 20 + 10;
    
    return imageHeight;
}

- (float)getLengthWithFontSize:(float)size string:(NSString *)string
{
    NSDictionary *attributes = @{
                                 NSFontAttributeName : [UIFont systemFontOfSize:size],
                                 };
    CGSize textSize = [string sizeWithAttributes:attributes];
    return textSize.width;
}

@end
