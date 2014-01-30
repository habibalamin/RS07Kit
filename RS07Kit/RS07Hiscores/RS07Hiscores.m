//
//  RS07Hiscores.m
//  RS07Kit
//
//  Created by Habib A on 30/01/2014.
//  Copyright (c) 2014 alAmin Apps. All rights reserved.
//

#import "RS07Hiscores.h"

@implementation RS07Hiscores

+ (NSDictionary *)getHiscoresFor:(NSString *)user {
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://services.runescape.com/m=hiscore_oldschool/hiscorepersonal.ws"]];
	[request setHTTPMethod:@"POST"];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"RS07Kit - %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey]] forHTTPHeaderField:@"User-Agent"];
	// [request setValue:user forHTTPHeaderField:@"user1"]; // for some reason, this only works with NSURLConnection… I think? At any rate, it worked before, it doesn't now. I can't think of another difference between then and now, though there are probably many.
	[request setHTTPBody:[[NSString stringWithFormat:@"user1=%@", user] dataUsingEncoding:NSASCIIStringEncoding]];
	NSData *pageData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	
	NSString *regexString = @"(\\w+?)\\n"
	@"<\\/a><\\/td>\\n"
	@"<td align=\"right\">([0-9,]+?)<\\/td>\\n"
	@"<td align=\"right\">([0-9,]+?)<\\/td>\\n"
	@"<td align=\"right\">([0-9,]+?)<\\/td>";
	NSString *pageString = [[NSString alloc] initWithData:pageData encoding:NSUTF8StringEncoding];
	NSError *error = NULL;
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionUseUnixLineSeparators error:&error];
	NSArray *matches = [regex matchesInString:pageString options:0 range:NSMakeRange(0, [pageString length])];
	
	NSMutableDictionary *hiscores = [[NSMutableDictionary alloc] init];
	for (NSTextCheckingResult *match in matches) {
		NSString *skillName = [pageString substringWithRange:[match rangeAtIndex:1]];
		NSString *skillRank = [pageString substringWithRange:[match rangeAtIndex:2]];
		NSString *skillLevel = [pageString substringWithRange:[match rangeAtIndex:3]];
		NSString *skillXP = [pageString substringWithRange:[match rangeAtIndex:4]];
		
		NSMutableDictionary *skill = [[NSMutableDictionary alloc] init];
		
		[skill setValue:skillRank forKey:@"rank"];
		[skill setValue:skillLevel forKey:@"level"];
		[skill setValue:skillXP forKey:@"xp"];
		[hiscores setValue:skill forKey:skillName];
	}
	
	return [NSDictionary dictionaryWithDictionary:hiscores];
}

@end
