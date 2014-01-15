//
//  BNRDynamicTypeManagedLabelTests.m
//  BNRDynamicTypeManager Tests
//
//  Created by John Gallagher on 1/14/14.
//
//

#import <XCTest/XCTest.h>
#import <BNRDynamicTypeManager/BNRDynamicTypeManagedLabel.h>
#import "BNRDynamicTypeControlTest.h"

@interface BNRDynamicTypeManagedLabelTests : BNRDynamicTypeControlTest

@property (nonatomic, copy) NSArray *elementsToTest;

@end

@implementation BNRDynamicTypeManagedLabelTests

- (void)setUp
{
    [super setUp];

    UILabel *programmaticLabel = [[BNRDynamicTypeManagedLabel alloc] initWithFrame:CGRectZero textStyle:UIFontTextStyleBody];
    UILabel *xibLabel = [BNRDynamicTypeControlTest loadElementFromNib:@"BNRDynamicTypeManagedLabel" ofClass:[UILabel class]];

    self.elementsToTest = @[programmaticLabel, xibLabel];
}

- (void)tearDown
{
    self.elementsToTest = nil;

    [super tearDown];
}

- (void)testFontsSetImmediately
{
    [super testFontsSetImmediately:self.elementsToTest];
}

- (void)testFontsSetAfterNotification
{
    [super testFontsSetAfterNotification:self.elementsToTest];
}

@end
