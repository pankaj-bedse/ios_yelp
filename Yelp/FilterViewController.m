//
//  FilterViewController.m
//  Yelp
//
//  Created by Pankaj Bedse on 9/18/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "FilterViewController.h"
#import "SwitchLabelCell.h"

@interface FilterViewController () <UITableViewDataSource, UITableViewDelegate, SwitchLabelCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, readonly) NSDictionary *filters;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSMutableSet *selectedCategories;

@end

@implementation FilterViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.selectedCategories = [NSMutableSet set];
        [self initCategories];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"SwitchLabelCell" bundle:nil] forCellReuseIdentifier:@"SwitchLabelCell"];
    
    self.title = @"Filter";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelButton)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(saveAndSearch)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) onCancelButton
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)saveAndSearch
{
    [self.delegate filterViewController:self didChangeFilters:self.filters];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SwitchLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchLabelCell"];
    cell.switchLabel.text = self.categories[indexPath.row][@"name"];
    cell.on = [self.selectedCategories containsObject:self.categories[indexPath.row]];
    cell.delegate = self;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categories.count;
}
-(void)initCategories
{
    self.categories =
    @[@{@"name":@"Afghan", @"code":@"afghan"},
      @{@"name":@"African", @"code":@"african"},
      @{@"name":@"Indian", @"code":@"indian"},
      @{@"name":@"American", @"code":@"american"}
      ];
}

#pragma mark Switch Label Cell delegate methods
-(void)switchLabelCell:(SwitchLabelCell *)cell didUpdateValue:(BOOL)value
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    if (value) {
        [self.selectedCategories addObject:self.categories[indexPath.row]];
    } else {
        [self.selectedCategories removeObject:self.categories[indexPath.row]];
    }
}
@end
