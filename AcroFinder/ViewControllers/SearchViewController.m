//
//  SearchViewController.m
//  AcroFinder
//
//  Created by Punit Kulkarni on 11/3/15.
//  Copyright © 2015 Punit Kulkarni. All rights reserved.
//

#import "SearchViewController.h"
#import "AcronymSearchResultsArray.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "DetailViewController.h"
#import "CustomTableViewCell.h"

@interface SearchViewController()<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) AcronymSearchResultsArray *acronymSearchResultsArray;
@property (weak, nonatomic) IBOutlet UISegmentedControl *searchTypeSegmentedControl;

@end

@implementation SearchViewController {
    NSTimer *timer;
    UIView *overlayView;
    SEARCH_TYPE selectedSearchType;
    UIRefreshControl *refreshControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initModel];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reload)
                                                 name:@"RESULTS_SEARCH"
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"RESULTS_SEARCH"
                                                  object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Init methods

- (void)initModel {
    self.acronymSearchResultsArray = [[AcronymSearchResultsArray alloc] init];
}

- (void)initUI {
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor grayColor];
    [refreshControl addTarget:self action:@selector(requestData) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
}

- (IBAction)searchSegmentedControlValueChanged:(id)sender {
    selectedSearchType = (((UISegmentedControl *)sender).selectedSegmentIndex == 0)?SHORTFORM_SEARCH:LONGFORM_SEARCH;
    [self requestData];
}

#pragma mark - segue methods 
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        DetailViewController *detailViewController = (DetailViewController *)[segue destinationViewController];
        detailViewController.acronymSearchResult = ((CustomTableViewCell *)[self.tableView cellForRowAtIndexPath:[self.tableView indexPathForSelectedRow]]).acronymSearchResult;
        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];
    }
}
#pragma mark - Search methods

- (void)reload {
    
    [self.tableView reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        [refreshControl endRefreshing];
        [MBProgressHUD hideAllHUDsForView:overlayView animated:YES];
        [UIView animateWithDuration:0.1 animations:^{
            overlayView.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
        } completion:^(BOOL finished) {
            [overlayView removeFromSuperview];
            overlayView = nil;
            self.tableView.userInteractionEnabled = YES;
        }];
    });
}

#pragma mark - UITableViewDelegate methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectedSearchType = selectedSearchType;
    cell.acronymSearchResult = [self.acronymSearchResultsArray.resultsArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.acronymSearchResultsArray.resultsArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.searchBar resignFirstResponder];
}

#pragma mark - UISearchBarDelegate methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self requestData];
    [timer invalidate];
    timer = nil;
    [self.searchBar resignFirstResponder];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [timer invalidate];
    timer = nil;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(requestData) userInfo:nil repeats:NO];
}

- (void)requestData {
    
    if (self.view.window) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tableView.userInteractionEnabled = NO;
            [overlayView removeFromSuperview];
            overlayView = nil;
            overlayView = [[UIView alloc] initWithFrame:self.tableView.frame];
            overlayView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
            [self.view insertSubview:overlayView aboveSubview:self.tableView];
            [MBProgressHUD showHUDAddedTo:overlayView animated:YES];
        });
        
        [self.acronymSearchResultsArray searchResultsOfType:selectedSearchType forQuery:self.searchBar.text];
    }
}

@end
