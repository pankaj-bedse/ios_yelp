//
//  SwitchLabelCell.m
//  Yelp
//
//  Created by Pankaj Bedse on 9/18/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "SwitchLabelCell.h"

@interface SwitchLabelCell()
@property (weak, nonatomic) IBOutlet UISwitch *toggleSwitch;
- (IBAction)switchValueChanged:(id)sender;

@end

@implementation SwitchLabelCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setOn:(BOOL)on
{
    [self setOn:on animated:NO];
}
-(void)setOn:(BOOL)on animated:(BOOL)animated
{
    _on = on;
    [self.toggleSwitch setOn:on animated:animated];
}

- (IBAction)switchValueChanged:(id)sender {
    [self.delegate switchLabelCell:self didUpdateValue:self.toggleSwitch.on];
}
@end
