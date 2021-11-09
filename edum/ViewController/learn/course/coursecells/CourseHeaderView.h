//
//  CourseHeaderView.h
//  edum
//
//  Created by Kevin Chan on 24/3/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+BFExtension.h"
#import "UIColor+ColorExtension.h"
#import "NSDictionary+JSONExtern.h"
#import "CourseHeadBox.h"

NS_ASSUME_NONNULL_BEGIN

@interface CourseHeaderView : UIView

@property (nonatomic, strong) UILabel *label_title;

@property (nonatomic, strong) UIView *view_box;
@property (nonatomic, strong) UIView *view_contact;

@property (nonatomic, strong) UILabel *label_subtitle;
@property (nonatomic, strong) UIButton *button_more;

@property (nonatomic, strong) CourseHeadBox *durationbox;
@property (nonatomic, strong) CourseHeadBox *intensitybox;
@property (nonatomic, strong) CourseHeadBox *calbox;

@property (nonatomic, strong) UIImageView *imageview_avatar;
@property (nonatomic, strong) UILabel *label_name;
@property (nonatomic, strong) UILabel *label_bio;

@property (nonatomic, strong) UIButton *button_teacher;

@property (nonatomic, strong) UIButton *button_follow;
@property (nonatomic, strong) UIView *view_border;
@property (nonatomic, strong) NSString *teacher_id;

typedef void (^Teacher_TouchUpInside_Block)(NSString *teacher_id);

typedef void (^ReadMore_Block)();

@property (nonatomic, copy) ReadMore_Block readmore_block;
@property (nonatomic, copy) Teacher_TouchUpInside_Block block;

- (void)bindCourseHeader:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
