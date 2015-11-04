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
        
        NSString *sf;
        NSString *lf;
        
        NSMutableArray *results = [NSMutableArray new];
        
        if ([responseObject isKindOfClass:[NSArray class]]) {
            if ([((NSArray *)responseObject) count]>0) {
                
                responseObject = [((NSArray *)responseObject) objectAtIndex:0];
                if (searchType == SHORTFORM_SEARCH) {
                    sf = [responseObject objectForKey:KEY_SR_SHORTFORM];
                }
                else {
                    lf = [responseObject objectForKey:KEY_SR_LONGFORM];
                }
                
                for (NSDictionary *dict in [responseObject objectForKey:(searchType == SHORTFORM_SEARCH)?@"lfs":@"sfs"]) {
                    /*{
                     "lf":"human malignant mesothelioma",
                     "freq":17,
                     "since":1986,
                     "vars":[]
                     }*/
                    AcronymSearchResult *acronymSearchResult = [[AcronymSearchResult alloc] initWithLongForm:(searchType == LONGFORM_SEARCH)?lf:[dict objectForKey:KEY_SR_LONGFORM]
                                                                                                   shortForm:(searchType == LONGFORM_SEARCH)?sf:[dict objectForKey:KEY_SR_SHORTFORM]
                                                                                                   frequency:[[dict objectForKey:KEY_SR_FREQUENCY] unsignedIntegerValue]
                                                                                                     andYear:[[dict objectForKey:KEY_SR_YEAR] integerValue]
                                                                                                  variations:[dict objectForKey:KEY_SR_VARIATIONS]];
                    if (acronymSearchResult) {
                        [results addObject:acronymSearchResult];
                    }
                }
                self.resultsArray = [results copy];
                results = nil;
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RESULTS_SEARCH"
                                                                    object:nil];
            }
        }
    }
}

@end
