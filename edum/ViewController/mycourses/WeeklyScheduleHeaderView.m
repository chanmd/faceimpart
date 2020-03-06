//
//  WeeklyScheduleHeaderView.m
//  edum
//
//  Created by Kevin Chan on 12/2/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "WeeklyScheduleHeaderView.h"
#import "UIView+BFExtension.h"
#import "UIColor+ColorExtension.h"

#define HEADEVIEW_HEIGHT 140
#define WEEK_LABEL_WIDTH APPScreenWidth / 7
#define WEEK_LABLE_Y APPScreenWidthHalf + 10

@implementation WeeklyScheduleHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageview_header];
        [self addSubview:self.label_greet];
        [self addSubview:self.label_date];
    }
    return self;
}

- (UIImageView *)imageview_header
{
    if (!_imageview_header) {
        _imageview_header = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, APPScreenWidthHalf)];
        if ([[self show_time_message] isEqualToString:@"早上好"]) {
            _imageview_header.image = ImageNamed(@"am");
        } else if ([[self show_time_message] isEqualToString:@"下午好"]) {
            _imageview_header.image = ImageNamed(@"pm");
        } else if ([[self show_time_message] isEqualToString:@"晚上好"]) {
            _imageview_header.image = ImageNamed(@"night");
        }
    }
    return _imageview_header;
}

- (UILabel *)label_date
{
    if (!_label_date) {
        _label_date = [[UILabel alloc] initWithFrame:CGRectMake(15, APPScreenWidthHalf - 40, APPScreenWidth - 30, 30)];
        NSDateFormatter *formate = [[NSDateFormatter alloc] init];
        formate.dateFormat = @"yyyy年MM月";
        _label_date.text = [formate stringFromDate:[NSDate date]];
        _label_date.font = __fontthin(24);
        _label_date.textColor = __color_white;
    }
    return _label_date;
}

- (UILabel *)label_greet
{
    if (!_label_greet) {
        _label_greet = [[UILabel alloc] initWithFrame:CGRectMake(15, APPScreenWidthHalf - 30 - 30 - 20, APPScreenWidth - 30, 30)];
        _label_greet.text = [self show_time_message];
        _label_greet.font = __fontthin(24);
        _label_greet.textColor = __color_white;
    }
    return _label_greet;
}

-(NSString *)show_time_message
{
    // For calculating the current date
    NSDate *date = [NSDate date];

    // Make Date Formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh a EEEE"];

    // hh for hour mm for minutes and a will show you AM or PM
    NSString *str = [dateFormatter stringFromDate:date];
    // NSLog(@"%@", str);

    // Sperate str by space i.e. you will get time and AM/PM at index 0 and 1 respectively
    NSArray *array = [str componentsSeparatedByString:@" "];

    // Now you can check it by 12. If < 12 means Its morning > 12 means its evening or night

    NSString *message;
    NSString *timeInHour;
    NSString *am_pm;

    NSString *DayOfWeek;
    if (array.count>2)
    {
        // am pm case
        timeInHour = array[0];
        am_pm = array[1];
        DayOfWeek  = array[2];
    }
    else if (array.count>1)
    {
        // 24 hours case
        timeInHour = array[0];
        DayOfWeek = array[1];
    }

    if (am_pm)
    {

        if ([timeInHour integerValue]>=4 && [timeInHour integerValue]<=9 && [am_pm isEqualToString:@"AM"])
        {
            message = [NSString stringWithFormat:@"早上好"];
                    
        }
        else if (([timeInHour integerValue]>=10 && [timeInHour integerValue]!=12 && [am_pm isEqualToString:@"AM"]) || (([timeInHour integerValue]<4 || [timeInHour integerValue]==12) && [am_pm isEqualToString:@"PM"]))
        {
            message = [NSString stringWithFormat:@"下午好"];
                    }
        else if ([timeInHour integerValue]>=4 && [timeInHour integerValue]<=9 && [am_pm isEqualToString:@"PM"])
        {
            message = [NSString stringWithFormat:@"晚上好"];

        }
        else if (([timeInHour integerValue]>=10 && [timeInHour integerValue]!=12 && [am_pm isEqualToString:@"PM"]) || (([timeInHour integerValue]<4 || [timeInHour integerValue]==12) && [am_pm isEqualToString:@"AM"]))
        {
            message = [NSString stringWithFormat:@"晚上好"];
        }

    }
    else
    {
        if ([timeInHour integerValue]>=4 && [timeInHour integerValue]<10)
        {
            message = [NSString stringWithFormat:@"早上好"];

        }
        else if ([timeInHour integerValue]>=10 && [timeInHour integerValue]<16)
        {
            message = [NSString stringWithFormat:@"下午好"];

        }
        else if ([timeInHour integerValue]>=16 && [timeInHour integerValue]<22)
        {
            message = [NSString stringWithFormat:@"晚上好"];

        }
        else
        {
            message = [NSString stringWithFormat:@"晚上好"];

        }
    }
    return message;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
