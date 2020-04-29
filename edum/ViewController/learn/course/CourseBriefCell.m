//
//  CourseBriefCell.m
//  edum
//
//  Created by Kevin Chan on 24/3/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "CourseBriefCell.h"
#import "UILabel+LineSpace.h"

@implementation CourseBriefCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self.contentView addSubview:self.label_title];
        [self.contentView addSubview:self.webView];
    }
    return self;
}

- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 200)];
    }
    return _webView;
}

- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, APPScreenWidth - 40, 32)];
        _label_title.font = __fontlight(16);
        _label_title.textColor = __color_font_subtitle;
        _label_title.numberOfLines = 0;
        _label_title.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _label_title;
}

- (void)bindCourseBrief:(NSDictionary *)data
{
//    self.label_title.width = APPScreenWidth - 40;
//    [self.label_title setText:[data objectForKey:@"remark"] lineSpacing:5];
//    [self.label_title sizeToFit];
    [self.webView loadHTMLString:[data objectForKey:@"remark"] baseURL:nil];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
