//
//  YBCollectionVC.m
//  NimbusDemo
//
//  Created by fengbang on 2019/12/30.
//  Copyright © 2019 王颖博. All rights reserved.
//


#import "NimbusCollections.h"

#import "YBCollectionVC.h"
#import "UIViewController+YBNaviAttributes.h"
#import "YBImageCollectionCellObject.h"
#import "UIAlertController+FB.h"


@interface YBCollectionVC ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic,strong) NICollectionViewActions *collectionActions;
@property (nonatomic,strong) NICollectionViewModel *collectionModel;

@end

@implementation YBCollectionVC

#pragma mark - override
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configNavigation];
    
    [self collectionView];
    
    [self configNimbusProfile];
    
    [self configNimbusCollectionData];
}

#pragma mark - configUI

- (void)configNavigation {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self yb_setTitleAttributesWithTitle:@"table nimbus" font:[UIFont systemFontOfSize:17.] color:[UIColor blackColor]];
}

- (UICollectionView *)collectionView
{
    if (_collectionView) { return _collectionView; }
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 20;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    layout.itemSize = CGSizeMake(100.f, 100.f);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.alwaysBounceVertical = YES;
    collectionView.scrollEnabled = YES;
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
    
    return _collectionView;
}

#pragma mark - configData


#pragma mark - nimbus
- (void)configNimbusProfile {
    _collectionActions = [[NICollectionViewActions alloc] initWithTarget:self];
}

- (void)configNimbusCollectionData {
    
    NSMutableArray *mutArray = [NSMutableArray array];
    for (int i = 0; i<10; i++) {
        YBImageCollectionCellObject *object = [YBImageCollectionCellObject collectionCellObject];
        object.title = [NSNumber numberWithInt:i].stringValue;
        [mutArray addObject:object];
        
        [self.collectionActions attachToObject:object tapBlock:^BOOL(id object, id target, NSIndexPath *indexPath) {
            YBImageCollectionCellObject *cellObject = (YBImageCollectionCellObject *)object;
            UIAlertController.factory(UIAlertControllerStyleAlert)
            .addTitle(cellObject.title)
            .addAction(@"确定", ^(UIAlertAction * _Nonnull action) {
                
            })
            .alertShow();
            return YES;
        }];
    }
    
    [mutArray addObject:[NICollectionViewModelFooter footerWithTitle:@"Footer"]];
    
    for (int i = 0; i<5; i++) {
        YBImageCollectionCellObject *object = [YBImageCollectionCellObject collectionCellObject];
        object.title = [NSNumber numberWithInt:i].stringValue;
        [mutArray addObject:object];
    }
    
    //_collectionModel = [[NICollectionViewModel alloc] initWithListArray:mutArray.copy delegate:(id)[NICollectionViewCellFactory class]];
    _collectionModel = [[NICollectionViewModel alloc] initWithSectionedArray:mutArray.copy delegate:(id)[NICollectionViewCellFactory class]];
    self.collectionView.dataSource = _collectionModel;
    self.collectionView.delegate = (id)_collectionActions;
    [self.collectionView reloadData];
}

#pragma mark - UITableViewDelegate


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat w = 50.f;
    return CGSizeMake(w, w);
}

@end
