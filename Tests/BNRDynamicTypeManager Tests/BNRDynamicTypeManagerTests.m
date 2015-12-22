//
//  BNRDynamicTypeManager_Tests.m
//  BNRDynamicTypeManager Tests
//
//  Created by John Gallagher on 1/14/14.
//
//

#import <XCTest/XCTest.h>
#import <BNRDynamicTypeManager/BNRDynamicTypeManager.h>

// Define a class that has a font property we can use as the "managed" object in all our tests
@interface TestElement : NSObject
@property (nonatomic, strong) UIFont *font;
@end

@implementation TestElement
@end

@interface BNRDynamicTypeManagerTests : XCTestCase

@property (nonatomic, strong) UIFont *bodyFont;
@property (nonatomic, strong) BNRDynamicTypeManager *manager;
@property (nonatomic, strong) TestElement *element;

@end

@implementation BNRDynamicTypeManagerTests

- (void)setUp
{
    [super setUp];

    self.bodyFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.manager = [[BNRDynamicTypeManager alloc] init];
    self.element = [[TestElement alloc] init];

    [self.manager watchElement:self.element fontKeypath:@"font" textStyle:UIFontTextStyleBody];
}

- (void)tearDown
{
    self.manager = nil;
    self.element = nil;

    [super tearDown];
}

- (void)testTextStyleMatchingFontForValidFonts
{
    for (NSString *style in @[UIFontTextStyleBody,
                              UIFontTextStyleCaption1,
                              UIFontTextStyleCaption2,
                              UIFontTextStyleFootnote,
                              UIFontTextStyleHeadline,
                              UIFontTextStyleSubheadline,
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 90000
                              UIFontTextStyleCallout,
                              UIFontTextStyleTitle1,
                              UIFontTextStyleTitle2,
                              UIFontTextStyleTitle3
#endif
                              ]) {
        UIFont *font = [UIFont preferredFontForTextStyle:style];
        expect([BNRDynamicTypeManager textStyleMatchingFont:font]).to.equal(style);
    }
}

- (void)testTextStyleMatchingFontForInvalidFonts
{
    UIFont *font = [self.bodyFont fontWithSize:self.bodyFont.pointSize * 2];
    expect([BNRDynamicTypeManager textStyleMatchingFont:font]).to.beNil();
}

- (void)testWatchedElementsHaveExpectedFontSetImmediately
{
    expect(self.element.font).to.equal(self.bodyFont);
}

- (void)testWatchedElementsHaveFontSetAfterNotification
{
    self.element.font = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:UIContentSizeCategoryDidChangeNotification object:nil];
    expect(self.element.font).to.equal(self.bodyFont);
}

- (void)testWatchedElementsAreHeldWeakly
{
    __weak TestElement *weakElement = self.element;
    self.element = nil;
    expect(weakElement).to.beNil();
}

- (void)testGetStyleFromElementIfGivenNilStyle
{
    TestElement *element = [[TestElement alloc] init];
    UIFont *headlineFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    element.font = headlineFont;

    [self.manager watchElement:element fontKeypath:@"font" textStyle:nil];

    element.font = nil;

    [[NSNotificationCenter defaultCenter] postNotificationName:UIContentSizeCategoryDidChangeNotification object:nil];
    expect(element.font).to.equal(headlineFont);
}

@end
