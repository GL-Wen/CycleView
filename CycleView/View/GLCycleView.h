//
//  TWStoreMapView.h
//  SuperCarMan
//
//  Created by 温国良 on 2016/10/28.
//  Copyright © 2016年 Toowell. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GLCycleView;
@protocol GLCycleViewDelegate <NSObject>
@optional

- (void)cycleViewView:(GLCycleView *)view didSelectIndex:(NSUInteger)index;

@end

@protocol GLCycleViewDataSource <NSObject>
@required

- (NSUInteger)cycleViewViewContentCount:(GLCycleView *)view;

- (UIView *)cycleViewView:(GLCycleView *)view contentViewWithIndex:(NSUInteger)index;

@end

@interface GLCycleView : UIView

@property (nonatomic, weak) id<GLCycleViewDelegate> delegate;
@property (nonatomic, weak) id<GLCycleViewDataSource> dataSource;

@property (nonatomic, assign) UIEdgeInsets contentEdgeInsets;

@property (nonatomic, assign) CGFloat margin;

- (void)reloadData;

@end
