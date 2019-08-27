//
//  FBOverdueCostomerListCellObject.h
//  FengbangB
//
//  Created by fengbang on 2019/5/9.
//  Copyright © 2019 com.fengbangstore. All rights reserved.
//

#import "NICellFactory.h"
#import "NICellFactory.h"

NS_ASSUME_NONNULL_BEGIN

@interface FBNameContentCellObject : NICellObject

/**cell背景颜色*/
@property (nonatomic, strong) UIColor *bgColor;
/**左边文本内容*/
@property (nonatomic, copy) NSString *title;
/**右边文本内容*/
@property (nonatomic, copy) NSString *content;
/**左边label宽*/
@property (nonatomic, assign) CGFloat titleWidth;
/**cell高度，如果赋值，则直接返回此高度定值，不再根据文本内容计算*/
@property (nonatomic, assign) CGFloat cellHeight;
/**默认最小cell高度，如果内容大于此高度，则自适应高度*/
@property (nonatomic, assign) CGFloat minCellHeight;
/**是否隐藏右侧箭头*/
@property (nonatomic, assign) BOOL arrowShow;
/**title宽度是否占满cell宽度*/
@property (nonatomic, assign) BOOL titleSpreadFull;
/**content宽度是否占满cell宽度*/
@property (nonatomic, assign) BOOL contentSpreadFull;
/**分割线*/
@property (nonatomic, assign) UIEdgeInsets separatorInset;
/***/
@property (nonatomic, strong) UIColor *titleColor;
/***/
@property (nonatomic, strong) UIColor *contentColor;
/***/
@property (nonatomic, strong) UIFont *titleFont;
/***/
@property (nonatomic, strong) UIFont *contentFont;

+(FBNameContentCellObject *)tableViewCellObject;

@end

NS_ASSUME_NONNULL_END
