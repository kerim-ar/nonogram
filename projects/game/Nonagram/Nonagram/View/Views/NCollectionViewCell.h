//
//  NCollectionViewCell.h
//  Nonagram
//
//  Created by Student on 27.03.14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) IBOutlet UILabel *labelCellSize;
@property (nonatomic, strong) IBOutlet UILabel *labelCellName;

@property (nonatomic, strong) IBOutlet UIProgressView *progress;

@end
