//
//  BNRDynamicTypeManagedTextField.m
//  
//
//  Created by John Gallagher on 1/14/14.
//
//

#import "BNRDynamicTypeManagedTextField.h"
#import "BNRDynamicTypeManager.h"

@implementation BNRDynamicTypeManagedTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame textStyle:nil];
}

- (instancetype)initWithFrame:(CGRect)frame textStyle:(NSString *)textStyle
{
    self = [super initWithFrame:frame];

    if (self) {
        [[BNRDynamicTypeManager sharedInstance] watchTextField:self textStyle:textStyle];
    }

    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];

    if (self) {
        NSString *textStyle = [BNRDynamicTypeManager textStyleMatchingFont:self.font];
        [[BNRDynamicTypeManager sharedInstance] watchTextField:self textStyle:textStyle];
    }

    return self;
}

@end
