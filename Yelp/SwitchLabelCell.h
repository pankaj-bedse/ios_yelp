//
//  SwitchLabelCell.h
//  Yelp
//
//  Created by Pankaj Bedse on 9/18/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SwitchLabelCell;

@protocol SwitchLabelCellDelegate <NSObject>

-(void)switchLabelCell:(SwitchLabelCell*) cell didUpdateValue:(BOOL)value;

@end

@interface SwitchLabelCell : UITableViewCell
@property (nonatomic, weak) id<SwitchLabelCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *switchLabel;
@property (nonatomic, assign) BOOL on;

-(void)setOn:(BOOL)on animated:(BOOL)animated;
@end
