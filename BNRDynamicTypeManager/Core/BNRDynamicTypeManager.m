//
//  BNRDynamicTypeManager.m
//  BNRDynamicTypeManager
//
//  Created by John Gallagher on 1/9/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRDynamicTypeManager.h"

static NSString * const BNRDynamicTypeManagerFontKeypathUILabel     = @"font";
static NSString * const BNRDynamicTypeManagerFontKeypathUIButton    = @"titleLabel.font";
static NSString * const BNRDynamicTypeManagerFontKeypathUITextField = @"font";
static NSString * const BNRDynamicTypeManagerFontKeypathUITextView  = @"font";

#pragma mark - BNRDynamicTypeTuple interface

// Helper class that we'll use as values in our NSMapTable to hold
// (keypath, textStyle) tuples.
@interface BNRDynamicTypeTuple : NSObject

@property (nonatomic, copy) NSString *keypath;
@property (nonatomic, copy) NSString *textStyle;

- (instancetype)initWithKeypath:(NSString *)keypath textStyle:(NSString *)textStyle;

@end

#pragma mark - BNRDynamicTypeManager class extension

@interface BNRDynamicTypeManager ()

@property (nonatomic, strong) NSMapTable *elementToTupleTable;

@end

@implementation BNRDynamicTypeManager

#pragma mark - Singleton

+ (instancetype)sharedInstance
{
    static BNRDynamicTypeManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[BNRDynamicTypeManager alloc] init];
    });
    return sharedInstance;
}

#pragma mark - Class Methods

+ (NSString *)textStyleMatchingFont:(UIFont *)font
{
    static NSArray *textStyles;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        textStyles = @[UIFontTextStyleBody,
                       UIFontTextStyleCaption1,
                       UIFontTextStyleCaption2,
                       UIFontTextStyleFootnote,
                       UIFontTextStyleHeadline,
                       UIFontTextStyleSubheadline];
    });

    for (NSString *style in textStyles) {
        if ([font isEqual:[UIFont preferredFontForTextStyle:style]]) {
            return style;
        }
    }

    return nil;
}

#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        _elementToTupleTable = [NSMapTable weakToStrongObjectsMapTable];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(noteContentSizeCategoryDidChange:)
                                                     name:UIContentSizeCategoryDidChangeNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Public API

- (void)watchLabel:(UILabel *)label textStyle:(NSString *)style
{
    [self watchElement:label fontKeypath:BNRDynamicTypeManagerFontKeypathUILabel textStyle:style];
}

- (void)watchButton:(UIButton *)button textStyle:(NSString *)style
{
    [self watchElement:button fontKeypath:BNRDynamicTypeManagerFontKeypathUIButton textStyle:style];
}

- (void)watchTextField:(UITextField *)textField textStyle:(NSString *)style
{
    [self watchElement:textField fontKeypath:BNRDynamicTypeManagerFontKeypathUITextField textStyle:style];
}

- (void)watchTextView:(UITextView *)textView textStyle:(NSString *)style
{
    [self watchElement:textView fontKeypath:BNRDynamicTypeManagerFontKeypathUITextView textStyle:style];
}

- (void)watchElement:(id)element fontKeypath:(NSString *)fontKeypath textStyle:(NSString *)style
{
    if (!style) {
        style = [BNRDynamicTypeManager textStyleMatchingFont:[element valueForKeyPath:fontKeypath]];
    }
    if (fontKeypath && style) {
        [element setValue:[UIFont preferredFontForTextStyle:style] forKeyPath:fontKeypath];

        BNRDynamicTypeTuple *tuple = [[BNRDynamicTypeTuple alloc] initWithKeypath:fontKeypath textStyle:style];
        [self.elementToTupleTable setObject:tuple
                                     forKey:element];
    }
}

#pragma mark - Notifications

- (void)noteContentSizeCategoryDidChange:(NSNotification *)note // UIContentSizeCategoryDidChangeNotification
{
    NSMapTable *elementToTupleTable = self.elementToTupleTable;

    for (id element in elementToTupleTable) {
        BNRDynamicTypeTuple *tuple = [elementToTupleTable objectForKey:element];
        [element setValue:[UIFont preferredFontForTextStyle:tuple.textStyle] forKeyPath:tuple.keypath];
    }
}

@end

#pragma mark - BNRDynamicTypeTuple implementation

@implementation BNRDynamicTypeTuple

- (instancetype)initWithKeypath:(NSString *)keypath textStyle:(NSString *)textStyle
{
    self = [super init];
    if (self) {
        self.keypath = keypath;
        self.textStyle = textStyle;
    }
    return self;
}

@end
