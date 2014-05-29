//
//  NViewControllerNonagram.h
//  Nonagram
//
//  Created by Student on 28.03.14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNonagramField.h"
#import "GTLDrive.h"
#import "GTMOAuth2ViewControllerTouch.h"

@interface NViewControllerNonagram : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) NNonagramField *nonagram;

- (IBAction)buttonTapped:(UIButton *)sender;
@property (nonatomic, strong) NNonagramField *field;

@end
