//
//  UIAlertController+FB.h
//  FengbangB
//
//  Created by 王迎博 on 2019/6/5.
//  Copyright © 2019 com.wangyingbo. All rights reserved.
//
//  链式语法创建并调用UIAlertController

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef UIAlertController *_Nonnull(^FBAlertFactory)(UIAlertControllerStyle style);
typedef UIAlertController *_Nonnull(^FBAlertTitle)(NSString * _Nullable title, UIFont * _Nullable font,  UIColor * _Nullable color);
typedef UIAlertController *_Nonnull(^FBAlertMessage)(NSString * _Nullable message, UIFont * _Nullable font,  UIColor * _Nullable color);
typedef UIAlertController *_Nonnull(^FBAlertAction)(NSString * _Nullable title,UIAlertActionStyle style, UIColor * _Nullable color, void(^handler)(UIAlertAction *action));
typedef UIAlertController *_Nonnull(^FBAlertTextField)(void(^handler)(UITextField *textField));

typedef UIAlertController *_Nonnull(^FBAlertPropertyTitle)(NSString * _Nullable title);
typedef UIAlertController *_Nonnull(^FBAlertPropertyMessage)(NSString * _Nullable message);
typedef UIAlertController *_Nonnull(^FBAlertPropertyAction)(NSString * _Nullable title, void(^handler)(UIAlertAction *action));

typedef void(^FBAlertShow)(void);
typedef void(^FBAlertShowAnimated)(BOOL animated);


@interface UIAlertController (FB)

#pragma mark - 简单添加
/**添加title*/
@property (nonatomic, copy, readonly) FBAlertPropertyTitle addTitle;
/**添加message*/
@property (nonatomic, copy, readonly) FBAlertPropertyMessage addMessage;
/**添加action：UIAlertActionStyleDefault*/
@property (nonatomic, copy, readonly) FBAlertPropertyAction addAction;
/**添加action：UIAlertActionStyleDestructive*/
@property (nonatomic, copy, readonly) FBAlertPropertyAction addDestructive;
/**添加action：UIAlertActionStyleCancel*/
@property (nonatomic, copy, readonly) FBAlertPropertyAction addCancel;
/**添加输入框*/
@property (nonatomic, copy, readonly) FBAlertTextField addTextField;

#pragma mark - 可配置属性
/**添加title，可配置文字、字体、颜色*/
@property (nonatomic, copy, readonly) FBAlertTitle configTitle;
/**添加message，可配置文字、字体、颜色*/
@property (nonatomic, copy, readonly) FBAlertMessage configMessage;
/**添加action，可配置文字、风格、字体颜色*/
@property (nonatomic, copy, readonly) FBAlertAction configAction;

#pragma mark - show方法
/**直接弹出alertController*/
@property (nonatomic, copy, readonly) FBAlertShow alertShow;
/**弹出alertController，参数配置弹出时是否有动画*/
@property (nonatomic, copy, readonly) FBAlertShowAnimated showAnimated;

#pragma mark - 工厂创建
/**调用factory创建*/
@property (nonatomic, copy, class, readonly) FBAlertFactory factory;

/**
 创建UIAlertControllerStyleAlert风格（推荐使用链式语法factory创建，有代码联想）

 @return alertContrller
 */
+ (instancetype)alert;

/**
 创建UIAlertControllerStyleActionSheet风格（推荐使用链式语法factory创建，有代码联想）

 @return alertContrller
 */
+ (instancetype)alertSheet;

#pragma mark - 实例方法
/**
 语法链接

 @return self
 */
- (instancetype)with;

/**
 获取所有的actions

 @return array
 */
- (NSArray<UIAlertAction *> *)allActions;

/**
 获取添加的所有的textFields

 @return array
 */
- (NSArray<UITextField *> *)allTextFields;

/**
 show
 */
- (void)show;

/**
 show方法，可以设置动画

 @param animated 动画是否开启
 */
- (void)show:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
