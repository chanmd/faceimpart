//
//  CityCollectionViewController.h
//  gwlx
//
//  Created by Chan Kevin on 8/5/2016.
//  Copyright © 2016 Kevin Chan. All rights reserved.
//

#import "BaseViewController.h"

@interface CityCollectionViewController : BaseViewController

@property (nonatomic, strong) NSString *collection_id;
@property (nonatomic, strong) NSString *itinerary_id;
@property (nonatomic, strong) NSMutableArray *array_data;
@property (nonatomic, strong) NSDictionary *dict_info;

@end
