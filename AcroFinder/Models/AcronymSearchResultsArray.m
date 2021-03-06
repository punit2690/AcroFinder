//
//  AcronymSearchResultsArray.m
//  AcroFinder
//
//  Created by Punit Kulkarni on 11/3/15.
//  Copyright © 2015 Punit Kulkarni. All rights reserved.
//

#import "AcronymSearchResultsArray.h"
#import "KeyConstants.h"

@interface AsyncNetworkRequestManager()

@end

@implementation AcronymSearchResultsArray

- (void)searchResultsOfType:(SEARCH_TYPE)searchType
                   forQuery:(NSString *)searchQuery {
    
    [AsyncNetworkRequestManager initWithUrl:[WebServiceAPI getAcronymSearchAPI:searchType searchString:searchQuery]
                                   delegate:self
                                    andTask:@"RESULTS_SEARCH" searchType:searchType];
}

- (void)didReceieveResponse:(id)responseObject
                  withError:(NSError *)error
                    forTask:(NSString *)task
                 searchType:(SEARCH_TYPE)searchType {
    
    if ([task isEqualToString:@"RESULTS_SEARCH"]) {
        
        self.resultsArray = nil;
        NSString *sf;
        
        NSMutableArray *results = [NSMutableArray new];
        
        if ([responseObject isKindOfClass:[NSArray class]]) {
            if ([((NSArray *)responseObject) count]>0) {
                
                responseObject = [((NSArray *)responseObject) objectAtIndex:0];
                sf = [responseObject objectForKey:@"sf"];
                
                for (NSDictionary *dict in [responseObject objectForKey:@"lfs"]) {
                    /*{
                     "lf":"human malignant mesothelioma",
                     "freq":17,
                     "since":1986,
                     "vars":[]
                     }*/
                    AcronymSearchResult *acronymSearchResult = [[AcronymSearchResult alloc] initWithLongForm:[dict objectForKey:KEY_SR_LONGFORM]
                                                                                                   shortForm:sf
                                                                                                   frequency:[[dict objectForKey:KEY_SR_FREQUENCY] unsignedIntegerValue]
                                                                                                     andYear:[[dict objectForKey:KEY_SR_YEAR] integerValue]
                                                                                                  variations:[dict objectForKey:KEY_SR_VARIATIONS]];
                    if (acronymSearchResult) {
                        [results addObject:acronymSearchResult];
                    }
                }
                self.resultsArray = [results copy];
                results = nil;
                
            }
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RESULTS_SEARCH"
                                                            object:nil];
    }
}

@end
