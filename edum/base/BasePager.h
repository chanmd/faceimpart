//
//  BasePager.h
//  gwlx
//
//  Created by Chan Kevin on 18/8/2016.
//  Copyright © 2016 Kevin Chan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BasePager : NSObject

@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, assign) NSInteger total;

- (id)initWithNumber:(int)number Size:(int)size;
- (void)addpage;
- (NSDictionary *)output;
- (BOOL)can_load_more;

@end
