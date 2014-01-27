//
//  BNRDynamicTypeManagedTextView.m
//  
//
//  Created by John Gallagher on 1/14/14.
//
//

#import "BNRDynamicTypeManagedTextView.h"
#import "BNRDynamicTypeManager.h"

@implementation BNRDynamicTypeManagedTextView

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer
{
    return [self initWithFrame:frame textContainer:textContainer textStyle:nil];
}

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer textStyle:(NSString *)textStyle;
{
    self = [super initWithFrame:frame textContainer:textContainer];

    if (self) {
        [[BNRDynamicTypeManager sharedInstance] watchTextView:self textStyle:textStyle];
    }

    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];

    if (self) {
        NSString *textStyle = [BNRDynamicTypeManager textStyleMatchingFont:self.font];
        [[BNRDynamicTypeManager sharedInstance] watchTextView:self textStyle:textStyle];
    }

    return self;
}

@end
