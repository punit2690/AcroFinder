//
//  AcronymSearchResult.m
//  AcroFinder
//
//  Created by Punit Kulkarni on 11/2/15.
//  Copyright © 2015 Punit Kulkarni. All rights reserved.
//

#import "AcronymSearchResult.h"
#import "KeyConstants.h"

@implementation AcronymSearchResult

- (instancetype)initWithLongForm:(NSString *)lf
                       shortForm:(NSString *)sf
                       frequency:(NSUInteger)frequency
                         andYear:(NSInteger)year
                      variations:(NSArray *)variations {
    
    if (self = [super init]) {
        
        _lf = lf;
        _sf = sf;
        _year = [NSNumber numberWithInteger:year];
        _frequency = [NSNumber numberWithUnsignedInteger:frequency];

        NSMutableArray *array = [NSMutableArray new];
        
        for (NSDictionary *dict in variations) {
            
            AcronymSearchResult *acronymSearchResult = [[AcronymSearchResult alloc] initWithLongForm:[dict objectForKey:KEY_SR_LONGFORM]?[dict objectForKey:KEY_SR_LONGFORM]:lf
                                                                                           shortForm:[dict objectForKey:KEY_SR_SHORTFORM]?[dict objectForKey:KEY_SR_SHORTFORM]:sf
                                                                                           frequency:[[dict objectForKey:KEY_SR_FREQUENCY] unsignedIntegerValue]
                                                                                             andYear:[[dict objectForKey:KEY_SR_YEAR] integerValue]
                                                                                          variations:nil];
            if (acronymSearchResult) {
                [array addObject:acronymSearchResult];
            }
        }
        
        _variations = [array copy];
        array = nil;
        
        return self;
    }
    return nil;
}

@end
