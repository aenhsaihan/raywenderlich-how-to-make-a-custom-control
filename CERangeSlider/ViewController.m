//
//  ViewController.m
//  CERangeSlider
//
//  Created by Anar Enhsaihan on 1/6/15.
//  Copyright (c) 2015 Citta LLC. All rights reserved.
//

#import "ViewController.h"
#import "CERangeSlider.h"

@interface ViewController ()

@end

@implementation ViewController
{
    CERangeSlider *_rangeSlider;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSUInteger margin = 20;
    CGRect sliderFrame = CGRectMake(margin, margin, self.view.frame.size.width - margin * 2, 30);
    _rangeSlider = [[CERangeSlider alloc] initWithFrame:sliderFrame];
    _rangeSlider.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:_rangeSlider];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
