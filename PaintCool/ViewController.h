//
//  ViewController.h
//  PaintCool
//
//  Created by iMac309 on 16.08.15.
//  Copyright (c) 2015 iMac309. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PASettingView.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *paletteButtons;

@property (weak, nonatomic) IBOutlet UIImageView *mainDrawImage;
@property (weak, nonatomic) IBOutlet UIImageView *drawImage;

@property (weak, nonatomic) IBOutlet UIView *paletteView;
@property (weak, nonatomic) IBOutlet UIView *RGBView;


@property (weak, nonatomic) IBOutlet PASettingView *settingView;

@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *opacityLabel;

@property (weak, nonatomic) IBOutlet UISlider *redSlider;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider;
@property (weak, nonatomic) IBOutlet UISlider *blueSlider;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;


- (IBAction)buttonClear:(id)sender;

- (IBAction)touchDownPaletteButtons:(UIButton *)sender;

- (IBAction)colorChengeAction:(UIButton*)sender;
- (IBAction)rgbSlidersAction:(UISlider *)sender;
- (IBAction)sizeSliderAction:(UISlider*)sender;
- (IBAction)opacitySliderAction:(UISlider*)sender;

- (IBAction)actionSegmentedControl;

@end

