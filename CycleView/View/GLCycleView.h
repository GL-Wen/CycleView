//
//  GLCycleView.h
//  GLCycleView
//
//  Created by 温国良 on 2016/10/28.
//  Copyright © 2016年 温国良. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GLCycleView;
@protocol GLCycleViewDelegate <NSObject>
@optional

/**
 当前视图点击触发
 */
- (void)cycleViewView:(GLCycleView *)view didSelectIndex:(NSUInteger)index;

@end

@protocol GLCycleViewDataSource <NSObject>
@required

/**
 内容视图总数量
 */
- (NSUInteger)cycleViewViewContentCount:(GLCycleView *)view;

/**
 根据索引创建内容视图
 */
- (UIView *)cycleViewView:(GLCycleView *)view contentViewWithIndex:(NSUInteger)index;

@end

@interface GLCycleView : UIView

@property (nonatomic, weak) id<GLCycleViewDelegate> delegate;
@property (nonatomic, weak) id<GLCycleViewDataSource> dataSource;

/**
 视图间距,默认为10
 */
@property (nonatomic, assign) CGFloat margin;

/**
 是否可以滑动,默认YES
 */
@property (nonatomic, assign) BOOL isCanScroll;

/**
 刷新内容视图,索引默认为0
 */
- (void)reloadData;

/**
 根据索引刷新内容视图
 */
- (void)reloadDataWithIndex:(NSUInteger)index;

@end
