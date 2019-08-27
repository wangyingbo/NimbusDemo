//
//  FBOverdueCostomerListCellObject.m
//  FengbangB
//
//  Created by fengbang on 2019/5/9.
//  Copyright © 2019 com.fengbangstore. All rights reserved.
//

#import "FBNameContentCellObject.h"
#import "FBNameContentCell.h"

@implementation FBNameContentCellObject

+ (FBNameContentCellObject *)tableViewCellObject {
    return [FBNameContentCellObject objectWithCellClass:[FBNameContentCell class]];
}

@end
