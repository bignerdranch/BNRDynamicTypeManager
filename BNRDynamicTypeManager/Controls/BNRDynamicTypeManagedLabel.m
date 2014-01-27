//
//  BNRDynamicTypeManagedLabel.m
//  
//
//  Created by John Gallagher on 1/14/14.
//
//

#import "BNRDynamicTypeManagedLabel.h"
#import "BNRDynamicTypeManager.h"

@implementation BNRDynamicTypeManagedLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame textStyle:nil];
}

- (instancetype)initWithFrame:(CGRect)frame textStyle:(NSString *)textStyle
{
    self = [super initWithFrame:frame];

    if (self) {
        [[BNRDynamicTypeManager sharedInstance] watchLabel:self textStyle:textStyle];
    }

    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];

    if (self) {
        NSString *textStyle = [BNRDynamicTypeManager textStyleMatchingFont:self.font];
        [[BNRDynamicTypeManager sharedInstance] watchLabel:self textStyle:textStyle];
    }

    return self;
}

@end
