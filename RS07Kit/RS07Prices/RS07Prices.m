//
//  RS07Prices.m
//  RS07Kit
//
//  Created by Habib A on 30/01/2014.
//  Copyright (c) 2014 alAmin Apps. All rights reserved.
//

#import "RS07Prices.h"

@implementation RS07Prices

+ (NSDictionary *)priceSearchAPI:(NSString *)baseURL withQuery:(NSString *)keywordOrItemNameOrItemID {
	return [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[NSString stringWithFormat:baseURL, keywordOrItemNameOrItemID] stringByReplacingOccurrencesOfString:@" " withString:@"+"]]] options:NSJSONReadingMutableLeaves error:nil];
}

+ (NSDictionary *)searchPriceGuideFor:(NSString *)keyword {
	return [self priceSearchAPI:@"http://forums.zybez.net/runescape-2007-prices/api/%@" withQuery:keyword];
}

+ (NSDictionary *)getPriceDetailsFor:(NSString *)exactItemNameOrID {
	return [self priceSearchAPI:@"http://forums.zybez.net/runescape-2007-prices/api/item/%@" withQuery:exactItemNameOrID];
}

@end
