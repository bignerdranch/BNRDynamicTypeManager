# BNRDynamicTypeManager

[![Version](http://cocoapod-badges.herokuapp.com/v/BNRDynamicTypeManager/badge.png)](http://cocoadocs.org/docsets/BNRDynamicTypeManager)
[![Platform](http://cocoapod-badges.herokuapp.com/p/BNRDynamicTypeManager/badge.png)](http://cocoadocs.org/docsets/BNRDynamicTypeManager)
[![Build Status](https://travis-ci.org/bignerdranch/BNRDynamicTypeManager.png)](https://travis-ci.org/bignerdranch/BNRDynamicTypeManager)

BNRDynamicTypeManager is a collection of helper classes that make it easier to use Dynamic Type in iOS 7 applications. Most importantly, it handles listening for  `UIContentSizeCategoryDidChangeNotification` and updating the fonts of all "watched" views automatically.

To run the example project, clone the repo, make sure the Example target is selected, and run it.

To run the unit tests, run `pod install` from the Tests directory first.

## Usage - XIB Files and Storyboards

The simplest use case is if your are using XIB files or storyboards. After pulling BNRDynamicTypeManager into your project, change any instances of the following classes to the appropriate BNRDynamicTypeManager-provided subclasses (and make sure that one of the system Text Styles is selected as the view's font):

* `UILabel` → `BNRDynamicTypeManagedLabel`
* `UIButton` → `BNRDynamicTypeManagedButton`
* `UITextField` → `BNRDynamicTypeManagedTextField`
* `UIView` → `BNRDynamicTypeManagedView`

## Usage - Programmatic View Creation

If you are creating views programmatically, use the same class mapping from Using XIB Files above, and use the designated initializer from their header files. The initializers have the same arguments as the UIKit parents with an additional `textStyle:` argument. For example, creating a managed UILabel and UITextView:

```objective-c
#include <BNRDynamicTypeManager/BNRDynamicTypeManagedLabel.h>
#include <BNRDynamicTypeManager/BNRDynamicTypeManagedButton.h>
#include <BNRDynamicTypeManager/BNRDynamicTypeManagedTextField.h>
#include <BNRDynamicTypeManager/BNRDynamicTypeManagedTextView.h>

UILabel *label = [[BNRDynamicTypeManagedLabel alloc]
                       initWithFrame:CGRectZero
                           textStyle:UIFontTextStyleBody];
UIButton *button = [[BNRDynamicTypeManagedButton alloc]
                         initWithFrame:CGRectZero
                             textStyle:UIFontTextStyleBody];
UITextField *textField = [[BNRDynamicTypeManagedTextField alloc]
                               initWithFrame:CGRectZero
                                   textStyle:UIFontTextStyleFootnote];
UITextView *textView = [[BNRDynamicTypeManagedTextView alloc]
                             initWithFrame:CGRectZero
                             textContainer:nil
                                 textStyle:UIFontTextStyleFootnote];
```

## Usage - Without UIKit Subclasses

If you want more explicit control (e.g., if you already have a UIKit subclass that you're using, but you'd still like to have the font managed for you), use `BNRDynamicTypeManager` directly by telling it what objects to watch. If the object is one of the known UIKit classes or a subclass of them, use the provided methods. E.g., for `UILabel`:

```objective-c
#include <BNRDynamicTypeManager/BNRDynamicTypeManager.h>

UILabel *label = /* create a label */;

// Tell BNRDynamicTypeManager to update label.font now and any time the user
// changes their font size.
[[BNRDynamicTypeManager sharedInstance] watchLabel:label
                                         textStyle:UIFontTextStyleBody];
```

If you want to watch an object that isn't one of the known `UIKit` classes, but has a `UIFont *font` that can be reached via a keypath, use `watchElement:fontKeypath:textStyle:` instead. E.g., if there wasn't a method provided for `UIButton`:

```objective-c
#include <BNRDynamicTypeManager/BNRDynamicTypeManager.h>

UIButton *button = /* create a button */;

[[BNRDynamicTypeManager sharedInstance] watchElement:button
                                         fontKeypath:@"titleLabel.font"
                                           textStyle:UIFontTextStyleBody];
```

## Requirements

iOS 7 and ARC.

## Installation with CocoaPods

BNRDynamicTypeManager is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "BNRDynamicTypeManager", "~> 0.1.0"

## Installation without CocoaPods

Grab the class files (header and implementation) from the `BNRDynamicTypeManager/Core` and `BNRDynamicTypeManager/Controls` directory and copy them into your project.
## Author

John Gallagher, jgallagher@bignerdranch.com

## License

BNRDynamicTypeManager is available under the MIT license. See the LICENSE file for more info.
