//
//  BNRDynamicTypeControlTest.m
//  BNRDynamicTypeManager Tests
//
//  Created by John Gallagher on 1/14/14.
//
//

#import "BNRDynamicTypeControlTest.h"

@implementation BNRDynamicTypeControlTest

+ (id)loadElementFromNib:(NSString *)nibName ofClass:(Class)ofClass;
{
    NSBundle *testBundle = [NSBundle bundleForClass:self];
    NSArray *elements = [testBundle loadNibNamed:nibName owner:self options:nil];
    for (id element in elements) {
        if ([element isKindOfClass:ofClass]) {
            return element;
        }
    }
    return nil;
}

- (void)setUp
{
    [super setUp];

    self.bodyFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testFontsSetImmediately:(NSArray *)elements;
{
    for (id element in elements) {
        expect([element font]).to.equal(self.bodyFont);
    }
}

- (void)testFontsSetAfterNotification:(NSArray *)elements
{
    for (id element in elements) {
        [element setFont:nil];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:UIContentSizeCategoryDidChangeNotification object:nil];
    for (id element in elements) {
        expect([element font]).to.equal(self.bodyFont);
    }
}

@end
