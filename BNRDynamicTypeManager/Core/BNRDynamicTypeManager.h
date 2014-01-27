//
//  BNRDynamicTypeManager.h
//  BNRDynamicTypeManager
//
//  Created by John Gallagher on 1/9/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 `BNRDynamicTypeManager` is a singleton class that watches elements (typically
 `UIView` subclasses) that have a font based on an iOS 7 Dynamic Type text
 Style, and it updates their fonts whenever the user changes the system font
 size.
 */

@interface BNRDynamicTypeManager : NSObject

///--------------------
/// @name Class methods
///--------------------

/**
 Returns the BNRDynamicTypeManager singleton.
 */
+ (instancetype)sharedInstance;

/**
 Determines which text style matches the given font.

 @warning This will only succeed if the font matches the CURRENT
   font returned by `UIFont +preferredFontForTextStyle:`. One
   case where this can fail is if you save off a `UIFont`, then
   adjust the system-wide dynamic type size, then pass the saved
   (but now "stale") font to this method.

 @param font The font to check against built-in text styles

 @return The matched text style, or `nil` if none was found.
 */
+ (NSString *)textStyleMatchingFont:(UIFont *)font;

///------------------------
/// @name Watching Elements
///------------------------

/**
 Start watching a UILabel. We will set its font to `[UIFont preferredFontForTextStyle:style]`
 now and any time the font size changes (i.e., when the app receives a `UIContentSizeCategoryDidChangeNotification`.

 We only hold a weak reference to `label`, so there is no equivalent "unwatch".

 @param label The UILabel to watch.
 @param style The text style to use. See "Text Styles" in `UIFontDescriptor Class Reference` for recognized values.
 */
- (void)watchLabel:(UILabel *)label textStyle:(NSString *)style;

/**
 Start watching a UIButton. We will set its font to `[UIFont preferredFontForTextStyle:style]`
 now and any time the font size changes (i.e., when the app receives a `UIContentSizeCategoryDidChangeNotification`.

 We only hold a weak reference to `button`, so there is no equivalent "unwatch".

 @param button The UIButton to watch.
 @param style The text style to use. See "Text Styles" in `UIFontDescriptor Class Reference` for recognized values.
 */
- (void)watchButton:(UIButton *)button textStyle:(NSString *)style;

/**
 Start watching a UITextField. We will set its font to `[UIFont preferredFontForTextStyle:style]`
 now and any time the font size changes (i.e., when the app receives a `UIContentSizeCategoryDidChangeNotification`.

 We only hold a weak reference to `textField`, so there is no equivalent "unwatch".

 @param textField The UITextField to watch.
 @param style The text style to use. See "Text Styles" in `UIFontDescriptor Class Reference` for recognized values.
 */
- (void)watchTextField:(UITextField *)textField textStyle:(NSString *)style;

/**
 Start watching a UITextView. We will set its font to `[UIFont preferredFontForTextStyle:style]`
 now and any time the font size changes (i.e., when the app receives a `UIContentSizeCategoryDidChangeNotification`.

 We only hold a weak reference to `textView`, so there is no equivalent "unwatch".

 @param textView The UITextView to watch.
 @param style The text style to use. See "Text Styles" in `UIFontDescriptor Class Reference` for recognized values.
 */
- (void)watchTextView:(UITextView *)textView textStyle:(NSString *)style;

/**
 Starts watching an element that has a `UIFont` that can be set and
 read via Key-Value Coding at the given keypath. We will set this font
 to `[UIFont preferredFontForTextStyle:style]` now and any time the
 font size changes.

 We hold only a weak reference to element, so there is no equivalent
 "unwatch".

 @param element An object that is KVC-compliant for the given keypath.
 @param fontKeypath The keypath that refers to a `UIFont`.
 @param style The text style to use for the element. See "Text Styles"
              in `UIFontDescriptor Class Reference` for recognized values.
 */
- (void)watchElement:(id)element fontKeypath:(NSString *)fontKeypath textStyle:(NSString *)style;

@end
