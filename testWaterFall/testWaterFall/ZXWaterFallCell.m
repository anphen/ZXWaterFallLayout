//
//  ZXWaterFallCell.m
//  testWaterFall
//
//  Created by xu zhao on 2018/8/13.
//  Copyright © 2018年 xu zhao. All rights reserved.
//

#import "ZXWaterFallCell.h"
#import "Masonry.h"

@implementation dataModel

@end

@interface ZXWaterFallCell()

@property (nonatomic, strong) UIImageView *mainImageView;
@property (nonatomic, strong) UILabel *mainTitle;
@property (nonatomic, strong) UILabel *subTitle;
@property (nonatomic, strong) UIImageView *headicon;
@property (nonatomic, strong) UILabel *nickNameLabel;
@property (nonatomic, strong) UIImageView *lookCountIcon;
@property (nonatomic, strong) UILabel *lookCountLabel;

@end

@implementation ZXWaterFallCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.mainImageView = [[UIImageView alloc]init];
        self.mainImageView.backgroundColor = [UIColor yellowColor];
        self.headicon = [[UIImageView alloc]init];
        self.headicon.backgroundColor = [UIColor blueColor];
        self.lookCountIcon = [[UIImageView alloc]init];
        self.lookCountIcon.backgroundColor = [UIColor greenColor];
        self.mainTitle = [[UILabel alloc]init];
        self.mainTitle.textAlignment = NSTextAlignmentLeft;
        self.mainTitle.font = [UIFont systemFontOfSize:14];
        self.mainTitle.lineBreakMode = NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail;
        self.mainTitle.numberOfLines = 2;
        self.subTitle = [[UILabel alloc]init];
        self.subTitle.textAlignment = NSTextAlignmentLeft;
        self.subTitle.lineBreakMode = NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail;
        self.subTitle.font = [UIFont systemFontOfSize:12];
        self.subTitle.numberOfLines = 2;
        self.nickNameLabel = [[UILabel alloc]init];
        self.nickNameLabel.font = [UIFont systemFontOfSize:10];
        self.nickNameLabel.textAlignment = NSTextAlignmentLeft;
        self.lookCountLabel = [[UILabel alloc]init];
        self.lookCountLabel.font = [UIFont systemFontOfSize:10];
        self.lookCountLabel.textAlignment = NSTextAlignmentRight;
        self.layer.cornerRadius = 8;
        self.clipsToBounds = YES;
        [self makeConstrait];
    }
    return self;
}

- (void)makeConstrait{
    [self.contentView addSubview:self.mainImageView];
    [self.contentView addSubview:self.mainTitle];
    [self.contentView addSubview:self.subTitle];
    [self.contentView addSubview:self.headicon];
    [self.contentView addSubview:self.nickNameLabel];
    [self.contentView addSubview:self.lookCountIcon];
    [self.contentView addSubview:self.lookCountLabel];
    [self.mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(self.mainImageView.mas_width);
    }];
    [self.mainTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mainImageView.mas_left).offset(10);
        make.right.mas_equalTo(self.mainImageView.mas_right).offset(-10);
        make.top.mas_equalTo(self.mainImageView.mas_bottom).offset(10);
    }];
    [self.subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mainTitle.mas_bottom).offset(10);
        make.left.mas_equalTo(self.mainImageView.mas_left).offset(10);
        make.right.mas_equalTo(self.mainImageView.mas_right).offset(-10);
    }];
    [self.headicon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.subTitle.mas_bottom).offset(10);
        make.left.mas_equalTo(self.subTitle.mas_left);
        make.height.width.mas_equalTo(20);
    }];
   
    [self.lookCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.subTitle.mas_right);
        make.centerY.mas_equalTo(self.headicon.mas_centerY);
    }];
    [self.lookCountLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self.lookCountIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headicon.mas_centerY);
        make.right.mas_equalTo(self.lookCountLabel.mas_left).offset(-5);
        make.height.mas_equalTo(10);
        make.width.mas_equalTo(14);
    }];
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headicon.mas_centerY);
        make.left.mas_equalTo(self.headicon.mas_right).mas_equalTo(10);
        make.right.mas_equalTo(self.lookCountIcon.mas_left).offset(-5);
    }];
}

- (void)setData:(dataModel *)data{
    _data = data;
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = 4;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    
    self.mainTitle.attributedText = [[NSAttributedString alloc] initWithString:data.title1 attributes:attributes];
    self.subTitle.attributedText = [[NSAttributedString alloc] initWithString:data.title2 attributes:attributes];
    
    self.nickNameLabel.text = data.name;
    self.lookCountLabel.text = data.count;
}

@end
