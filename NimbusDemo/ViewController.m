//
//  ViewController.m
//  NimbusDemo
//
//  Created by fengbang on 2019/8/27.
//  Copyright © 2019 王颖博. All rights reserved.
//

#import "ViewController.h"
#import "NimbusModels.h"

#import "FBNameContentCellObject.h"
#import "UIAlertController+FB.h"

@interface ViewController ()<UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NITableViewActions *tableActions;
@property (nonatomic,strong) NITableViewModel *tableModel;

@end

@implementation ViewController

#pragma mark - override
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configNavigation];
    
    [self configTableView];
    
    [self configNimbusProfile];
    
    [self configData];
}

#pragma mark - configUI

- (void)configNavigation {
    self.title = @"demo";
}

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        tableView.separatorInset = UIEdgeInsetsMake(0.5, 14, 0, 0);
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
        tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10)];
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.01)];
        [self.view addSubview:tableView];
        
        _tableView = tableView;
    }
    return _tableView;
}

- (void)configTableView {
    [self.tableView class];
}

#pragma mark - configData

/**
 配置Nimbus
 */
- (void)configNimbusProfile {
    self.tableView.hidden = NO;
    _tableActions = [[NITableViewActions alloc]initWithTarget:self];
    _tableActions.tableViewCellSelectionStyle = UITableViewCellSelectionStyleNone;
}

/**
 配置数据源
 */
- (void)configData {
    NSMutableArray *mutArr = [NSMutableArray array];
    NSArray *dataArray = @[];
    
    FBNameContentCellObject *header = [FBNameContentCellObject tableViewCellObject];
    header.title = @"Nimbus用法";
    header.titleFont = [UIFont boldSystemFontOfSize:18.f];
    header.titleColor = [UIColor redColor];
    [mutArr addObject:header];
    
    for (int i = 0; i<3; i++) {
        FBNameContentCellObject *co = [FBNameContentCellObject tableViewCellObject];
        co.arrowShow = YES;
        co.title = [NSString stringWithFormat:@"第%d个cell",i];
        [mutArr addObject:co];
    }
    
    FBNameContentCellObject *titleLongCO = [FBNameContentCellObject tableViewCellObject];
    titleLongCO.titleWidth = [UIScreen mainScreen].bounds.size.width - 30;
    titleLongCO.title = @"除了此次着重介绍的Table-Action模型之外,其实NimbusKit还有很多值得使用的功能,如Launcher功能,Overview功能,实用且集成起来很简单";
    [mutArr addObject:titleLongCO];
    
    FBNameContentCellObject *cellLongText = [FBNameContentCellObject tableViewCellObject];
    cellLongText.arrowShow = NO;
    cellLongText.titleWidth = 100;
    cellLongText.title = @"NimbusKit是一组用于快速开发的iOS框架,是源自Facebook的著名框架Three20的替代者";
    cellLongText.content = @"包括下面几大类的功能： \n Attributed Label - 富文字Label \n Badge - 数字角标 \n Interapp - 应用间交互 \n Launcher - 类桌面启动器 \n Network Image - 网络图片下载显示 \n Photo Albums - 相册 \n Web Controller - 浏览器 \n Table Models - 表格数据模型 \n Overview - 直观方便的调试分析内嵌图形工具哈哈。";
    [mutArr addObject:cellLongText];
    
    FBNameContentCellObject *cellOther = [FBNameContentCellObject tableViewCellObject];
    cellOther.titleWidth = 180;
    cellOther.arrowShow = NO;
    cellOther.title = @"NimbusKit的Table-Modal-Action模型,NITableViewModel 接管了UITableView的dataSource,并用一种更简单直观的方式创建表格内容,只需要创建对应的tableContents即可生成表单,NITableViewActions 接管了UITableView的delegate,提供了NITableViewModel中已连接对象(attachToObject)对点击事件以block的方式进行响应";
    cellOther.content = @"在日常的开发中,nimbus默认提供了一些带控件的cell，t具体参考NIFormCellCatalog.h文件。单仅仅依靠NimbusKit自带的表单组件肯定是无法完全满足我们的需求的,所以自定义表单组件则是非常必要的功能,而在NimbusKit中自定义表单组件也是非常容易的。";
    [mutArr addObject:cellOther];
    
    
    for (id co in mutArr) {
        __weak typeof(self)weakSelf = self;
        [_tableActions attachToObject:co tapBlock:^BOOL(id object, id target, NSIndexPath *indexPath) {
            __strong typeof(weakSelf)self = weakSelf;
            
            FBNameContentCellObject *myCO = (FBNameContentCellObject *)object;
            UIAlertController.factory(UIAlertControllerStyleAlert)
            .addTitle(@"提示")
            .addMessage(myCO.title)
            .addAction(@"确定", ^(UIAlertAction * _Nonnull action) {
            })
            .addCancel(@"取消", ^(UIAlertAction * _Nonnull action) {
            })
            .alertShow();

            return YES;
        }];
    }
    
    //输入控件
    NITextInputFormElement *inputCO = [NITextInputFormElement textInputElementWithID:0 placeholderText:@"请输入一些测试文本" value:@"输入控件"];
    [mutArr addObject:inputCO];
    
    //switch控件
    NISwitchFormElement *switchCO = [NISwitchFormElement switchElementWithID:1 labelText:@"switch控件" value:YES];
    [mutArr addObject:switchCO];
    
    //slider
    NISliderFormElement *sliderCO = [NISliderFormElement sliderElementWithID:2 labelText:@"slider控件" value:1 minimumValue:.1 maximumValue:1];
    [mutArr addObject:sliderCO];
    
    //segment
    NISegmentedControlFormElement *segCO = [NISegmentedControlFormElement segmentedControlElementWithID:3 labelText:@"segment控件" segments:@[@"test1",@"test2",@"test3"] selectedIndex:1];
    [mutArr addObject:segCO];
    
    //picker
    NIDatePickerFormElement *pickerCO = [NIDatePickerFormElement datePickerElementWithID:4 labelText:@"picker控件" date:[NSDate date] datePickerMode:UIDatePickerModeTime];
    [mutArr addObject:pickerCO];
    
    
    
    dataArray = [mutArr copy];
    _tableModel = [[NITableViewModel alloc]initWithSectionedArray:dataArray delegate:(id)[NICellFactory class]];
    _tableView.dataSource = _tableModel;
    _tableView.delegate = [_tableActions forwardingTo:self];
    [_tableView reloadData];
}

#pragma mark - request

#pragma mark - actions

#pragma mark - delegate

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id cellObject = [_tableModel objectAtIndexPath:indexPath];
    Class cellClass = nil;
    
    if ([cellObject respondsToSelector:@selector(cellClass)]) {
        cellClass = [cellObject cellClass];
    }
    
    if ([cellClass respondsToSelector:@selector(heightForObject:atIndexPath:tableView:)]) {
        return [cellClass heightForObject:cellObject atIndexPath:indexPath tableView:tableView];
    }
    return tableView.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

@end
