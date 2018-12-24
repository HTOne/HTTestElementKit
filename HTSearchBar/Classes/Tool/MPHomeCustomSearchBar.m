//
//  MPHomeCustomSearchBar.m
//  MPYS
//
//  Created by 万海堂 on 2018/9/19.
//  Copyright © 2018年 森特网. All rights reserved.
//

#import "MPHomeCustomSearchBar.h"

@implementation MPHomeCustomSearchBar

-(void)setAroundInsets:(UIEdgeInsets)aroundInsets {
    _aroundInsets = aroundInsets;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
     // view是searchBar中的唯一的直接子控件
    for (UIView *view in self.subviews) {
        // UISearchBarBackground与UISearchBarTextField是searchBar的间接子控件
        for (UIView *subV in view.subviews) {
            if (@available(iOS 11.0, *)) {
                [self setPositionAdjustment:UIOffsetMake((subV.frame.size.width- self.placeholderWidth)/2 - _aroundInsets.left - _aroundInsets.right, 0) forSearchBarIcon:UISearchBarIconSearch];
            }
             // 找到UISearchBarTextField
            if ([subV isKindOfClass:[UITextField class]]) {
                UITextField *field = (UITextField *)subV;
                subV.frame = CGRectMake(_aroundInsets.left, _aroundInsets.top, self.bounds.size.width - _aroundInsets.left - _aroundInsets.right, self.bounds.size.height - _aroundInsets.top - _aroundInsets.bottom);
                [field setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
                field.backgroundColor = [UIColor grayColor];
                field.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_searchBar"]];
                [field setBorderStyle:UITextBorderStyleNone];
            }
        }
    }

}

- (CGFloat)placeholderWidth {
   
    CGSize size = [self.placeholder boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    
    return size.width;
}

@end
