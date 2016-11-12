# CycleView

循环滚动视图，使用简单方便：

#pragma mark - GLCycleViewDelegate
-(void)cycleViewView:(GLCycleView *)view didSelectIndex:(NSUInteger)index
{
    
}

#pragma mark - GLCycleViewDataSource

-(NSUInteger)cycleViewViewContentCount:(GLCycleView *)view
{
    return 3;
}

-(UIView *)cycleViewView:(GLCycleView *)view contentViewWithIndex:(NSUInteger)index
{
    UIView *contentView = [UIView new];
    if (0 == index % 3) {
        contentView.backgroundColor = [UIColor redColor];
    }
    else if (1 == index % 3) {
        contentView.backgroundColor = [UIColor greenColor];
    }
    else
    {
        contentView.backgroundColor = [UIColor blueColor];
    }
    
    UILabel *label = [UILabel new];
    label.text = [NSString stringWithFormat:@"这是第%@个视图",@(index).stringValue];
    [label sizeToFit];
    [contentView addSubview:label];
    
    CGPoint point = label.center;
    point.x = CGRectGetWidth(view.frame) / 2.;
    point.y = CGRectGetHeight(view.frame) / 2.;
    label.center = point;

    return contentView;
}

#pragma mark - Self

-(void)initView
{
    GLCycleView *cycleView = [[GLCycleView alloc] initWithFrame:CGRectMake(25, 100, self.view.frame.size.width - 50, 200)];
    cycleView.margin = 10;
    cycleView.dataSource = self;
    cycleView.delegate   = self;
    [self.view addSubview:cycleView];
}
