//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"
#import "YelpClient.h"
#import "Business.h"
#import "YelpTableViewCell.h"
#import "FilterViewController.h"

NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate, FilterViewControllerDelegate, UISearchBarDelegate>

@property (nonatomic, strong) YelpClient *client;
@property (nonatomic, strong) NSArray *businesses;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;

-(void)fetchBusinessWithQuery:(NSString *)query params:(NSDictionary*)params;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
//        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
//        
//        [self.client searchWithTerm:@"Thai" success:^(AFHTTPRequestOperation *operation, id response) {
//            NSLog(@"response: %@", response);
//            NSArray *businessDictionaries = response[@"businesses"];
//            self.businesses = [Business businessWithDictionaris:businessDictionaries];
//            [self.tableView reloadData];
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            NSLog(@"error: %@", [error description]);
//        }];
        [self fetchBusinessWithQuery:@"Restaurants" params:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"YelpTableViewCell" bundle:nil] forCellReuseIdentifier:@"YelpTableViewCell"];
    self.tableView.rowHeight = 102;//UITableViewAutomaticDimension;
    //self.title = @"Yelp";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Filters" style:UIBarButtonItemStylePlain target:self action:@selector(onFilterButton)];
    self.searchBar = [[UISearchBar alloc]init];
    self.searchBar.delegate = self;
    self.navigationItem.titleView = self.searchBar;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YelpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YelpTableViewCell"];
    cell.business = self.businesses[indexPath.row];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.businesses.count;
}


-(void)filterViewController:(FilterViewController *)filterViewController didChangeFilters:(NSDictionary *)filters
{
    NSLog(@"filters chagned %@", filters);
    [self fetchBusinessWithQuery:@"Restaurants" params:filters];
}
-(void)onFilterButton
{
    FilterViewController *fc = [[FilterViewController alloc]init];
    fc.delegate = self;
    //fc.delegate = self;
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:fc];
    [self presentViewController:nc animated:YES completion:nil];
}
-(void)fetchBusinessWithQuery:(NSString *)query params:(NSDictionary *)params
{
    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
    
    [self.client searchWithTerm:query params:params success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"response: %@", response);
        NSArray *businessDictionaries = response[@"businesses"];
        self.businesses = [Business businessWithDictionaris:businessDictionaries];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSMutableDictionary *searchDictionary = [NSMutableDictionary dictionary];
    NSString *term = searchBar.text;
    [searchDictionary setObject:term forKey:@"term"];
    //[searchDictionary set]
    [self fetchBusinessWithQuery:@"Restaurants" params:searchDictionary];
}
@end
