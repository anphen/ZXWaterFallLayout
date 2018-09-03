//
//  ZXWaterFallLayout.h
//  testWaterFall
//
//  Created by xu zhao on 2018/8/13.
//  Copyright © 2018年 xu zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZXWaterFallLayoutDelegate <NSObject>
@required
- (CGFloat)cellhegihtAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface ZXWaterFallLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<ZXWaterFallLayoutDelegate> delegate;
@property (nonatomic, assign) CGFloat cellWidth;

@property (nonatomic, assign) UIEdgeInsets edgeInset;
@property (nonatomic, assign) CGFloat lineInterval;
@property (nonatomic, assign) CGFloat columnInterval;

@end
