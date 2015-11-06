//
//  CustomTableViewCell.m
//  AcroFinder
//
//  Created by Punit Kulkarni on 11/5/15.
//  Copyright © 2015 Punit Kulkarni. All rights reserved.
//

#import "CustomTableViewCell.h"

@interface CustomTableViewCell()

@property (nonatomic, weak) IBOutlet UILabel *cellLabel;

@end

@implementation CustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setAcronymSearchResult:(AcronymSearchResult *)acronymSearchResult {
    _acronymSearchResult = acronymSearchResult;
    [self.cellLabel setText:(self.selectedSearchType == SHORTFORM_SEARCH)?self.acronymSearchResult.lf:self.acronymSearchResult.sf];
}
@end
