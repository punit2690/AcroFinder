//
//  CustomTableViewCell.h
//  AcroFinder
//
//  Created by Punit Kulkarni on 11/5/15.
//  Copyright © 2015 Punit Kulkarni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AcronymSearchResult.h"
#import "WebServiceAPI.h"

@interface CustomTableViewCell : UITableViewCell

@property (nonatomic, strong) AcronymSearchResult *acronymSearchResult;
@property (nonatomic, assign) SEARCH_TYPE selectedSearchType;

@end
