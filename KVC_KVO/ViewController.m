//
//  ViewController.m
//  KVC_KVO
//
//  Created by iStef on 07.08.17.
//  Copyright © 2017 Stefanov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.student = [[Student alloc] init];
    
    [self addObserversForPropertiesOf:self.student];
    
    self.student.firstName = @"Ivan";
    self.student.lastName = @"Stefanov";
    self.student.dateOfBirth = [self getCorrectDateFrom:@"14/01/1996"];
    self.student.sex = @"Male";
    self.student.averageGrade = 5;
    NSLog(@"%@", self.student);
    
    Student *student2 = [[Student alloc] init];
    [student2 addObserver:self
              forKeyPath:@"firstName"
                 options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                 context:nil];
    student2.firstName = @"Jack";
    student2.lastName = @"Nilson";
    student2.dateOfBirth = [self getCorrectDateFrom:@"08/02/1997"];
    student2.sex = @"Male";
    student2.averageGrade = 3;
    student2.friend = self.student;
    
    Student *student3 = [[Student alloc] init];
    [student3 addObserver:self
              forKeyPath:@"firstName"
                 options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                 context:nil];
    student3.firstName = @"Sofia";
    student3.lastName = @"Jackson";
    student3.dateOfBirth = [self getCorrectDateFrom:@"07/01/1997"];
    student3.sex = @"Female";
    student3.averageGrade = 5;
    student3.friend = student2;
    
    Student *student4 = [[Student alloc] init];
    [student4 addObserver:self
              forKeyPath:@"firstName"
                 options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                 context:nil];
    student4.firstName = @"Ann";
    student4.lastName = @"Brigit";
    student4.dateOfBirth = [self getCorrectDateFrom:@"24/11/1995"];
    student4.sex = @"Female";
    student4.averageGrade = 4;
    student4.friend = student3;

    self.student.friend = student4;
    
    Student *student5 = [[Student alloc] init];
    student5.firstName = @"Diana";
    student5.dateOfBirth = [self getCorrectDateFrom:@"24/09/1994"];
    student5.averageGrade = 3;
    
    Student *student6 = [[Student alloc] init];
    student6.firstName = @"Lera";
    student6.dateOfBirth = [self getCorrectDateFrom:@"11/12/1995"];
    student6.averageGrade = 5;

    /*[student3 setValue:@"Jacky" forKeyPath:@"friend.firstName"];
    [student4 setValue:@"Sonya" forKeyPath:@"friend.firstName"];
    [self.student setValue:@"Anny" forKeyPath:@"friend.firstName"];
    [student2 setValue:@"John" forKeyPath:@"friend.firstName"];*/
    
    /*[student4 setValue:@"Sonya" forKeyPath:@"friend.firstName"];
    [student4 setValue:@"Jacky" forKeyPath:@"friend.friend.firstName"];
    [student4 setValue:@"John" forKeyPath:@"friend.friend.friend.firstName"];
    [self.student setValue:@"John1" forKeyPath:@"friend.friend.friend.friend.firstName"];*/
    
    self.students = @[self.student, student2, student3, student4, student5, student6];

    //NSArray *firstNames = [self.students valueForKeyPath:@"@unionOfObjects.firstName"];
    //NSLog(@"%@", firstNames);

    //NSDate *earliestDate = [self.students valueForKeyPath:@"@min.dateOfBirth"];
    //NSLog(@"%@", earliestDate);
    
    //NSDate *latestDate = [self.students valueForKeyPath:@"@max.dateOfBirth"];
    //NSLog(@"%@", latestDate);
    
    NSNumber *gradesSum = [self.students valueForKeyPath:@"@sum.averageGrade"];
    NSLog(@"%@", gradesSum);
    
    NSNumber *studentsAverGrade = [self.students valueForKeyPath:@"@avg.averageGrade"];
    CGFloat ag = [studentsAverGrade floatValue];
    NSLog(@"%.2f", ag);
}

-(void)addObserversForPropertiesOf:(Student *)student
{
    [student addObserver:self
              forKeyPath:@"firstName"
                 options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                 context:nil];
    
    [student addObserver:self
              forKeyPath:@"lastName"
                 options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                 context:nil];
    
    [student addObserver:self
              forKeyPath:@"dateOfBirth"
                 options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                 context:nil];
    
    [student addObserver:self
              forKeyPath:@"sex"
                 options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                 context:nil];
    
    [student addObserver:self
              forKeyPath:@"averageGrade"
                 options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                 context:nil];
}

-(NSDate *)getCorrectDateFrom:(NSString *)date
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy"];
    NSDate *wrongDate = [df dateFromString:date];
    
    NSTimeZone *currentTimeZone = [NSTimeZone localTimeZone];
    NSTimeZone *UTCTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    
    NSInteger currentGMTOffset = [currentTimeZone secondsFromGMTForDate:wrongDate];
    NSInteger GMTOffset = [UTCTimeZone secondsFromGMTForDate:wrongDate];
    
    NSTimeInterval GMTInterval = currentGMTOffset - GMTOffset;
    
    NSDate *correctDate = [[NSDate alloc] initWithTimeInterval:GMTInterval sinceDate:wrongDate];
    
    return correctDate;
}

- (void)observeValueForKeyPath:(nullable NSString *)keyPath
                      ofObject:(nullable id)object
                        change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change
                       context:(nullable void *)context
{
    NSLog(@"\nobserveValueForKeyPath: %@\nofObject: %@\nchange: %@", keyPath, object, change);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Student's Info";
}

- (IBAction)tfActions:(UITextField *)sender
{
    UILabel *label = [self.labelsCollection objectAtIndex:sender.tag];
    
    if (sender.text.length == 0) {
        switch (sender.tag) {
            case 0:
                label.text = @"First name";
                break;
            case 1:
                label.text = @"Last name";
                break;
            case 2:
                label.text = @"Date of Birth";
                break;
            case 3:
                label.text = @"Average grade";
                break;
            default:
                break;
        }
    }else{
        label.text = sender.text;
    }
    
    if (sender.text.length > 0) {
        switch (sender.tag) {
            case 0:
                self.student.firstName = sender.text;
                break;
            case 1:
                self.student.lastName = sender.text;
                break;
            case 2:
                self.student.dateOfBirth = [self getCorrectDateFrom:sender.text];
                break;
            case 3:
                self.student.averageGrade = [sender.text integerValue];
                break;
            default:
                break;
        }
    }
}

- (IBAction)sexSegmControl:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0) {
        self.sexLabel.text = self.student.sex = @"Male";
    }else{
        self.sexLabel.text = self.student.sex = @"Female";
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag < 2) {
        [[self.infoFields objectAtIndex:textField.tag+1] becomeFirstResponder];
    }else if (textField.tag == 2) {
        [textField resignFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
