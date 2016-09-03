//
//  ViewController.m
//  SDCountryPicker
//
//  Created by Somdev Choudhary on 03/09/16.
//  Copyright © 2016 Somdev Choudhary. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSArray *countryListArr;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getListFromJson];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getListFromJson
{
    NSString *urlString = [[NSBundle mainBundle]pathForResource:@"CountryCodes" ofType:@"json"];
    
    NSString *rawText = [NSString stringWithContentsOfFile:urlString encoding:NSUTF8StringEncoding error:nil];
    
    NSData *data = [rawText dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    countryListArr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"name"  ascending:YES selector:@selector(caseInsensitiveCompare:)];
    
    countryListArr=[countryListArr sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]];
    
    [self.countryPicker reloadAllComponents];
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [countryListArr count];
}


-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UIView *pickerCustomView = [UIView new];
    
    
    NSDictionary *dic = [countryListArr objectAtIndex:row];
    
    NSString *countryCode = [NSString stringWithFormat:@"%@",[dic valueForKey:@"dial_code"]];
    NSString *countryImage = [[NSString stringWithFormat:@"%@",[dic valueForKey:@"code"]]lowercaseString];
    NSString *nameStr = [dic valueForKey:@"name"];
    
    UILabel *mytext = [[UILabel alloc] init];
    mytext.text = nameStr;
    [mytext setFrame:CGRectMake(65,10,175,21)];
    [pickerCustomView addSubview:mytext];
    
    UILabel *myCode = [[UILabel alloc] init];
    myCode.text = countryCode;
    [myCode setFrame:CGRectMake(self.view.frame.size.width - 80 ,10,69,21)];
    [pickerCustomView addSubview:myCode];
    
    
    UIImageView *myIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:countryImage]];
    [myIcon setFrame:CGRectMake(8, 8, 44, 26)];
    
    [pickerCustomView addSubview:myIcon];
    [pickerCustomView addSubview:mytext];
    return pickerCustomView;
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    countryView.hidden = NO;
    
    NSDictionary *selCountryDic  = [countryListArr objectAtIndex:row];
    
    NSString *countryCode = [NSString stringWithFormat:@"%@",[selCountryDic valueForKey:@"dial_code"]];
    NSString *countryImage = [[NSString stringWithFormat:@"%@",[selCountryDic valueForKey:@"code"]]lowercaseString];
    NSString *nameStr = [selCountryDic valueForKey:@"name"];
    
    
    countryFlag.image = [UIImage imageNamed:countryImage];
    countryNameLbl.text = nameStr;
    countryCodeLbl.text = countryCode;
}

@end
