//
//  NNonagramManager.h
//  Nonagram
//
//  Created by iSpring on 28/04/14.
//  Copyright (c) 2014 iSpring. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNonagramManager : NSObject

-(NSArray *) getNonagrams;
-(void) saveNonogramWith:(NSString *)title and:(NSString *)width and:(NSString *)height and:(NSString *) cells and:(NSString *) userField and:(NSString *) topMetric and:(NSString *) leftMetric and:(NSString *) topMetricWidth and:(NSString *) leftMetricWidth;

@end
