//
//  BNRDynamicTypeManagedButton.m
//  
//
//  Created by John Gallagher on 1/14/14.
//
//

#import "BNRDynamicTypeManagedButton.h"
#import "BNRDynamicTypeManager.h"

static NSString *const BNRDynamicTypeManagedButtonFontKeypath = @"titleLabel.font";

@implementation BNRDynamicTypeManagedButton

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame textStyle:nil];
}

- (instancetype)initWithFrame:(CGRect)frame textStyle:(NSString *)textStyle
{
    self = [super initWithFrame:frame];

    if (self) {
        [[BNRDynamicTypeManager sharedInstance] watchButton:self textStyle:textStyle];
    }

    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];

    if (self) {
        NSString *textStyle = [BNRDynamicTypeManager textStyleMatchingFont:self.titleLabel.font];
        [[BNRDynamicTypeManager sharedInstance] watchButton:self textStyle:textStyle];
    }

    return self;
}

@end
