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
    
    [self.view addSubview:_rangeSlider];
    
    [_rangeSlider addTarget:self action:@selector(slideValueChanged:) forControlEvents:UIControlEventValueChanged];
}

-(void)slideValueChanged:(id)control
{
    NSLog(@"Slider value changed: (%.2f, %.2f)", _rangeSlider.lowerValue, _rangeSlider.upperValue);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
