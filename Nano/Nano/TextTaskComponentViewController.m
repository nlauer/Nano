//
//  TextTaskComponentViewController.m
//  Nano
//
//  Created by Jamie Karraker on 9/13/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import "TextTaskComponentViewController.h"
#import "CreateTaskViewController.h"

@interface TextTaskComponentViewController ()

@end

@implementation TextTaskComponentViewController

- (UIViewController *)initWithComponentData:(NSDictionary *)data {
    self = [super init];
    if( !self ) return nil;
    
    self.data = data;
    self.leftTitle = data[@"leftTitle"];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.data[@"keyboard"]) {
        [self.textField setKeyboardType:[self keyboardTypeFromString:self.data[@"keyboard"]]];
    }
    
    self.titleLabel.text = self.leftTitle;
    self.textField.placeholder = self.data[@"placeholder"];
}

- (IBAction)editedText:(id)sender {
    self.text = self.textField.text;
    [self.parent rerenderButtons];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([self.data[@"value"] isEqualToString:@"currency"]) {
        NSString *cleanCentString = [[textField.text
                                      componentsSeparatedByCharactersInSet:
                                      [[NSCharacterSet decimalDigitCharacterSet] invertedSet]]
                                     componentsJoinedByString:@""];
        // Parse final integer value
        NSInteger centAmount = cleanCentString.integerValue;
        // Check the user input
        if (string.length > 0)
        {
            // Digit added
            centAmount = centAmount * 10 + string.integerValue;
        }
        else
        {
            // Digit deleted
            centAmount = centAmount / 10;
        }

        // Update call amount value
        NSNumber *amount = [[NSNumber alloc] initWithFloat:(float)centAmount / 100.0f];
        // Write amount with currency symbols to the textfield
        NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
        [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        textField.text = [currencyFormatter stringFromNumber:amount];
        return NO;
    }
    
    return YES;
}

- (int)keyboardTypeFromString:(NSString *)keyboard {
    return [@{@"NumberPad": [NSNumber numberWithInt:UIKeyboardTypeNumberPad]}[keyboard] intValue];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

// VALUES
- (NSString *)currency {
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    if ([[currencyFormatter numberFromString:self.text] floatValue] > 0) {
        return [NSString stringWithFormat:@"%f", ([[currencyFormatter numberFromString:self.text] floatValue] * 100)];
    } else {
        return nil;
    }
}

- (NSString *)currencyDefault {
    return @"$0.00";
}

@end
