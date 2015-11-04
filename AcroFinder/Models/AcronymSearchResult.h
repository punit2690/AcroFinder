//
//  AcronymSearchResult.h
//  AcroFinder
//
//  Created by Punit Kulkarni on 11/2/15.
//  Copyright © 2015 Punit Kulkarni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AcronymSearchResult : NSObject

@property (nonatomic, assign) NSNumber *frequency;
@property (nonatomic, assign) NSNumber *year;
@property (nonatomic, copy) NSString *lf;
@property (nonatomic, copy) NSString *sf;
@property (nonatomic, strong) NSArray *variations;

- (instancetype)initWithLongForm:(NSString *)lf
                       shortForm:(NSString *)sf
                       frequency:(NSUInteger)frequency
                         andYear:(NSInteger)year
                      variations:(NSArray *)variations;

@end
