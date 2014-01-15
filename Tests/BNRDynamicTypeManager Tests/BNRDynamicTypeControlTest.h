//
//  BNRDynamicTypeControlTest.h
//  BNRDynamicTypeManager Tests
//
//  Created by John Gallagher on 1/14/14.
//
//

#import <XCTest/XCTest.h>

@interface BNRDynamicTypeControlTest : XCTestCase

@property (nonatomic, strong) UIFont *bodyFont;

+ (id)loadElementFromNib:(NSString *)nibName ofClass:(Class)ofClass;

- (void)testFontsSetImmediately:(NSArray *)elements;
- (void)testFontsSetAfterNotification:(NSArray *)elements;

@end
