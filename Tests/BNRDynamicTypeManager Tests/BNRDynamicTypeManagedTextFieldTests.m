//
//  BNRDynamicTypeManagedTextFieldTests.m
//  BNRDynamicTypeManager Tests
//
//  Created by John Gallagher on 1/14/14.
//
//

#import <XCTest/XCTest.h>
#import <BNRDynamicTypeManager/BNRDynamicTypeManagedTextField.h>
#import "BNRDynamicTypeControlTest.h"

@interface BNRDynamicTypeManagedTextFieldTests : BNRDynamicTypeControlTest

@property (nonatomic, copy) NSArray *elementsToTest;

@end

@implementation BNRDynamicTypeManagedTextFieldTests

- (void)setUp
{
    [super setUp];

    UITextField *programmaticTextField = [[BNRDynamicTypeManagedTextField alloc] initWithFrame:CGRectZero textStyle:UIFontTextStyleBody];
    UITextField *xibTextField = [BNRDynamicTypeControlTest loadElementFromNib:@"BNRDynamicTypeManagedTextField" ofClass:[UITextField class]];

    self.elementsToTest = @[programmaticTextField, xibTextField];
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
