//
//  AcronymSearchResult.m
//  AcroFinder
//
//  Created by Punit Kulkarni on 11/2/15.
//  Copyright © 2015 Punit Kulkarni. All rights reserved.
//

#import "AcronymSearchResult.h"

@interface AcronymSearchResult()

@property (nonatomic, assign) NSUInteger frequency;
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, copy) NSString *lf;
@property (nonatomic, copy) NSString *sf;

@end

@implementation AcronymSearchResult

- (instancetype)initWithLongForm:(NSString *)lf
                       ShortForm:(NSString *)sf
                       Frequency:(NSUInteger)frequency
                         andYear:(NSInteger)year {
    
    if (self = [super init]) {
        _lf = lf;
        _sf = sf;
        _year = year;
        _frequency = frequency;
        return self;
    }
    return nil;
}
@end
