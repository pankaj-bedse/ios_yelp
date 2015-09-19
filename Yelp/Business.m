//
//  Business.m
//  Yelp
//
//  Created by Pankaj Bedse on 9/16/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "Business.h"

@implementation Business

-(id)initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self) {
        self.imageUrl = dictionary[@"image_url"];
        self.name = dictionary[@"name"];
        self.ratingImageUrl = dictionary[@"rating_img_url"];
        self.numReviews = [dictionary[@"review_count"] integerValue];
        float milesPerMeter = 0.000621317;
        self.distance = [dictionary[@"distance"] integerValue] * milesPerMeter;
        
        NSDictionary *location = [dictionary valueForKey:@"location"];
        NSString *street = @"";
        if ([location valueForKey:@"address"]) {
            street = [location valueForKey:@"address"][0];
        }
//        NSString *street = [[location ? [[location valueForKey:@"address"] ? [location valueForKey:@"address"][0] : @""] : @""] ];
        
        NSString *city = @"";//[location ? [[location valueForKey:@"city"] ? [location valueForKey:@"city"] : @"" ]: @""];
        if ([location valueForKey:@"city"]) {
            city = [location valueForKey:@"city"];
        }
        self.address = [NSString stringWithFormat:@"%@,%@", street, city];
        
        NSArray *categories = dictionary[@"categories"];
        NSMutableArray *categoryNames = [NSMutableArray array];
        [categories enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [categoryNames addObject:obj[0]];
        }];
        self.categories = [categoryNames componentsJoinedByString:@", "];
    }
    return self;
}

+(NSArray *)businessWithDictionaris:(NSArray *)dictionaries
{
    NSMutableArray *businesses = [[NSMutableArray alloc]init];
    for (NSDictionary *dictionary in dictionaries) {
        Business *business = [[Business alloc]initWithDictionary:dictionary];
        [businesses addObject:business];
    }
    return businesses;
}

@end
