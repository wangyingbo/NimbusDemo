//
//  YBImageCollectionCellObject.h
//  NimbusDemo
//
//  Created by fengbang on 2019/12/30.
//  Copyright © 2019 王颖博. All rights reserved.
//

#import "NICollectionViewCellFactory.h"

NS_ASSUME_NONNULL_BEGIN

@interface YBImageCollectionCellObject : NICollectionViewCellObject

@property (nonatomic, copy) NSString *title;

+(instancetype)collectionCellObject;

@end

NS_ASSUME_NONNULL_END
