//
//  ViewController.h
//  RecordClass
//
//  Created by saekof on 2017-04-05.
//  Copyright © 2017 saeko0032. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

