//
//  CourseHeaderView.m
//  edum
//
//  Created by Kevin Chan on 24/3/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "CourseHeaderView.h"
#import "UIView+BFExtension.h"
#import "UIColor+ColorExtension.h"
#import "NSDictionary+JSONExtern.h"

@implementation CourseHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.label_title];
        [self addSubview:self.label_price];
        [self addSubview:self.label_price_fake];
        [self addSubview:self.label_appiontment];
        [self addSubview:self.view_contact];
        [self addSubview:self.segmentedControl];
        UIView *splitview = [[UIView alloc] initWithFrame:CGRectMake(0, 184 + 40, APPScreenWidth, 0.5)];
        splitview.backgroundColor = __color_gray_separator;
        [self addSubview:splitview];
    }
    return self;
}

- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(15, 23, APPScreenWidth - 30, 30)];
        _label_title.font = __font(22);
        _label_title.textColor = __color_font_title;
        _label_title.numberOfLines = 0;
        _label_title.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _label_title;
}

- (UILabel *)label_price
{
    if (!_label_price) {
        _label_price = [[UILabel alloc] initWithFrame:CGRectMake(15, self.label_title.bottom + 15, 120, 30)];
        _label_price.textColor = __color_main;
        _label_price.font = __font(20);
    }
    return _label_price;
}

- (UILabel *)label_price_fake
{
    if (!_label_price_fake) {
        _label_price_fake = [[UILabel alloc] initWithFrame:CGRectMake(15 - 120, 68, 120, 20)];
        _label_price_fake.textColor = __color_font_subtitle;
        _label_price_fake.font = __font(16);
    }
    return _label_price_fake;
}

- (UILabel *)label_appiontment
{
    if (!_label_appiontment) {
        _label_appiontment = [[UILabel alloc] initWithFrame:CGRectMake(APPScreenWidth - 15 - 150, 68, 150, 20)];
        _label_appiontment.textAlignment = NSTextAlignmentRight;
        _label_appiontment.textColor = __color_font_subtitle;
        _label_appiontment.font = __font(12);
    }
    return _label_appiontment;
}

- (UIView *)view_contact
{
    if (!_view_contact) {
        _view_contact = [[UIView alloc] initWithFrame:CGRectMake(15, 100, APPScreenWidth - 30, 64)];
        _view_contact.backgroundColor = __color_gray_background;
        _view_contact.layer.masksToBounds = YES;
        _view_contact.layer.cornerRadius = 4.f;
        [_view_contact addSubview:self.imageview_avatar];
        [_view_contact addSubview:self.label_name];
        [_view_contact addSubview:self.label_bio];
    }
    return _view_contact;
}

- (UIImageView *)imageview_avatar
{
    if (!_imageview_avatar) {
        _imageview_avatar = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 34, 34)];
        _imageview_avatar.layer.masksToBounds = YES;
        _imageview_avatar.layer.cornerRadius = 17.f;
    }
    return _imageview_avatar;
}

- (UILabel *)label_name
{
    if (!_label_name) {
        _label_name = [[UILabel alloc] initWithFrame:CGRectMake(self.imageview_avatar.right + 10, 10, APPScreenWidth - 100, 18)];
        _label_name.font = __fontthin(14);
        _label_name.textColor = __color_font_title;
    }
    return _label_name;
}

- (UILabel *)label_bio
{
    if (!_label_bio) {
        _label_bio = [[UILabel alloc] initWithFrame:CGRectMake(self.imageview_avatar.right + 10, self.label_name.bottom, APPScreenWidth - 100, 18)];
        _label_bio.font = __fontthin(12);
        _label_bio.textColor = __color_font_placeholder;
    }
    return _label_bio;
}

- (HMSegmentedControl *)segmentedControl
{
    if(!_segmentedControl) {
        _segmentedControl = [[HMSegmentedControl alloc] init];
        _segmentedControl.sectionTitles = @[@"课程简介", @"课程目录"];
        _segmentedControl.frame = CGRectMake(15, 184, APPScreenWidth - 30, 40);
        _segmentedControl.backgroundColor = __color_white;
        _segmentedControl.selectionIndicatorHeight = 2.f;
        _segmentedControl.selectionIndicatorColor = __color_main;
        _segmentedControl.shouldAnimateUserSelection = YES;
        _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
        _segmentedControl.selectedSegmentIndex = 0;
        _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentedControl.selectedTitleTextAttributes = [NSDictionary dictionaryWithObjects:
                                                         [NSArray arrayWithObjects:__color_main, __fontthin(18), nil]
                                                                                    forKeys:
                                                         [NSArray arrayWithObjects:NSForegroundColorAttributeName, NSFontAttributeName, nil]];
        
        _segmentedControl.titleTextAttributes = [NSDictionary dictionaryWithObjects:
                                                 [NSArray arrayWithObjects:__color_font_title,
                                                  __fontthin(18), nil]
                                                                            forKeys:
                                                 [NSArray arrayWithObjects:NSForegroundColorAttributeName,NSFontAttributeName, nil]];
    }
    return _segmentedControl;
}

- (void)bindDict:(NSDictionary *)data
{
    self.label_price.text = [data stringForKey:@"price"];
    self.label_price_fake.text = [data stringForKey:@"price_fake"];
    self.label_appiontment.text = [NSString stringWithFormat:@"%@人已约课", [data stringForKey:@"order_count"]];
    self.label_appiontment.text = @"300人已约课";
    self.label_price.width = 100;
    self.label_price.text = @"¥3033";
    [self.label_price sizeToFit];
    self.label_price_fake.left = self.label_price.right + 5;
    
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:@"¥39999" attributes:attribtDic];
    self.label_price_fake.attributedText = attribtStr;
    self.label_price_fake.top = self.label_price.bottom - 20;
    self.label_appiontment.top = self.label_price.bottom - 20;
    
    [self.imageview_avatar sd_setImageWithURL:[NSURL URLWithString:[data stringForKey:@"url"]] placeholderImage:ImageNamed(@"logo_launch")];
    self.label_name.text = [data stringForKey:@"name"];
    self.label_bio.text = [data stringForKey:@"bio"];
    self.label_title.text = [data stringForKey:@"title"];
    
    self.label_title.text = @"钢琴课基础指法练习";
    self.label_title.width = APPScreenWidth - 30;
    [self.label_title sizeToFit];
    self.label_name.text = @"张天一";
    self.label_bio.text = @"钢琴家 教育家";
}

@end
