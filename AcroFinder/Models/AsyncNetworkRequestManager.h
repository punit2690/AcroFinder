//
//  AsyncNetworkRequestManager.h
//  AcroFinder
//
//  Created by Punit Kulkarni on 11/3/15.
//  Copyright © 2015 Punit Kulkarni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceAPI.h"

@protocol AsyncNetworkRequestManagerDelegate

@required
- (void)didReceieveResponse:(id)responseObject withError:(NSError *)error forTask:(NSString *)task searchType:(SEARCH_TYPE)searchType;

@end

@interface AsyncNetworkRequestManager : NSObject

+(void)initWithUrl:(NSString *)urlString delegate:(id<AsyncNetworkRequestManagerDelegate>)delegate andTask:(NSString *)task searchType:(SEARCH_TYPE)searchType;

@end
