//
//  ViewController.h
//  SDCountryPicker
//
//  Created by Somdev Choudhary on 03/09/16.
//  Copyright © 2016 Somdev Choudhary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
{
    IBOutlet UIView *countryView;
    IBOutlet UIImageView *countryFlag;
    IBOutlet UILabel *countryNameLbl;
    IBOutlet UILabel *countryCodeLbl;
}

@property(nonatomic,strong)IBOutlet UIPickerView *countryPicker;


@end

