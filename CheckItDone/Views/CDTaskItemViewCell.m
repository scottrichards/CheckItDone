//
//  CDItemViewCell.m
//  CheckItDone
//
//  Created by Scott Richards on 10/6/13.
//  Copyright (c) 2013 Scott Richards. All rights reserved.
//

#import "CDTaskItemViewCell.h"
#import "UICheckbox.h"
#import "CDTask.h"

@implementation CDTaskItemViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)awakeFromNib
{
    NSLog(@"awakeFromNib");
    
    [self.doneCheckbox setDelegate:self];
}

- (void)clickedCheckbox:(BOOL)boolValue 
{
    NSLog(@"clickedCheckbox: %@",boolValue ? @"ON" : @"OFF");
    [self.item setDone:boolValue];
}

@end
