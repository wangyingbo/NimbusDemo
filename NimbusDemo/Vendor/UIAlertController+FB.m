//
//  UIAlertController+FB.m
//  FengbangB
//
//  Created by 王迎博 on 2019/6/5.
//  Copyright © 2019 wangyingbo. All rights reserved.
//

#import "UIAlertController+FB.h"
#import <objc/runtime.h>


/**私有类*/
@interface UIAlertController (YBPrivate)
@property (nonatomic, strong) UIWindow *alertWindow;
@end

@implementation UIAlertController (YBPrivate)
@dynamic alertWindow;

- (void)setAlertWindow:(UIWindow *)alertWindow {
    objc_setAssociatedObject(self, @selector(alertWindow), alertWindow, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIWindow *)alertWindow {
    return objc_getAssociatedObject(self, @selector(alertWindow));
}

@end



@implementation UIAlertController (FB)

@dynamic addTitle;
@dynamic addAction;
@dynamic addMessage;
@dynamic addTextField;
@dynamic showAnimated;
@dynamic configTitle;
@dynamic configMessage;
@dynamic configAction;

#pragma mark - associate


#pragma mark - 工厂创建
+ (FBAlertFactory)factory {
    return ^(UIAlertControllerStyle style) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:style];
        return alertController;
    };
}

+ (instancetype)alert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    return alertController;
}

+ (instancetype)alertSheet {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    return alertController;
}

#pragma mark - 简单添加
- (FBAlertPropertyTitle)addTitle {
    return ^( NSString * _Nullable title) {
        self.title = [NSString stringWithFormat:@"%@",title];;
        NSMutableAttributedString *titleAttriStr = [[NSMutableAttributedString alloc] initWithString:title?:@""];
        [titleAttriStr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor darkTextColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:18.],NSFontAttributeName, nil] range:NSMakeRange(0, titleAttriStr.length)];
        [self setValue:titleAttriStr forKey:@"attributedTitle"];
        return self;
    };
}

- (FBAlertPropertyMessage)addMessage {
    return ^( NSString * _Nullable message) {
        self.message = [NSString stringWithFormat:@"%@\n",message];
        NSMutableAttributedString *messageAttriStr = [[NSMutableAttributedString alloc] initWithString:message?:@""];
        [messageAttriStr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor darkTextColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:14.],NSFontAttributeName, nil] range:NSMakeRange(0, messageAttriStr.length)];
        [self setValue:messageAttriStr forKey:@"attributedMessage"];
        return self;
    };
}

- (FBAlertPropertyAction)addAction {
    return ^(NSString * _Nullable title, void(^handler)(UIAlertAction *action)) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:handler];
        [self addAction:action];
        return self;
    };
}

- (FBAlertPropertyAction)addDestructive {
    return ^(NSString * _Nullable title, void(^handler)(UIAlertAction *action)) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDestructive handler:handler];
        [self addAction:action];
        return self;
    };
}

- (FBAlertPropertyAction)addCancel {
    return ^(NSString * _Nullable title, void(^handler)(UIAlertAction *action)) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:title?:@"取消" style:UIAlertActionStyleCancel handler:handler];
        [self addAction:action];
        return self;
    };
}

- (FBAlertTextField)addTextField {
    return ^(void(^handler)(UITextField *textField)) {
        [self addTextFieldWithConfigurationHandler:handler];
        return self;
    };
}

#pragma mark - 可配置属性方法

- (FBAlertTitle)configTitle {
    return ^( NSString * _Nullable title,  UIFont * _Nullable font,  UIColor * _Nullable color) {
        self.title = [NSString stringWithFormat:@"%@",title];;
        NSMutableAttributedString *titleAttriStr = [[NSMutableAttributedString alloc] initWithString:title?:@""];
        [titleAttriStr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:color?:[UIColor darkTextColor],NSForegroundColorAttributeName,font?:[UIFont systemFontOfSize:18.],NSFontAttributeName, nil] range:NSMakeRange(0, titleAttriStr.length)];
        [self setValue:titleAttriStr forKey:@"attributedTitle"];
        return self;
    };
}

- (FBAlertMessage)configMessage {
    return ^( NSString * _Nullable message, UIFont * _Nullable font,  UIColor * _Nullable color) {
        self.message = [NSString stringWithFormat:@"%@\n",message];
        NSMutableAttributedString *messageAttriStr = [[NSMutableAttributedString alloc] initWithString:message?:@""];
        [messageAttriStr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:color?:[UIColor darkTextColor],NSForegroundColorAttributeName,font?:[UIFont systemFontOfSize:14.],NSFontAttributeName, nil] range:NSMakeRange(0, messageAttriStr.length)];
        [self setValue:messageAttriStr forKey:@"attributedMessage"];
        return self;
    };
}

- (FBAlertAction)configAction {
    return ^(NSString * _Nullable title,UIAlertActionStyle style, UIColor * _Nullable color, void(^handler)(UIAlertAction *action)) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:style handler:handler];
        if (color) {
            [action setValue:[UIColor orangeColor] forKey:@"_titleTextColor"];
        }
        [self addAction:action];
        return self;
    };
}

#pragma mark - 实例方法

- (instancetype)with {
    return self;
}

- (NSArray<UIAlertAction *> *)allActions {
    return self.actions;
}

- (NSArray<UITextField *> *)allTextFields {
    return self.textFields;
}

#pragma mark - show方法
- (void)show {
    [self show:YES];
}

- (FBAlertShowAnimated)showAnimated {
    return ^(BOOL animated) {
        [self show:animated];
    };
}

- (FBAlertShow)alertShow {
    return ^(void) {
        [self show:YES];
    };
}

- (void)show:(BOOL)animated {
    self.alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.alertWindow.rootViewController = [[UIViewController alloc] init];
    
    id<UIApplicationDelegate> delegate = [UIApplication sharedApplication].delegate;
    if ([delegate respondsToSelector:@selector(window)]) {
        self.alertWindow.tintColor = delegate.window.tintColor;
    }
    
    UIWindow *topWindow = [UIApplication sharedApplication].windows.lastObject;
    self.alertWindow.windowLevel = topWindow.windowLevel + 1;
    
    [self.alertWindow makeKeyAndVisible];
    [self.alertWindow.rootViewController presentViewController:self animated:animated completion:nil];
}

#pragma mark - override
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    self.alertWindow.hidden = YES;
    self.alertWindow = nil;
}

@end
