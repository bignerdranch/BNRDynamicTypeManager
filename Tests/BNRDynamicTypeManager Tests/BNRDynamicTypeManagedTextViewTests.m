//
//  BNRDynamicTypeManagedTextViewTests.m
//  BNRDynamicTypeManager Tests
//
//  Created by John Gallagher on 1/14/14.
//
//

#import <XCTest/XCTest.h>
#import <BNRDynamicTypeManager/BNRDynamicTypeManagedTextView.h>
#import "BNRDynamicTypeControlTest.h"

@interface BNRDynamicTypeManagedTextViewTests : BNRDynamicTypeControlTest

@property (nonatomic, copy) NSArray *elementsToTest;

@end

@implementation BNRDynamicTypeManagedTextViewTests

- (void)setUp
{
    [super setUp];

    UITextView *programmaticTextView = [[BNRDynamicTypeManagedTextView alloc] initWithFrame:CGRectZero textContainer:nil textStyle:UIFontTextStyleBody];
    UITextView *xibTextView = [BNRDynamicTypeControlTest loadElementFromNib:@"BNRDynamicTypeManagedTextView" ofClass:[UITextView class]];

    self.elementsToTest = @[programmaticTextView, xibTextView];
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
