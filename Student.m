//
//  Student.m
//  KVC_KVO
//
//  Created by iStef on 07.08.17.
//  Copyright © 2017 Stefanov. All rights reserved.
//

#import "Student.h"

@implementation Student

-(void)setFirstName:(NSString *)firstName
{
    _firstName = firstName;
    
    NSLog(@"setFirstName - %@", firstName);
}

-(void)setLastName:(NSString *)lastName
{
    _lastName = lastName;
    
    NSLog(@"setLastName - %@", lastName);
}

-(void)setDateOfBirth:(NSDate *)dateOfBirth
{
    _dateOfBirth = dateOfBirth;
    
    NSLog(@"setDateOfBirth - %@", dateOfBirth);
}

-(void)setSex:(NSString *)sex
{
    _sex = sex;
    
    NSLog(@"setSex - %@", sex);
}

-(void)setAverageGrade:(NSInteger)averageGrade
{
    _averageGrade = averageGrade;
    
    NSLog(@"setAverageGrade - %ld", (long)averageGrade);
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@, %@, %@, AG - %ld", self.firstName, self.lastName, self.dateOfBirth, self.sex, (long)self.averageGrade];
}

-(void)setToZeroAllProperties
{
    NSLog(@"Setting all properties to zero");
    
    [self willChangeValueForKey:@"firstName"];
    [self willChangeValueForKey:@"lastName"];
    [self willChangeValueForKey:@"sex"];
    [self willChangeValueForKey:@"dateOfBirth"];
    [self willChangeValueForKey:@"averageGrade"];
    
    _firstName = _lastName = _sex = nil;
    _dateOfBirth = nil;
    _averageGrade = 0;
    
    [self didChangeValueForKey:@"firstName"];
    [self didChangeValueForKey:@"lastName"];
    [self didChangeValueForKey:@"sex"];
    [self didChangeValueForKey:@"dateOfBirth"];
    [self didChangeValueForKey:@"averageGrade"];
}

@end
