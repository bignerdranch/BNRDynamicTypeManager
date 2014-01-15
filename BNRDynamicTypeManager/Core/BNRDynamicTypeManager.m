//
//  BNRDynamicTypeManager.m
//  BNRDynamicTypeManager
//
//  Created by John Gallagher on 1/9/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRDynamicTypeManager.h"

@interface KeypathTextStyle : NSObject

@property (nonatomic, copy) NSString *keypath;
@property (nonatomic, copy) NSString *style;

- (instancetype)initWithKeypath:(NSString *)keypath textStyle:(NSString *)style;

@end

@implementation KeypathTextStyle

- (instancetype)initWithKeypath:(NSString *)keypath textStyle:(NSString *)style
{
    self = [super init];
    if (self) {
        self.keypath = keypath;
        self.style = style;
    }
    return self;
}

@end

@interface BNRDynamicTypeManager ()

@property (nonatomic, strong) NSMapTable *fontTable;
@property (nonatomic, strong) NSMapTable *customKeypathTable;

@end

@implementation BNRDynamicTypeManager

+ (instancetype)sharedInstance
{
    static BNRDynamicTypeManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[BNRDynamicTypeManager alloc] init];
    });
    return sharedInstance;
}

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

- (instancetype)init
{
    self = [super init];
    if (self) {
        _fontTable = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsWeakMemory
                                               valueOptions:NSPointerFunctionsCopyIn
                                                   capacity:0];
        _customKeypathTable = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsWeakMemory
                                                        valueOptions:NSPointerFunctionsStrongMemory
                                                            capacity:0];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(noteUIContentSizeCategoryDidChange:)
                                                     name:UIContentSizeCategoryDidChangeNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)noteUIContentSizeCategoryDidChange:(NSNotification *)note
{
    for (id element in self.fontTable) {
        NSString *style = [self.fontTable objectForKey:element];
        [element setFont:[UIFont preferredFontForTextStyle:style]];
    }
    for (id element in self.customKeypathTable) {
        KeypathTextStyle *tuple = [self.customKeypathTable objectForKey:element];
        [element setValue:[UIFont preferredFontForTextStyle:tuple.style] forKeyPath:tuple.keypath];
    }
}

- (void)watchElement:(id)elementWithFont textStyle:(NSString *)style
{
    [elementWithFont setFont:[UIFont preferredFontForTextStyle:style]];
    [self.fontTable setObject:style forKey:elementWithFont];
}

- (void)watchElement:(id)element fontKeypath:(NSString *)fontKeypath textStyle:(NSString *)style
{
    [element setValue:[UIFont preferredFontForTextStyle:style] forKeyPath:fontKeypath];
    KeypathTextStyle *tuple = [[KeypathTextStyle alloc] initWithKeypath:fontKeypath textStyle:style];
    [self.customKeypathTable setObject:tuple forKey:element];
}

@end
