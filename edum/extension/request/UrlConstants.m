//
//  UrlConstants.m
//  edum
//
//  Created by Kevin Chan on 30/12/2019.
//  Copyright © 2019 MD Chen. All rights reserved.
//

#import "UrlConstants.h"

@implementation UrlConstants

NSString *const BASE_URL = @"http://www.klavier.cn";
NSString *const BASE_PLATFORM = @"ios";
NSString *const BASE_VERSION = @"v0.0.1";

NSString *const REQUEST_SYSTEM_LOGIN = @"system/login";
NSString *const REQUEST_SYSTEM_LOGOUT = @"system/logout";

NSString *const REQUEST_USER_SENDCODE = @"user/sendCode";
NSString *const REQUEST_USER_LOGINPHONECODE = @"user/loginPhoneCode";

NSString *const REQUEST_LANDING_LIST = @"data/getHomeInfo";//首页列表
NSString *const REQUEST_LANDING_LIST_MORE = @"landing/list-more";//首页单个内容更多页面

NSString *const REQUEST_LANDING_COURSE = @"landing/course";//首页课程列表页面
NSString *const REQUEST_LANDING_TEACHER = @"landing/teacher";//首页老师列表页面
NSString *const REQUEST_LANDING_NEWS = @"landing/news";//新闻列表页

NSString *const REQUEST_COURSE_DETAIL = @"data/getCourseById";


NSString *const REQUEST_CALENDAR_LIST = @"calendar/list";//所有课程列表
NSString *const REQUEST_CALENDAR_WEEK = @"calendar/week";//课程一周列表
NSString *const REQUEST_CALENDAR_DETAIL = @"calendar/detail";//课程详情
NSString *const REQUEST_CALENDAR_ADD = @"calendar/add";//老师添加日历
NSString *const REQUEST_CALENDAR_COURSE = @"calendar/add-course";//学生选课

NSString *const REQUEST_PROFILE = @"profile/user";//个人信息查看编辑
NSString *const REQUEST_PROFILE_LIST = @"profile/list";//个人详情

@end
