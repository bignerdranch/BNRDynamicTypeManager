//
//  BNRDynamicTypeManagedButtonTests.m
//  BNRDynamicTypeManager Tests
//
//  Created by John Gallagher on 1/14/14.
//
//

#import <XCTest/XCTest.h>
#import <BNRDynamicTypeManager/BNRDynamicTypeManagedButton.h>
#import "BNRDynamicTypeControlTest.h"

@interface BNRDynamicTypeManagedButtonTests : BNRDynamicTypeControlTest

@property (nonatomic, copy) NSArray *elements;

@end

@implementation BNRDynamicTypeManagedButtonTests

- (void)setUp
{
    [super setUp];

    UIButton *programmaticButton = [[BNRDynamicTypeManagedButton alloc] initWithFrame:CGRectZero textStyle:UIFontTextStyleBody];
    UIButton *xibButton = [BNRDynamicTypeControlTest loadElementFromNib:@"BNRDynamicTypeManagedButton" ofClass:[UIButton class]];

    self.elements = @[programmaticButton, xibButton];
}

- (void)tearDown
{
    self.elements = nil;

    [super tearDown];
}

- (void)testFontsSetImmediately
{
    [super testFontsSetImmediately:self.elements];
}

- (void)testFontsSetAfterNotification
{
    [super testFontsSetAfterNotification:self.elements];
}

@end
