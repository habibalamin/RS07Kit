//
//  RS07Prices.h
//  RS07Kit
//
//  Created by Habib A on 30/01/2014.
//  Copyright (c) 2014 alAmin Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RS07Prices : NSObject

+ (NSDictionary *)searchPriceGuideFor:(NSString *)keyword;
+ (NSDictionary *)getPriceDetailsFor:(NSString *)item;

@end
