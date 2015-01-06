//
//  CERangeSliderKnobLayer.h
//  CERangeSlider
//
//  Created by Anar Enhsaihan on 1/6/15.
//  Copyright (c) 2015 Citta LLC. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@class CERangeSlider;

@interface CERangeSliderKnobLayer : CALayer
@property BOOL highlighted;
@property (weak) CERangeSlider *slider;
@end
