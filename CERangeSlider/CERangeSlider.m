//
//  CERangeSlider.m
//  CERangeSlider
//
//  Created by Anar Enhsaihan on 1/6/15.
//  Copyright (c) 2015 Citta LLC. All rights reserved.
//

#import "CERangeSlider.h"
#import <QuartzCore/QuartzCore.h>
#import "CERangeSliderKnobLayer.h"

@implementation CERangeSlider
{
    CALayer *_trackLayer;
    CERangeSliderKnobLayer *_upperKnobLayer;
    CERangeSliderKnobLayer *_lowerKnobLayer;
    
    float _knobWidth;
    float _useableTrackLength;
    
    CGPoint _previousTouchPoint;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.maximumValue = 10.0;
        self.minimumValue = 0.0;
        self.upperValue   = 8.0;
        self.lowerValue   = 2.0;
        
        _trackLayer = [CALayer layer];
        _trackLayer.backgroundColor = [UIColor blueColor].CGColor;
        [self.layer addSublayer:_trackLayer];
        
        _upperKnobLayer = [CERangeSliderKnobLayer layer];
        _upperKnobLayer.slider = self;
        _upperKnobLayer.backgroundColor = [UIColor greenColor].CGColor;
        [self.layer addSublayer:_upperKnobLayer];
        
        _lowerKnobLayer = [CERangeSliderKnobLayer layer];
        _lowerKnobLayer.slider = self;
        _lowerKnobLayer.backgroundColor = [UIColor greenColor].CGColor;
        [self.layer addSublayer:_lowerKnobLayer];
        
        [self setLayerFrames];
    }
    
    return self;
}

-(void)setLayerFrames
{
    _trackLayer.frame = CGRectInset(self.bounds, 0, self.bounds.size.height / 3.5);
    [_trackLayer setNeedsDisplay];
    
    _knobWidth = self.bounds.size.height;
    _useableTrackLength = self.bounds.size.width - _knobWidth;
    
    float upperKnobCentre = [self positionForValue:_upperValue];
    _upperKnobLayer.frame = CGRectMake(upperKnobCentre - _knobWidth/2, 0, _knobWidth, _knobWidth);
    
    float lowerKnobCentre = [self positionForValue:_lowerValue];
    _lowerKnobLayer.frame = CGRectMake(lowerKnobCentre - _knobWidth/2, 0, _knobWidth, _knobWidth);
    
    [_upperKnobLayer setNeedsDisplay];
    [_lowerKnobLayer setNeedsDisplay];
    
}

-(float)positionForValue:(float)value
{
    return _useableTrackLength * (value - _minimumValue) / (_maximumValue - _minimumValue) + (_knobWidth/2);
}

-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    _previousTouchPoint = [touch locationInView:self];
    
    // hit test the knob layers
    if (CGRectContainsPoint(_lowerKnobLayer.frame, _previousTouchPoint)) {
        _lowerKnobLayer.highlighted = YES;
        [_lowerKnobLayer setNeedsDisplay];
    } else if (CGRectContainsPoint(_upperKnobLayer.frame, _previousTouchPoint)) {
        
        _upperKnobLayer.highlighted = YES;
        [_upperKnobLayer setNeedsDisplay];
    }
    
    return _upperKnobLayer.highlighted || _lowerKnobLayer.highlighted;
}

#define BOUND(VALUE, UPPER, LOWER)    MIN(MAX(VALUE, LOWER), UPPER)

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [touch locationInView:self];
    
    // 1. determine by how much the user has dragged
    float delta = touchPoint.x - _previousTouchPoint.x;
    float valueDelta = (_maximumValue - _minimumValue) * delta / _useableTrackLength;
    
    _previousTouchPoint = touchPoint;
    
    // 2. update the values
    if (_lowerKnobLayer.highlighted) {
        _lowerValue += valueDelta;
        _lowerValue = BOUND(_lowerValue, _maximumValue, _lowerValue);
    }
    if (_upperKnobLayer.highlighted) {
        _upperValue += valueDelta;
        _upperValue = BOUND(_upperValue, _maximumValue, _lowerValue);
    }
    
    // 3. Update the UI state
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    [self setLayerFrames];
    
    [CATransaction commit];
    
    return YES;
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    _lowerKnobLayer.highlighted = _upperKnobLayer.highlighted = NO;
    [_lowerKnobLayer setNeedsDisplay];
    [_upperKnobLayer setNeedsDisplay];
}

@end
