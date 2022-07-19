//
//  UrlConstants.m
//  edum
//
//  Created by Kevin Chan on 30/12/2019.
//  Copyright © 2019 MD Chen. All rights reserved.
//

#import "UrlConstants.h"

@implementation UrlConstants

//NSString *const BASE_URL = @"http://www.klavier.cn";
//NSString *const BASE_URL = @"http://192.168.109.24:8000";
NSString *const BASE_URL = @"http://192.168.31.75:8000";
//NSString *const BASE_URL = @"http://localhost:8000";
NSString *const BASE_PLATFORM = @"ios";
NSString *const BASE_VERSION = @"v0.0.1";

NSString *const REQUEST_SYSTEM_LOGIN = @"system/login";
NSString *const REQUEST_SYSTEM_LOGOUT = @"system/logout";

NSString *const REQUEST_USER_SENDCODE = @"user/sendCode";
NSString *const REQUEST_USER_LOGINPHONECODE = @"user/loginPhoneCode";

NSString *const REQUEST_LANDING_LIST = @"landing";//首页列表
NSString *const REQUEST_LANDING_COURSE = @"top_courses";//首页课程列表页面
NSString *const REQUEST_LANDING_TEACHER = @"top_teachers";//首页老师列表页面
NSString *const REQUEST_SEGMENT_COURSE = @"segment_courses";//首页课程列表页面
NSString *const REQUEST_SEGMENT_TEACHER = @"segment_teachers";//首页老师列表页面
NSString *const REQUEST_COURSE_SEARCH = @"searchcourse";


NSString *const REQUEST_TEACHER = @"teacher";
NSString *const REQUEST_COURSE = @"course";

NSString *const REQUEST_LANDING_NEWS = @"landing/news";//新闻列表页

NSString *const REQUEST_COURSE_DETAIL = @"getCourseById";


NSString *const REQUEST_CALENDAR_LIST = @"weekly_calendar";//课程列表

NSString *const REQUEST_CALENDAR_WEEK = @"calendar/week";//课程一周列表
NSString *const REQUEST_CALENDAR_DETAIL = @"calendar/detail";//课程详情
NSString *const REQUEST_CALENDAR_ADD = @"calendar/add";//老师添加日历
NSString *const REQUEST_CALENDAR_COURSE = @"calendar/add-course";//学生选课
NSString *const REQUEST_TEACHER_CALENDAR = @"teacher_calendar";

NSString *const REQUEST_USER_NOTIFICATION = @"notification";
NSString *const REQUEST_ALL_COURESE = @"all_courses";

NSString *const REQUEST_PROFILE = @"profile/user";//个人信息查看编辑
NSString *const REQUEST_PROFILE_LIST = @"profile/list";//个人详情

@end
