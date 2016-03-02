//
//  ViewController.m
//  PaintCool
//
//  Created by iMac309 on 16.08.15.
//  Copyright (c) 2015 iMac309. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(assign, nonatomic) CGPoint lastPoint;

#define TOP_BOARD 20

@end

typedef enum {
    PAHiddenPalette = 0,
    PAHiddenRGB = 1
}PAHidden;



@implementation ViewController

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.drawImage = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _lastPoint = CGPointMake(0, 0);
    self.settingView.weidthBrash = 50;
    self.settingView.opacityBrash = 1.f;
    self.settingView.colorBrash = [UIColor blackColor];
    
    self.segmentedControl.selectedSegmentIndex = PAHiddenPalette;
    self.paletteView.hidden = NO;
    self.RGBView.hidden = YES;
    
    [self drawBorderPaletteBouttons];
    

}

- (void) drawBorderPaletteBouttons {
    for (UIButton* button in self.paletteButtons)
    {
        button.layer.borderColor = [UIColor grayColor].CGColor;
        button.layer.borderWidth = 1.f;
    }
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    if (touch.tapCount == 1) {
        _lastPoint = [touch locationInView:self.view];
    } else {
        self.drawImage.image = nil;
    }
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
  
    UIGraphicsBeginImageContext(self.drawImage.frame.size);
    CGRect drawRect = CGRectMake(0.0f, 0.0f,
                                 self.drawImage.frame.size.width,
                                 self.drawImage.frame.size.height);
    if(CGRectContainsPoint(drawRect, currentPoint)){
        [self.drawImage.image drawInRect:drawRect];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.settingView.weidthBrash);
        CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), self.settingView.colorBrash.CGColor);
        CGContextBeginPath(UIGraphicsGetCurrentContext());
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), _lastPoint.x, _lastPoint.y - TOP_BOARD);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y - TOP_BOARD);
        CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeNormal);
        
        
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        self.drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        _lastPoint = currentPoint;
        [self.drawImage setAlpha: self.settingView.opacityBrash];
    }
    
    
}


- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UIGraphicsBeginImageContext(self.mainDrawImage.frame.size);
    CGRect mainDrawRect = CGRectMake(0.0f, 0.0f,
                                     self.mainDrawImage.frame.size.width,
                                     self.mainDrawImage.frame.size.height);
    [self.mainDrawImage.image drawInRect:mainDrawRect blendMode:kCGBlendModeNormal alpha:1.f];
    
    CGRect drawRect = CGRectMake(0.0f, 0.0f,
                                 self.drawImage.frame.size.width,
                                 self.drawImage.frame.size.height);
    [self.drawImage.image drawInRect:drawRect blendMode:kCGBlendModeNormal alpha: self.settingView.opacityBrash];
    self.mainDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    self.drawImage.image = nil;
    UIGraphicsEndImageContext();
    
}

- (IBAction)touchDownPaletteButtons:(UIButton *)sender {
    [UIButton animateWithDuration:0.2f
                       animations:^{
                           sender.transform = CGAffineTransformMakeScale(1.2, 1.2);
                       }];
}

#pragma mark - Action


- (IBAction)buttonClear:(id)sender {
    self.mainDrawImage.image = nil;
}

- (IBAction)sizeSliderAction:(UISlider*)sender {
    int countSize = (int)(sender.value);
    self.settingView.weidthBrash = countSize;
    self.sizeLabel.text = [NSString stringWithFormat:@"Size: %d", countSize];
    [self.settingView setNeedsDisplay];
}

- (IBAction)opacitySliderAction:(UISlider*)sender {
    float countOpacity = (float)(sender.value /100);
    self.settingView.opacityBrash = countOpacity;
    self.opacityLabel.text = [NSString stringWithFormat:@"Opacity: %d", (int)(sender.value)];
    [self.settingView setNeedsDisplay];
}

- (IBAction)actionSegmentedControl {
    if(self.segmentedControl.selectedSegmentIndex != PAHiddenPalette) {
        self.paletteView.hidden = YES;
        self.RGBView.hidden = NO;
    } else {
        self.paletteView.hidden = NO;
        self.RGBView.hidden = YES;
    }
}

- (IBAction)colorChengeAction:(UIButton*)sender {
    CGFloat r, g, b, a;
    if([sender.backgroundColor getRed:&r green:&g blue:&b alpha:&a]) { 
        UIColor* currentColor = [UIColor colorWithRed:r green:g blue:b alpha: 1.f];
        self.settingView.colorBrash = currentColor;
        [self.redSlider setValue: r * 255 animated:YES];
        [self.greenSlider setValue: g * 255 animated:YES];
        [self.blueSlider setValue: b * 255 animated:YES];
        [self.settingView setNeedsDisplay];
    }
    // animate increase button
    [UIButton animateWithDuration:0.2f
                       animations:^{
                           sender.transform = CGAffineTransformIdentity;
                       }];
    
}



- (IBAction)rgbSlidersAction:(UISlider *)sender {
    CGFloat r, g, b;
    r = self.redSlider.value/255;
    g = self.greenSlider.value/255;
    b = self.blueSlider.value/255;
    UIColor* currentColor = [UIColor colorWithRed:r green:g blue:b alpha: 1.f];
    self.settingView.colorBrash = currentColor;
    [self.settingView setNeedsDisplay];
}


@end

