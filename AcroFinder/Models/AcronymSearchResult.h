//
//  AcronymSearchResult.h
//  AcroFinder
//
//  Created by Punit Kulkarni on 11/2/15.
//  Copyright © 2015 Punit Kulkarni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AcronymSearchResult : NSObject

@property (nonatomic, strong) NSArray *variations;

- (instancetype)initWithLongForm:(NSString *)lf
                       ShortForm:(NSString *)sf
                       Frequency:(NSUInteger)frequency
                         andYear:(NSInteger)year;

@end
