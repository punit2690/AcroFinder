//
//  WebServiceAPI.m
//  AcroFinder
//
//  Created by Punit Kulkarni on 11/3/15.
//  Copyright © 2015 Punit Kulkarni. All rights reserved.
//

#import "WebServiceAPI.h"

@implementation WebServiceAPI

+ (NSString *)getAcronymSearchAPI:(SEARCH_TYPE)searchType searchString:(NSString *)searchString {
    return [NSString stringWithFormat:@"http://www.nactem.ac.uk/software/acromine/dictionary.py?%@=%@",(searchType == SHORTFORM_SEARCH)?@"sf":@"lf", searchString];
}

@end
