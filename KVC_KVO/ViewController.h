//
//  ViewController.h
//  KVC_KVO
//
//  Created by iStef on 07.08.17.
//  Copyright © 2017 Stefanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student.h"

@interface ViewController : UITableViewController

@property (strong, nonatomic) Student *student;

@property (strong, nonatomic) NSArray *students;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labelsCollection;

- (IBAction)tfActions:(UITextField *)sender;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *infoFields;

@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
- (IBAction)sexSegmControl:(UISegmentedControl *)sender;




@end
