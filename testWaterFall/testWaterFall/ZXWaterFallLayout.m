//
//  ZXWaterFallLayout.m
//  testWaterFall
//
//  Created by xu zhao on 2018/8/13.
//  Copyright © 2018年 xu zhao. All rights reserved.
//

#import "ZXWaterFallLayout.h"

@interface ZXWaterFallLayout()

@property (nonatomic, strong) NSMutableArray *attributesArray;
@property (nonatomic, strong) NSMutableArray *heightArray;
@property (nonatomic, assign) CGFloat maxHeight;

@end

@implementation ZXWaterFallLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.attributesArray  = [NSMutableArray array];
        self.heightArray = [NSMutableArray array];
        self.maxHeight = 0;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds

{
    NSLog(@"==== %s ====", __func__);
    if (CGSizeEqualToSize(newBounds.size, self.collectionView.bounds.size)) {
        return NO;
    }
    return YES;
}

- (void)prepareLayout
{
    NSLog(@"==== %s ====", __func__);
    [super prepareLayout];
   
    [self.heightArray removeAllObjects];
    [self.heightArray addObjectsFromArray:@[@(self.edgeInset.top - self.lineInterval), @(self.edgeInset.top - self.lineInterval)]];
    
    [self.attributesArray removeAllObjects];
    // 计算item的attrs
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        @autoreleasepool { // 如果item数目过大容易造成内存峰值提高
            UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
            [self.attributesArray addObject:attrs];
        }
    }
    self.maxHeight =  [self maxYWithColumnHeightsArray:self.heightArray];
}

- (CGSize)collectionViewContentSize{
    return CGSizeMake(0, self.collectionView.contentInset.bottom + self.maxHeight);
}

- (CGFloat)maxYWithColumnHeightsArray:(NSArray *)array
{
    __block CGFloat maxY = 0;
    [self.heightArray enumerateObjectsUsingBlock:^(NSNumber  *_Nonnull heightNumber, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([heightNumber doubleValue] > maxY) {
            maxY = [heightNumber doubleValue] + self.edgeInset.bottom;
        }
    }];
    return maxY;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSLog(@"==== %s ====", __func__);
    return self.attributesArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"==== %s ====", __func__);

    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    __block NSUInteger minColumn = 0;
    __block CGFloat minHeight = MAXFLOAT;
    [self.heightArray enumerateObjectsUsingBlock:^(NSNumber  *_Nonnull height, NSUInteger index, BOOL * _Nonnull stop) { // 遍历找出最小高度的列
        CGFloat currentHeight = [height doubleValue];
        if (minHeight > currentHeight) {
            minHeight = currentHeight;
            minColumn = index;
        }
    }];
    
    CGFloat x = self.edgeInset.left + minColumn * self.cellWidth + minColumn * self.columnInterval;
    CGFloat y = minHeight + self.lineInterval;
    CGFloat height = [self.delegate cellhegihtAtIndexPath:indexPath];
    attribute.frame = CGRectMake(x, y, self.cellWidth, height);
    
    [self.heightArray replaceObjectAtIndex:minColumn withObject:@(y + height)];
    
    return attribute;
}

@end
