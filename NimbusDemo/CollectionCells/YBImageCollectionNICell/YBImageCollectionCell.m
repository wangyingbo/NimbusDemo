//
//  YBImageCollectionCell.m
//  NimbusDemo
//
//  Created by fengbang on 2019/12/30.
//  Copyright © 2019 王颖博. All rights reserved.
//

#import "YBImageCollectionCell.h"
#import "YBImageCollectionCellObject.h"

@interface YBImageCollectionCell ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation YBImageCollectionCell

#pragma mark - overwrite

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.contentView.bounds;
    self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.contentView.frame) - 30, CGRectGetWidth(self.contentView.frame), 30.f);
}

#pragma mark - configUI

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.userInteractionEnabled = YES;
        _imageView.backgroundColor = [UIColor lightGrayColor];
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor redColor];
        titleLabel.font = [UIFont systemFontOfSize:14.];
        titleLabel.backgroundColor = [UIColor greenColor];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

- (void)setUI {
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.titleLabel];
}

#pragma mark - NICollectionViewCell
- (BOOL)shouldUpdateCellWithObject:(id)object {
    if (![object isKindOfClass:[YBImageCollectionCellObject class]]) {
        return YES;
    }
    YBImageCollectionCellObject *cellObject = (YBImageCollectionCellObject *)object;
    
    self.titleLabel.text = cellObject.title;
    
    return YES;
}

@end
