//
//  YBImageCollectionCellObject.m
//  NimbusDemo
//
//  Created by fengbang on 2019/12/30.
//  Copyright © 2019 王颖博. All rights reserved.
//

#import "YBImageCollectionCellObject.h"
#import "YBImageCollectionCell.h"


@implementation YBImageCollectionCellObject

+ (instancetype)collectionCellObject {
    return [YBImageCollectionCellObject objectWithCellClass:[YBImageCollectionCell class]];
}


@end
