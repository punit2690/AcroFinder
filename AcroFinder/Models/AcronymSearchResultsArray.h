//
//  AcronymSearchResultsArray.h
//  AcroFinder
//
//  Created by Punit Kulkarni on 11/3/15.
//  Copyright © 2015 Punit Kulkarni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncNetworkRequestManager.h"
#import "WebServiceAPI.h"
#import "AcronymSearchResult.h"

@interface AcronymSearchResultsArray : NSObject<AsyncNetworkRequestManagerDelegate>

@property (nonatomic, strong) NSArray *resultsArray;
- (void)searchResultsOfType:(SEARCH_TYPE)searchType forQuery:(NSString *)searchQuery;

@end
