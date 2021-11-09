//
//  AppointmentCell.h
//  edum
//
//  Created by Kevin Chan on 9/4/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppointmentCell : BaseTableViewCell

@property (nonatomic, strong) UIButton *button_date;

- (void)bindAppointment:(NSDictionary *)data;
- (void)bindAppointmentButton:(NSInteger)status;

@end

NS_ASSUME_NONNULL_END
