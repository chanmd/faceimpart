//
//  CategoryCell.h
//  gwlx
//
//  Created by Kevin Chan on 7/10/2016.
//  Copyright © 2016 Kevin. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface CategoryCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *imageview_cover;
@property (nonatomic, strong) UIView *view_shadow;
@property (nonatomic, strong) UILabel *label_title;

@end
