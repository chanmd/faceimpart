//
//  TeacherCalendarCell.m
//  edum
//
//  Created by Md Chen on 27/8/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "TeacherCalendarCell.h"

@implementation TeacherCalendarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.button_time];
        self.backgroundColor = __color_white;
    }
    return self;
}

- (UIButton *)button_time
{
    if (!_button_time) {
        _button_time = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_time.frame = CGRectMake(15, 15, APPScreenWidth - 30, 49);
        _button_time.layer.cornerRadius = 2;
        _button_time.layer.masksToBounds = YES;
//        _button_time.layer.borderColor = [__color_main CGColor];
//        _button_time.layer.borderWidth = 0.5f;
        [_button_time setTitleColor:__color_white forState:UIControlStateNormal];
        _button_time.layer.backgroundColor = [[UIColor colorWithHEX:0xeb5c4a Alpha:0.6] CGColor];
    }
    return _button_time;
}

- (void)bindTeacherCalendar:(NSDictionary *)data
{
    NSString *start_time_string = [data stringForKey:@"start_time"];
    NSString *end_time_string = [data stringForKey:@"end_time"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *start_time = [formatter dateFromString:start_time_string];
    NSDate *end_time = [formatter dateFromString:end_time_string];
    NSDateFormatter *short_formatter = [[NSDateFormatter alloc] init];
    [short_formatter setDateFormat:@"HH:mm"];
    NSString *time = [NSString stringWithFormat:@"%@ - %@", [short_formatter stringFromDate:start_time], [short_formatter stringFromDate:end_time]];
    [self.button_time setTitle:time forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
