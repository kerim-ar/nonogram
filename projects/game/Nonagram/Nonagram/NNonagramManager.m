//
//  NNonagramManager.m
//  Nonagram
//
//  Created by iSpring on 28/04/14.
//  Copyright (c) 2014 iSpring. All rights reserved.
//

#import "NNonagramManager.h"
#import "NNonagramField.h"


@interface NNonagramManager()

@property(nonatomic, strong) NSArray *fields;

@end

@implementation NNonagramManager

-(id) init
{
    self = [super init];
    if (self)
    {
        /*[NNonagramField MR_truncateAll];
        NNonagramField *field = [NNonagramField MR_createEntity];
        
        field.title = @"Человек";
        field.width = @"7";
        field.height = @"4";
        field.field = @"0 0 0 1 0 0 0 1 1 1 1 1 1 1 0 0 0 1 0 0 0 0 0 1 0 1 0 0";
        field.user_field = @"0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0";
        field.top_metric = @"0 0 1 0 1 0 0 1 1 1 3 1 1 1";
        field.left_metric = @"0 1 0 7 0 1 1 1";
        field.top_metric_width = @"2";
        field.left_metric_width = @"2";
        field.progress = @"0";
        
        NNonagramField *field2 = [NNonagramField MR_createEntity];
        field2.title = @"Ключ";
        field2.width = @"4";
        field2.height = @"4";
        field2.field = @"0 0 1 0 1 1 0 1 0 0 1 0 1 1 0 0";
        field2.user_field = @"0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0";
        field2.top_metric = @"1 1 1 0 1 1 1 1";
        field2.left_metric = @"0 1 2 1 0 1 0 2";
        field2.top_metric_width = @"2";
        field2.left_metric_width = @"2";
        field2.progress = @"0";
        
        NNonagramField *field3 = [NNonagramField MR_createEntity];
        field3.title = @"Дом";
        field3.width = @"9";
        field3.height = @"10";
        field3.field = @"0 0 0 0 1 0 0 0 0 0 0 0 1 1 1 0 0 0 0 0 1 1 0 1 1 0 0 0 1 1 0 0 0 1 1 0 1 1 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 0 0 0 1 1 1 1 1 1 1 1 1 1";
        field3.user_field = @"0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0";
        field3.top_metric = @"0 0 0 0 0 2 2 0 0 0 2 2 2 2 2 2 2 0 6 1 4 4 1 1 1 1 6";
        field3.left_metric = @"0 0 0 1 0 0 0 3 0 0 2 2 0 0 2 2 0 0 2 2 0 0 1 1 1 2 2 1 1 2 2 1 0 1 2 1 0 0 0 9";
        field3.top_metric_width = @"3";
        field3.left_metric_width = @"4";
        field3.progress = @"0";

        
        NNonagramField *field4 = [NNonagramField MR_createEntity];
        field4.title = @"Сюрприз";
        field4.width = @"15";
        field4.height = @"15";
        field4.field = @"0 0 0 0 0 0 0 1 1 0 0 0 1 1 0 0 0 1 1 0 0 1 0 0 1 0 1 0 0 1 0 1 0 0 0 0 1 0 0 1 1 1 0 0 1 0 1 0 0 0 0 0 1 1 0 0 0 1 1 0 0 1 1 0 0 0 0 0 1 1 0 1 1 0 0 0 0 1 1 1 0 0 0 1 0 1 0 1 0 0 0 0 0 0 1 1 1 1 0 1 0 1 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 1 0 0 1 1 1 1 1 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 0 0 1 1 1 1 0 0 1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 1 1 1 1 1 1 0 1 1 1 1 1 1 1 1 0 0 1 1 1 1 0";
        field4.user_field = @"0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0";
        field4.top_metric = @"0 0 0 0 0 0 2 1 1 2 0 0 0 0 0 0 0 1 1 0 0 1 1 3 1 1 2 1 1 0 0 3 2 1 2 1 1 4 1 2 1 1 3 1 0 0 2 3 3 3 3 2 2 3 3 5 6 5 5 2 2 1 1 1 1 1 1 1 1 1 2 2 2 2 5";
        field4.left_metric = @"0 0 0 2 2 2 1 1 1 1 0 1 1 3 1 0 0 1 2 2 0 0 2 2 2 0 3 1 1 1 0 0 4 1 1 0 0 0 0 7 0 0 0 1 5 0 0 0 0 9 0 0 0 4 7 0 0 0 0 4 0 0 0 7 1 0 0 0 1 6 0 0 0 8 4";
        field4.top_metric_width = @"5";
        field4.left_metric_width = @"5";
        field4.progress = @"0";
         
         NNonagramField *field5 = [NNonagramField MR_createEntity];
         field5.title = @"Вилы";
         field5.width = @"5";
         field5.height = @"4";
         field5.field = @"1 0 1 0 1 1 1 1 1 1 0 0 1 0 0 0 0 1 0 0";
         field5.user_field = @"0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0";
         field5.top_metric = @"2 1 4 1 2";
         field5.left_metric = @"1 1 1 0 0 5 0 0 1 0 0 1";
         field5.top_metric_width = @"1";
         field5.left_metric_width = @"3";
         field5.progress = @"0";
        
        [[NSManagedObjectContext MR_contextForCurrentThread] MR_save];*/
        
    
        self.fields = [NNonagramField MR_findAllSortedBy:@"width" ascending:YES];
    }
    return self;
}

-(NSArray *) getNonagrams
{
    return [NNonagramField MR_findAllSortedBy:@"width" ascending:YES];
}

-(void) saveNonogramWith:(NSString *)title and:(NSString *)width and:(NSString *)height and:(NSString *)cells and:(NSString *) userField and:(NSString *) topMetric and:(NSString *) leftMetric and:(NSString *) topMetricWidth and:(NSString *) leftMetricWidth{
    NSArray *fields = [NNonagramField MR_findByAttribute:@"field" withValue:cells];
    if ([fields count] == 0)
    {
        NNonagramField *field = [NNonagramField MR_createEntity];
        
        field.title = title;
        field.width = width;
        field.height = height;
        field.field = cells;
        field.user_field = userField;
        field.top_metric = topMetric;
        field.left_metric = leftMetric;
        field.top_metric_width = topMetricWidth;
        field.left_metric_width = leftMetricWidth;
        field.progress = @"0";
        
        [[NSManagedObjectContext MR_contextForCurrentThread] MR_save];
    }
}

@end
