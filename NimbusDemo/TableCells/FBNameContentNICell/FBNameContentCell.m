//
//  FBOverdueCostomerListCell.m
//  FengbangB
//
//  Created by fengbang on 2019/5/9.
//  Copyright © 2019 com.fengbangstore. All rights reserved.
//

#import "FBNameContentCell.h"
#import "FBNameContentCellObject.h"
#import "NSString+FBAdditional.h"

@interface FBNameContentCell ()
@property (nonatomic, strong) FBNameContentCellObject *cellObject;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *arrowButton;
@end


/**默认的title宽*/
static CGFloat kDefaultLeftTitleWidth = 120.f;
static CGFloat _leftMargin = 14.f;
static CGFloat _arrow_w = 20;
/**默认的最小高度*/
static CGFloat kDefaultCellMinHeight = 50.f;


@implementation FBNameContentCell

#pragma mark - overwrite
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setSubViewsUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat titleW = self.cellObject.titleWidth>0?self.cellObject.titleWidth:kDefaultLeftTitleWidth;
    self.nameLabel.frame = CGRectMake(_leftMargin, 0, titleW, self.contentView.frame.size.height);
    
    if (self.cellObject.titleSpreadFull) {
        titleW = [UIScreen mainScreen].bounds.size.width - 2*_leftMargin;
    }
    CGFloat arrowX = [UIScreen mainScreen].bounds.size.width - (self.cellObject.arrowShow?_leftMargin/2:_leftMargin) -  (self.cellObject.arrowShow?_arrow_w:0);
    CGFloat contentW = arrowX - titleW - _leftMargin;
    if (self.cellObject.titleSpreadFull) {
        contentW = arrowX - kDefaultLeftTitleWidth - _leftMargin;
    }
    if (self.cellObject.contentSpreadFull) {
        contentW = arrowX - _leftMargin;
    }
    CGFloat contentX = CGRectGetMaxX(self.nameLabel.frame);
    if (self.cellObject.titleSpreadFull) {
        contentX = _leftMargin + kDefaultLeftTitleWidth;
    }
    if (self.cellObject.contentSpreadFull) {
        contentX = _leftMargin;
    }
    
    self.arrowButton.frame = CGRectMake(arrowX, self.contentView.frame.size.height/2 - _arrow_w/2, _arrow_w, _arrow_w);
    self.contentLabel.frame = CGRectMake(contentX, 0, contentW, self.contentView.frame.size.height);
}

#pragma mark - configUI
- (void)setSubViewsUI {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.numberOfLines = 0;
    nameLabel.lineBreakMode = NSLineBreakByCharWrapping;
    nameLabel.font = [UIFont systemFontOfSize:14.];
    nameLabel.text = @"";
    nameLabel.textColor = [UIColor darkTextColor];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    contentLabel.font = [UIFont systemFontOfSize:14.];
    contentLabel.text = @"";
    contentLabel.textColor = [UIColor darkTextColor];
    contentLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    UIButton *arrowButton = [[UIButton alloc] init];
    arrowButton.enabled = NO;
    [arrowButton setImage:[UIImage imageNamed:@"arrow_icon"] forState:UIControlStateNormal];
    [self.contentView addSubview:arrowButton];
    self.arrowButton = arrowButton;
}

#pragma mark - NICell
+(CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    FBNameContentCellObject *cellObject = (FBNameContentCellObject *)object;
    if (!cellObject) {
        return kDefaultCellMinHeight;
    }
    
    //如果设置了定高的cell高度
    if (cellObject.cellHeight>0) {
        return cellObject.cellHeight;
    }
    
    CGFloat titleW = cellObject.titleWidth>0?cellObject.titleWidth:kDefaultLeftTitleWidth;
    if (cellObject.titleSpreadFull) {
        titleW = [UIScreen mainScreen].bounds.size.width - 2*_leftMargin;
    }
    CGSize titleSize = [cellObject.title sizeWithFont:cellObject.titleFont?:[UIFont systemFontOfSize:14.] maxWidth:titleW];
    
    CGFloat arrowX = [UIScreen mainScreen].bounds.size.width - (cellObject.arrowShow?_leftMargin/2:_leftMargin) - (cellObject.arrowShow?_arrow_w:0);
    CGFloat contentW = arrowX - titleW - _leftMargin;
    if (cellObject.titleSpreadFull) {
        contentW = arrowX - kDefaultLeftTitleWidth - _leftMargin;
    }
    if (cellObject.contentSpreadFull) {
        contentW = arrowX - _leftMargin;
    }
    CGSize contentSize = [cellObject.content sizeWithFont:cellObject.contentFont?:[UIFont systemFontOfSize:14.] maxWidth:contentW];
    
    //取title和content的最大值，然后加margin(加margin是为了美观，使第一行和最后一行不至于贴着控件)
    CGFloat margin = 15.f;
    CGFloat maxValue = MAX(titleSize.height, contentSize.height) + margin;
    
    //如果设置了cell的最小高度
    if (cellObject.minCellHeight>0) {
        return MAX(maxValue, cellObject.minCellHeight);
    }
    
    return MAX(maxValue, kDefaultCellMinHeight);
}

-(BOOL)shouldUpdateCellWithObject:(id)object {
    FBNameContentCellObject *cellObject = (FBNameContentCellObject *)object;
    if (cellObject) {
        self.cellObject = cellObject;
    }
    if (cellObject.bgColor) {
        self.contentView.backgroundColor = cellObject.bgColor;
    }
    if (cellObject.titleColor) {
        self.nameLabel.textColor = cellObject.titleColor;
    }
    if (cellObject.contentColor) {
        self.contentLabel.textColor = cellObject.contentColor;
    }
    if (cellObject.titleFont) {
        self.nameLabel.font = cellObject.titleFont;
    }
    if (cellObject.contentFont) {
        self.contentLabel.font = cellObject.contentFont;
    }
    
    self.nameLabel.text = cellObject.title?:@"";
    self.contentLabel.text = cellObject.content?:@"";
    self.arrowButton.hidden = !cellObject.arrowShow;
    
    if (!UIEdgeInsetsEqualToEdgeInsets(cellObject.separatorInset,UIEdgeInsetsZero)) {
        self.separatorInset = cellObject.separatorInset;
    }
    
    return YES;
}

@end
