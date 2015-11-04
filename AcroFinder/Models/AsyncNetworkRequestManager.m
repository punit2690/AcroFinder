//
//  AsyncNetworkRequestManager.m
//  AcroFinder
//
//  Created by Punit Kulkarni on 11/3/15.
//  Copyright © 2015 Punit Kulkarni. All rights reserved.
//

#import "AsyncNetworkRequestManager.h"
#import "AFHTTPRequestOperation.h"

@implementation AsyncNetworkRequestManager

+(void)initWithUrl:(NSString *)urlString delegate:(id<AsyncNetworkRequestManagerDelegate>)delegate andTask:(NSString *)task searchType:(SEARCH_TYPE)searchType {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    __weak id weakDelegate = delegate;
    __weak NSString *taskName = task;
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions
                                                               error:&error];
        responseObject = nil;
        [weakDelegate didReceieveResponse:json withError:nil forTask:taskName searchType:searchType];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [weakDelegate didReceieveResponse:nil withError:error forTask:taskName searchType:searchType];
    }];
    
    [operation start];
}
@end
