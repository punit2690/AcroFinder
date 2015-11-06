//
//  ResultsDetails.m
//  AcroFinder
//
//  Created by Punit Kulkarni on 11/4/15.
//  Copyright © 2015 Punit Kulkarni. All rights reserved.
//

#import "ResultsDetails.h"

@interface ResultsDetails()

@property (weak, nonatomic) IBOutlet UILabel *shortFormLabel;
@property (weak, nonatomic) IBOutlet UILabel *longFormLabel;
@property (weak, nonatomic) IBOutlet UILabel *frequencyLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;

@end

@implementation ResultsDetails

- (void)setshortFormText:(NSString *)shortFormText
            longFormText:(NSString *)longFormText
           frequencyText:(NSString *)frequencyText
                yearText:(NSString *)yearText {
    
    self.shortFormLabel.text = shortFormText;
    self.longFormLabel.text = longFormText;
    self.frequencyLabel.text = frequencyText;
    self.yearLabel.text = yearText;
}

@end
