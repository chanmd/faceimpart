//
//  GuideGeneralCell.h
//  gwlx
//
//  Created by Kevin Chan on 25/10/2017.
//  Copyright © 2017 Kevin. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface GuideGeneralCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UILabel *label_subtitle;

@property (nonatomic, strong) UIView *view_border;

@end
