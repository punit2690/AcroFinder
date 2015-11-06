//
//  DetailViewController.m
//  AcroFinder
//
//  Created by Punit Kulkarni on 11/4/15.
//  Copyright © 2015 Punit Kulkarni. All rights reserved.
//

#import "DetailViewController.h"
#import "ResultsDetails.h"
#import "CustomTableViewCell.h"

@interface DetailViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setAcronymSearchResult:(AcronymSearchResult *)acronymSearchResult {
    _acronymSearchResult = acronymSearchResult;
    [self.tableView reloadData];
}
#pragma mark tableview delegate/datasourse methods

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        if ([self.acronymSearchResult.variations count]>0) {
            return @"Variations";
        }
        return nil;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        ResultsDetails *resultsDetails = [[[NSBundle mainBundle] loadNibNamed:@"ResultDetails" owner:self options:nil] firstObject];
        [resultsDetails setshortFormText:self.acronymSearchResult.sf
                            longFormText:self.acronymSearchResult.lf
                           frequencyText:[NSString stringWithFormat:@"%ld",(long)[self.acronymSearchResult.frequency unsignedIntegerValue]]
                                yearText:[NSString stringWithFormat:@"%ld", (long)[self.acronymSearchResult.year integerValue]]];
        return resultsDetails;
    }
    else
        return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        ResultsDetails *resultsDetails = [[[NSBundle mainBundle] loadNibNamed:@"ResultDetails" owner:self options:nil] firstObject];
        return resultsDetails.frame.size.height;
    }
    
    else if (section == 1) {
        if ([self.acronymSearchResult.variations count]>0) {
            return 15;
        }
        return 0;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return nil;
    }
    else {
        CustomTableViewCell *cell  = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.acronymSearchResult = (AcronymSearchResult *)[self.acronymSearchResult.variations objectAtIndex:indexPath.row];
//        cell.textLabel.text = ((AcronymSearchResult *)[self.acronymSearchResult.variations objectAtIndex:indexPath.row]).lf;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[self.tableView indexPathForSelectedRow]];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];
    DetailViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"dvc"];
    dvc.acronymSearchResult = cell.acronymSearchResult;
    [self.navigationController showViewController:dvc sender:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    else {
        return [self.acronymSearchResult.variations count];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

@end
