//
//  HostQuestionHeaderView.m
//  gwlx
//
//  Created by Kevin Chan on 28/6/2017.
//  Copyright © 2017 Kevin. All rights reserved.
//

#import "HostQuestionHeaderView.h"
#import "UIView+BFExtension.h"

@implementation HostQuestionHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.view_accessory];
        [self addSubview:self.label_title];
    }
    return self;
}

- (UIView *)view_accessory
{
    if (!_view_accessory) {
        _view_accessory = [[UIView alloc] initWithFrame:CGRectMake(0, 16, 4, 22)];
        _view_accessory.layer.cornerRadius = 1.f;
        _view_accessory.clipsToBounds = YES;
        _view_accessory.layer.backgroundColor = [__color_main CGColor];
    }
    return _view_accessory;
}

- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, APPScreenWidth - 30, 32)];
        _label_title.font = __fontlight(22);
        _label_title.textColor = __color_font_title;
    }
    return _label_title;
}

- (void)sample
{
//    HostQuestionHeaderView *view = (HostQuestionHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
//    if (!view) {
//        view = [[HostQuestionHeaderView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 52)];
//    }
//    NSString *question = [self.array_data_question objectAtIndex:section];
//    view.label_title.text = question;
//    return view;
}

@end
