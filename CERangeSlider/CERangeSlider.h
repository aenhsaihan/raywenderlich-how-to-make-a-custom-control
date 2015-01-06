//
//  CERangeSlider.h
//  CERangeSlider
//
//  Created by Anar Enhsaihan on 1/6/15.
//  Copyright (c) 2015 Citta LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CERangeSlider : UIControl
@property (nonatomic) float maximumValue;
@property (nonatomic) float minimumValue;
@property (nonatomic) float upperValue;
@property (nonatomic) float lowerValue;

@property (nonatomic) UIColor * trackColour;
@property (nonatomic) UIColor * trackHighlightColour;
@property (nonatomic) UIColor * knobColour;
@property (nonatomic) float curvaceousness;

- (float) positionForValue:(float)value;
@end
