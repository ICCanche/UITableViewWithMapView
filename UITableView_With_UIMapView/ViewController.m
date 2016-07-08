//
//  ViewController.m
//  UITableView_With_UIMapView
//
//  Created by Irvin Geovani Chan Canche on 08/07/16.
//  Copyright © 2016 Irvin Geovani Chan Canche. All rights reserved.
//

#import "ViewController.h"
#import "MapKit/MapKit.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) NSMutableArray *items;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *verticalSpacingTable;
@property (strong, nonatomic) NSNumber *verticalSpacing;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    
    _items = [[NSMutableArray alloc] init];
    
    for (int i=0; i < 50; i++) {
        NSString *item = [NSString stringWithFormat:@"Testing with item at position: %d",i];
        [_items addObject:item];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_items count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CustomCell"];
    
    cell.textLabel.text = [_items objectAtIndex:indexPath.row];
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *cellIdentifier = @"MapHeaderCell";
    MapHeaderTableViewCell *header = [tableView
                                      dequeueReusableCellWithIdentifier:cellIdentifier];
    header.delegate = self;
    header.arrowIconUILabel.text = @"";
    UIColor *pinkColor = [UIColor colorWithRed:233/255.0
                                         green:30/255.0
                                          blue:99/255.0
                                         alpha:0.0];
    header.backgroundColor = pinkColor;


    return header;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [MapHeaderTableViewCell height];
}

#pragma mark - MapHeaderDelegate

-(void)HeaderFooter:(MapHeaderTableViewCell *)Header upTableView:(BOOL)isUp{
    NSNumber *value = (isUp)? _verticalSpacing :@0;
    self.tableView.scrollEnabled = (isUp)? NO: YES;
    [self animateTableWithDuration:0.25f andValueConstrains:value];
}

#pragma mark - helpers 
-(void) setupView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    
    UIColor *blueColor = [UIColor
                          colorWithRed:33/255.0
                          green:150/255.0
                          blue:243/255.0
                          alpha:0.0];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor = blueColor;
    self.navigationItem.title = @"Awesome App";
    
    if ([[UIScreen mainScreen] bounds].size.height == 736.0) {
        _verticalSpacing = @540;
    } else if ([[UIScreen mainScreen] bounds].size.height == 568.0) {
        _verticalSpacing = @370;
    } else if ([[UIScreen mainScreen] bounds].size.height == 667.0) {
        _verticalSpacing = @470;
    } else {
        _verticalSpacing = @280;
    }
    _verticalSpacingTable.constant = _verticalSpacing.intValue;
}

-(void)animateTableWithDuration:(CGFloat)duration andValueConstrains:(NSNumber*)value {
    _verticalSpacingTable.constant = value.intValue;
    [_tableView setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:duration animations:^{
        [_tableView layoutIfNeeded];
    }];
    
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}

@end
