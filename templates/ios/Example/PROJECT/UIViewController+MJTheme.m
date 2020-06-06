//
//  UIViewController+MJTheme.m
//  ManJi
//
//  Created by manjiwang on 2019/1/7.
//  Copyright © 2019 Zgmanhui. All rights reserved.
//

#import "UIViewController+MJTheme.h"
#import <Aspects/Aspects.h>
#import <objc/runtime.h>

@implementation UIViewController (MJTheme)


+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *selStringsArray = @[@"viewDidLoad", @"viewWillAppear:", @"viewDidAppear:", @"viewWillDisappear:", @"viewDidDisappear:"];
        [selStringsArray enumerateObjectsUsingBlock:^(NSString *selString, NSUInteger idx, BOOL *stop) {
            NSString *leeSelString = [@"mj_" stringByAppendingString:selString];
            Method originalMethod = class_getInstanceMethod(self, NSSelectorFromString(selString));
            Method leeMethod = class_getInstanceMethod(self, NSSelectorFromString(leeSelString));
            method_exchangeImplementations(originalMethod, leeMethod);
        }];
    });
}

- (UIModalPresentationStyle)modalPresentationStyle {
    return UIModalPresentationFullScreen;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (@available(iOS 13.0,*)) {
        return UIStatusBarStyleDarkContent;
    }
    return UIStatusBarStyleDefault;
}

- (UIUserInterfaceStyle)overrideUserInterfaceStyle {
    return UIUserInterfaceStyleLight;
}


- (void)mj_viewDidLoad {
    NSLog(@"%@", NSStringFromClass([self class]));
    if (![self isWhiteListViewController]) {
        [self mj_viewDidLoad];
        return;
    }
    self.isFirstIn = YES;
    __weak typeof(self) wself = self;
    [self.navigationController aspect_hookSelector:@selector(setNavigationBarHidden:animated:) withOptions:AspectPositionAfter usingBlock:^{
        if (wself.isFirstIn) {
            wself.navigationBarHidden = wself.navigationController.navigationBarHidden;
        }
    } error:nil];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self mj_viewDidLoad];
}

- (void)mj_viewWillAppear:(BOOL)animated {
    NSLog(@"%s  %@", __func__,  NSStringFromClass([self class]));
    if (![self isWhiteListViewController]) {
        [self mj_viewDidLoad];
        return;
    }
    if(self.isFirstIn){
        self.isFirstIn = NO;
        [self.navigationController setNavigationBarHidden:self.navigationBarHidden animated:NO];
    }else{
        [self.navigationController setNavigationBarHidden:self.navigationBarHidden animated:YES];
    }
    if (self.navigationController.viewControllers.count > 1 && !self.navigationItem.hidesBackButton) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_icon_black"] style:UIBarButtonItemStylePlain target:self action:@selector(viewWillBack)];
    }else if(self.navigationItem.hidesBackButton){
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 1)]];
    }
    
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if (@available(iOS 13.0,*)) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDarkContent];
    }else {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
    [self mj_viewWillAppear:animated];
}

- (void)mj_viewDidAppear:(BOOL)animated {
    NSLog(@"%s  %@", __func__,  NSStringFromClass([self class]));
    if (![self isWhiteListViewController]) {
        [self mj_viewDidLoad];
        return;
    }
    [self mj_viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    //打开侧滑返回
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    }
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)mj_viewWillDisappear:(BOOL)animated {
    if (![self isWhiteListViewController]) {
        [self mj_viewDidLoad];
        return;
    }
    [self mj_viewWillDisappear:animated];
    if (self.navigationController.viewControllers.count > 1 && [self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

- (void)mj_viewDidDisappear:(BOOL)animated {
    [self mj_viewWillDisappear:animated];
}


- (void)viewWillBack {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    NSLog(@"gestureRecognizer:%@", NSStringFromClass(gestureRecognizer.view.class));
    if (gestureRecognizer == self.navigationController.interactivePopGestureRecognizer) {
        // 屏蔽调用rootViewController的滑动返回手势
        if (self.navigationController.viewControllers.count < 2 || self.navigationController.visibleViewController == [self.navigationController.viewControllers objectAtIndex:0]) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([NSStringFromClass(gestureRecognizer.view.class) isEqual:@"UILayoutContainerView"] && [NSStringFromClass(otherGestureRecognizer.view.class) isEqual:@"JXPagerListContainerCollectionView"]) {
        return YES;
    }
    return NO;
}

- (BOOL)isFirstIn {
    return self ? [objc_getAssociatedObject(self, _cmd) boolValue] : NO;
}

- (void)setIsFirstIn:(BOOL)isFirstIn {
    if (self) objc_setAssociatedObject(self, @selector(isFirstIn), @(isFirstIn) , OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)navigationBarHidden {
    return self ? [objc_getAssociatedObject(self, _cmd) boolValue] : NO;
}

- (void)setNavigationBarHidden:(BOOL)navigationBarHidden {
    if (self) objc_setAssociatedObject(self, @selector(navigationBarHidden), @(navigationBarHidden) , OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)isWhiteListViewController {
    NSArray * blackList = @[@"MJShopDetailIndexContentViewController"];
    for (NSString *key in blackList) {
        if ([self isKindOfClass:NSClassFromString(key)]) {
            return NO;
        }
    }
    //这里默认前缀为”MJ“ 和 继承”BaseViewController“ 的控制器  或者特殊的就加入到白名单里
    NSArray * list = @[@"ChatViewController", @"MCMyCollectionViewController", @"XLConversationListViewController", @"TIMBlackDetailViewController", @"TIMBlackListTableViewController"];
    for (NSString *key in list) {
        if ([self isKindOfClass:NSClassFromString(key)]) {
            return YES;
        }
    }
    NSString *className = NSStringFromClass([self class]);
    if ([className hasPrefix:@"MJ"] || [self isKindOfClass:NSClassFromString(@"BaseViewController")] || [self isKindOfClass:NSClassFromString(@"BaseTableViewController")]) {
        return YES;
    }
    return NO;
}

@end
