//
//  YelpTableViewCell.h
//  Yelp
//
//  Created by Pankaj Bedse on 9/16/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Business.h"

@interface YelpTableViewCell : UITableViewCell

@property (nonatomic, strong) Business *business;

@end
