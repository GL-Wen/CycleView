//
//  GLCycleCollectionViewCell.m
//  CycleView
//
//  Created by 温国良 on 2016/10/30.
//  Copyright © 2016年 温国良. All rights reserved.
//

#import "GLCycleCollectionViewCell.h"

@interface GLCycleCollectionViewCell ()

@property (nonatomic, strong) UILabel *indexLabel;

@end

@implementation GLCycleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.indexLabel];
    }
    return self;
}

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    self.indexLabel.text = @(indexPath.row).stringValue;
    [self.indexLabel sizeToFit];
}

- (UILabel *)indexLabel
{
    if (!_indexLabel) {
        _indexLabel = [UILabel new];
    }
    return _indexLabel;
}

@end
