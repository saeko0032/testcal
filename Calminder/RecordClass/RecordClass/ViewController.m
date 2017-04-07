//
//  ViewController.m
//  RecordClass
//
//  Created by saekof on 2017-04-05.
//  Copyright © 2017 saeko0032. All rights reserved.
//

#import "ViewController.h"
#import "DateTextCell.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray<NSString*>* itemsForSection1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    
    // dateManagerclass yori hippattekuru
    self.itemsForSection1 = [@[@"FoodID", @"FoodName", @"FoodPrice", @"FoodMadeInCountry", @"FoodSize", @"FoodCalorie", @"FoodIngredients"] mutableCopy];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DateTextCell* cell = [tableView dequeueReusableCellWithIdentifier:@"dateTextCellReuse"];
    if(!cell) {
        cell = [[DateTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"dateTextCellReuse"];
    }
//    cell.productTextField.tag = indexPath.row;
//    cell.productTextField.placeholder =  [self.itemsForSection1 objectAtIndex:indexPath.row];
//    if(![cell.productTextField.text isEqualToString:@""]) {
//        cell.productTextField.text = @"";
//    }
    return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.itemsForSection1.count;
    
}

@end
