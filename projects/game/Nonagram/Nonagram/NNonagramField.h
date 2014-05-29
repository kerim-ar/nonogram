//
//  NNonagramField.h
//  Nonagram
//
//  Created by iSpring on 02/05/14.
//  Copyright (c) 2014 iSpring. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NNonagramField : NSManagedObject

@property (nonatomic, retain) NSString * field;
@property (nonatomic, retain) NSString * height;
@property (nonatomic, retain) NSString * left_metric;
@property (nonatomic, retain) NSString * left_metric_width;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * top_metric;
@property (nonatomic, retain) NSString * top_metric_width;
@property (nonatomic, retain) NSString * user_field;
@property (nonatomic, retain) NSString * width;
@property (nonatomic, retain) NSString * progress;

@end
