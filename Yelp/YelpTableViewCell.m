//
//  YelpTableViewCell.m
//  Yelp
//
//  Created by Pankaj Bedse on 9/16/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "YelpTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface YelpTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBig;

@property (weak, nonatomic) IBOutlet UIImageView *ratingViewImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *reviewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;


@end

@implementation YelpTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setBusiness:(Business *)business
{
    _business = business;
    self.nameLabel.text = _business.name;
    self.addressLabel.text = _business.address;
    self.categoryLabel.text = _business.categories;
    self.reviewsLabel.text = [NSString stringWithFormat:@"%ld reviews", _business.numReviews];
    self.distanceLabel.text = [NSString stringWithFormat:@"%0.2f mi", _business.distance];
    [self.imageViewBig setImageWithURL:[NSURL URLWithString:_business.imageUrl]];
    [self.ratingViewImage setImageWithURL:[NSURL URLWithString:_business.ratingImageUrl]];
    
}
@end
