//
//  Student.h
//  KVC_KVO
//
//  Created by iStef on 07.08.17.
//  Copyright © 2017 Stefanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSDate *dateOfBirth;
@property (strong, nonatomic) NSString *sex;
@property (assign, nonatomic) NSInteger averageGrade;

@property (weak, nonatomic) Student *friend;

-(void)setToZeroAllProperties;

@end
