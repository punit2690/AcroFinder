//
//  WebServiceAPI.h
//  AcroFinder
//
//  Created by Punit Kulkarni on 11/3/15.
//  Copyright © 2015 Punit Kulkarni. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSUInteger,SEARCH_TYPE) {
    SHORTFORM_SEARCH,
    LONGFORM_SEARCH
};

@interface WebServiceAPI : NSObject

+ (NSString *)getAcronymSearchAPI:(SEARCH_TYPE)searchType searchString:(NSString *)searchString;

@end
