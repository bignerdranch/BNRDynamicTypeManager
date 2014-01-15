//
//  BNRDynamicTypeExampleViewController.m
//  BNRDynamicTypeManager Example
//
//  Created by John Gallagher on 1/14/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRDynamicTypeExampleViewController.h"
#import "BNRDynamicTypeManagedLabel.h"
#import "BNRDynamicTypeManagedButton.h"
#import "BNRDynamicTypeManagedTextField.h"
#import "BNRDynamicTypeManagedTextView.h"

@interface BNRDynamicTypeExampleViewController ()

@property (weak, nonatomic) IBOutlet BNRDynamicTypeManagedLabel *label;
@property (weak, nonatomic) IBOutlet BNRDynamicTypeManagedButton *button;

@end

@implementation BNRDynamicTypeExampleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    BNRDynamicTypeManagedTextField *textField = [[BNRDynamicTypeManagedTextField alloc] initWithFrame:CGRectZero textStyle:UIFontTextStyleSubheadline];
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    textField.text = @"Programmatic Subheadline";

    BNRDynamicTypeManagedTextView *textView = [[BNRDynamicTypeManagedTextView alloc] initWithFrame:CGRectZero textContainer:nil textStyle:UIFontTextStyleFootnote];
    textView.translatesAutoresizingMaskIntoConstraints = NO;
    textView.text = @"This is a BNRDynamicTypeManagedTextView. It was created programatically with a text style of Footnote.";

    [self.view addSubview:textField];
    [self.view addSubview:textView];

    NSDictionary *viewsDictionary = @{ @"textField": textField,
                                       @"textView" : textView,
                                       @"label"    : self.label,
                                       @"button"   : self.button };

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[label]-[textField]"
                                                                      options:NSLayoutFormatAlignAllCenterX
                                                                      metrics:nil
                                                                        views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[button]-[textView]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[textView]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDictionary]];
}

@end
