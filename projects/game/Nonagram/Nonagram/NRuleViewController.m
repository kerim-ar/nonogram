//
//  NRuleViewController.m
//  Nonagram
//
//  Created by iSpring on 26/05/14.
//  Copyright (c) 2014 iSpring. All rights reserved.
//

#import "NRuleViewController.h"

@interface NRuleViewController ()

@end

@implementation NRuleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation-bar-top"] forBarMetrics:UIBarMetricsDefault];
    
    
    //UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nonagram-menu-small"]];
    //[self.view addSubview:backgroundView];
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nonagram-menu"]];
    
    //self.navigationController.navigationBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navigation-bar"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}

@end
