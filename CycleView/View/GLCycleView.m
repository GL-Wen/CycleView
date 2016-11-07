//
//  TWStoreMapView.m
//  SuperCarMan
//
//  Created by 温国良 on 2016/10/28.
//  Copyright © 2016年 Toowell. All rights reserved.
//

#import "GLCycleView.h"
#import "GLCycleCollectionViewCell.h"

@interface GLCycleView ()

/*当前索引*/
@property (nonatomic, assign) NSUInteger index;

/*内容数量*/
@property (nonatomic, assign) NSUInteger contentCount;

@property (nonatomic, strong) UIView *leftContentView;
@property (nonatomic, strong) UIView *currentContentView;
@property (nonatomic, strong) UIView *rightContentView;

@property (nonatomic, assign) CGFloat startPointX;

@property (nonatomic, assign) CGPoint leftContentViewPoint;
@property (nonatomic, assign) CGPoint currentContentViewPoint;
@property (nonatomic, assign) CGPoint rightContentViewPoint;

@end

@implementation GLCycleView

#pragma mark - Super

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClickGesture:)]];
        [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panClickGesture:)]];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - Self

- (void)reloadData
{
    self.contentCount = [self.dataSource cycleViewViewContentCount:self];
    
    self.leftContentView = [self.dataSource cycleViewView:self contentViewWithIndex:[self requireIndexWithIndex:self.index - 1]];
    [self addSubview:self.leftContentView];
    
    self.currentContentView = [self.dataSource cycleViewView:self contentViewWithIndex:[self requireIndexWithIndex:self.index]];
    [self addSubview:self.currentContentView];
    
    self.rightContentView = [self.dataSource cycleViewView:self contentViewWithIndex:[self requireIndexWithIndex:self.index + 1]];
    [self addSubview:self.rightContentView];
    
    CGRect frame = self.leftContentView.frame;
    frame.origin.x    = -(CGRectGetWidth(self.frame) + self.margin);
    frame.size.width  = CGRectGetWidth(self.frame);
    frame.size.height = CGRectGetHeight(self.frame);
    self.leftContentView.frame = frame;
    
    frame = self.currentContentView.frame;
    frame.size.width  = CGRectGetWidth(self.frame);
    frame.size.height = CGRectGetHeight(self.frame);
    self.currentContentView.frame = frame;
    
    frame = self.rightContentView.frame;
    frame.origin.x    = CGRectGetWidth(self.frame) + self.margin;
    frame.size.width  = CGRectGetWidth(self.frame);
    frame.size.height = CGRectGetHeight(self.frame);
    self.rightContentView.frame = frame;
    
    self.leftContentViewPoint = self.leftContentView.layer.position;
    self.currentContentViewPoint = self.currentContentView.layer.position;
    self.rightContentViewPoint = self.rightContentView.layer.position;
}

- (NSUInteger)requireIndexWithIndex:(NSInteger)index
{
    NSInteger requireIndex = index;
    
    if (index < 0)
        requireIndex = self.contentCount - 1;
    else if (requireIndex >= self.contentCount)
        requireIndex = 0;
    
    return requireIndex;
}

- (void)updateContentViewPointX:(CGFloat)pointX
{
    CGPoint movePoint = self.currentContentView.layer.position;
    movePoint.x = pointX + self.leftContentViewPoint.x;
    self.currentContentView.layer.position = movePoint;
    
    movePoint = self.leftContentView.layer.position;
    movePoint.x = pointX + self.currentContentViewPoint.x;
    self.leftContentView.layer.position = movePoint;
    
    movePoint = self.rightContentView.layer.position;
    movePoint.x = pointX + self.rightContentViewPoint.x;
    self.rightContentView.layer.position = movePoint;
}

- (void)contentViewStopScrollPointX:(CGPoint)point
{
    if (point.x < -CGRectGetWidth(self.frame) / 2.) {
        NSLog(@"向左滑动");
        
        [self anmiationContentView:self.leftContentView position:self.leftContentViewPoint];
        [self anmiationContentView:self.currentContentView position:self.currentContentViewPoint];
        [self anmiationContentView:self.rightContentView position:self.rightContentViewPoint];
    }
    else if (point.x > CGRectGetWidth(self.frame) / 2.) {
        NSLog(@"向右滑动");
        
        
        
        [self anmiationContentView:self.leftContentView position:self.leftContentViewPoint];
        [self anmiationContentView:self.currentContentView position:self.currentContentViewPoint];
        [self anmiationContentView:self.rightContentView position:self.rightContentViewPoint];
    }
    else
    {
        NSLog(@"停留原处");
    }
}

-(void)anmiationContentView:(UIView *)view position:(CGPoint)position
{
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    [positionAnimation setFromValue:[NSValue valueWithCGPoint:view.layer.position]];
    [positionAnimation setToValue:[NSValue valueWithCGPoint:position]];
    
    CAAnimationGroup* group = [CAAnimationGroup animation];
    group.animations = @[positionAnimation];
    group.duration   = .5;
    [view.layer addAnimation:group forKey:nil];
    view.layer.position=position;
}

#pragma mark - UIGestureRecognizer

- (void)tapClickGesture:(UITapGestureRecognizer *)gesture
{
    
}

- (void)panClickGesture:(UIPanGestureRecognizer *)gesture
{
    NSLog(@">>>>>>>>>>>> = %@",gesture.view);
    
    CGPoint point = [gesture translationInView:self];
    NSLog(@"++++++++++++ = %@",NSStringFromCGPoint(point));
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.startPointX = point.x;
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            [self updateContentViewPointX:point.x];
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        {
            [self contentViewStopScrollPointX:point];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Set

- (void)setDataSource:(id<GLCycleViewDataSource>)dataSource
{
    _dataSource = dataSource;
    
    [self reloadData];
}

#pragma mark - Get

@end
