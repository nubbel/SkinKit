# Warning: dead project!
This project is no longer maintained!


Introduction
============

SkinKit is an iOS-Framework that allows you to easily customize the appearance of your app. It provides a simple API for loading skins and helps you to quickly build custom app designs by making useful defaults.


Features
========

- Simple interface for loading skins.
- Skins encapsulate the appearance modifications that make your app look special.
- **Useful defaults**: When using `SKDefaultSkin` or a subclass, you don't need to specify every single property. Instead the skin makes useful assumptions by calculating colors based on properties you provide. For example, when the `baseTintColor` is specified the `backgroundColor` is *automagically* set to a lighter version of that color while the `tabBarTintColor` gets a darker one. To learn more about that magic, read the [Building skins](#building-skins) section.
- The framework allows customization of UI elements that don't support the `UIAppearance` proxy, such as setting the background color (or a pattern image) on a regular `UIView`. 
- Use bundles for your skins.


Installation
============

It's recommended to use a workspace where you put both your project and the **SkinKit** framework as siblings. It may also work if you put **SkinKit** as a subproject of your app, but I haven"t tested it yet.

Requirements
------------

- iOS 6.0 or newer
- Xcode 4.5 or newer

**Note**: The framework uses ARC. However, since it builds as a seperate target, you're not forced to use ARC in your main project.

Using a workspace
-----------------

1. Create a workspace in Xcode.
2. Copy your main project to the workspace or create a new one.
3. Add the SkinKit project (not the demo!) as a sibling to the workspace.
4. Drag the libSkinKit.a to your project's "Link Binary with Library" build phase.
5. Set header search path to: "$(BUILT\_PRODUCTS\_DIR)", check "recursive".
6. Add "Other linker flags": "-ObjC".


Usage
=====

Once you've successfully installed the framework, it can now be used in your project. It is useful to load the skin when the app has just started. To do so, import the framework to your AppDelegate class:

```objc
import <SkinKit/SkinKit.h>
```

Loading skins
-------------
A good place to load the skin for your app is in the `application:didFinishLaunchingWithOptions:` method of your AppDelegate:

```objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 1. get an instance of the shared skin manager
    SKSkinManager *skinManager = [SKSkinManager sharedSkinManager];
    
    // 2. set your custom skin subclass
    skinManager.skin = [[MyFancySkin alloc] init];
     
    // 3. finally apply customizations
    [skinManager applySkin];
    
    // Do your regular initialization here
     
    return YES;
}
```

This piece of code first retrieves an instance of the `SKSkinManager` class which is responsible for applying custom appearance modifications to your UI elements. It mainly relies on the `UIAppearance` proxy that was introduced in iOS 5.0 and further enhanced in iOS 6.0.  
The next step is to set a skin that should be used to modify the app's appearance. A skin functions as a data source (much like a `UITableViewDataSource`). The skin manager may ask the skin for colors to tint UI elements or for custom images to be used for the navigation bar or bar button items etc.. Learn more about skins and how to build them in the [Building skins](#building-skins) section.  
Finally call `applySkin` for the modifications to take effect.

### Customize views ###

Some UI elements (like a regular `UIView`, `UIScrollView` or `UITableView`) don't have a `UIAppearance` proxy. However **SkinKit** provides a way to do custom appearance modifications on these elements as well. One way to do this is to manually apply the skin to individual views:

```objc
// skin a UIView
[[[SKSkinManager] sharedSkinManager] applySkinToView:theView];

// skin a UIScrollView
[[[SKSkinManager] sharedSkinManager] applySkinToScrollView:theScrollView];

// skin a UITableView
[[[SKSkinManager] sharedSkinManager] applySkinToTableView:theTableView];
```

This gives you fine granular control of the views you want to customize, but requires a lot of code.  
If, for example, you wish to set the background color of all "top-level" views, i.e. the views that are directly associated to a `UIViewController`, there's also a handy way to do this:

```obj
[SKSkinManager sharedSkinManager].automaticallyApplySkinForViews = YES;
```

This works by having a category on `UIViewController` automatically call the methods shown above (`applySkinTo*View`) on the view controller's root view.


Building skins
--------------

This is actually the fun part!  
A skin could be created in three ways:

1. Create a class that implements the `SKSkinDataSource` protocol.
2. Create a bundle and provide your customizations in the bundle's Info.plist file.
3. Mix the above two approaches!

### SKSkinDataSource ###

You can build a new skin by creating a class that conforms to the `SKSkinDataSource` protocol. The protocol defines a list of methods that you need to implement in order that the skin manager (`SKSkinManager`) knows how to customize your UI. You can use an arbitrary class (such as your app delegate) that implements the protocol, but it's strongly recommended to use a separate class for this purpose that could also be reused in a future project.

For convenience, **SkinKit** provides two classes that already implement the `SKSkinDataSource` protocol:

1. `SKSkin` loads values from the skin's bundle Info.plist file if available, otherwise returns nil for all attributes.
2. `SKDefaultSkin` is a subclass of `SKSkin` that makes useful assumptions, such as calculating the background color from the base tint color. 

You should prefer using one of these two classes over creating a new that implements the protocol and only override the methods you need.

### Using bundles ###

A bundle is a special kind of folder that has the extension `.bundle`. If you plan to use images for your skin, a bundle is required. The bundle must have the following structure:

```
MyFancySkin.bundle/Contents
MyFancySkin.bundle/Contents/Info.plist (optional)
MyFancySkin.bundle/Contents/Resources (place your image files here, optional)
```

**Note**: If your skin class is named `MyFancySkin` the bundle name must be `MyFancySkin.bundle`. However, you don't even need a separate class for your skin, if you instantiate it like this: `id<SKSkinDataSource> skin = [[SKSkin alloc] initWithBundleName:@"MyFanceBundleOnlySkin"]` or `id<SKSkinDataSource> skin = [[SKDefaultSkin alloc] initWithBundleName:@"MyFanceBundleOnlySkin"]`.

The `Info.plist` file can be used to specify custom appearance attributes (currently only color values are supported) by providing a dictionary named `SKSkinDataSource`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleIdentifier</key>
	<string>SkinKit.Skin.MyFancySkin</string>
	<key>CFBundleName</key>
	<string>MyFancySkin</string>
	<key>SKSkinDataSource</key>
	<dict>
		<key>controlBaseTintColor</key>
		<dict>
			<key>name</key>
			<string>orange</string>
		</dict>
		<key>backgroundColor</key>
		<dict>
			<key>hsb</key>
			<dict>
				<key>h</key>
				<string>0.7</string>
				<key>s</key>
				<string>0.2</string>
				<key>b</key>
				<string>0.7</string>
				<key>a</key>
				<string>1.0</string>
			</dict>
		</dict>
		<key>accentTintColor</key>
		<dict>
			<key>hex</key>
			<string>#df4</string>
		</dict>
		<key>baseTintColor</key>
		<dict>
			<key>rgb</key>
			<string>1.0 0.3 0.5</string>
		</dict>
	</dict>
</dict>
</plist>

```

See further sections for a complete list of available style attributes.  
As shown in the example above, color values can be specified in several ways:

- RGB string: "red green blue" or "red green blue alpha"
- RGB dictionary with keys "r", "g", "b", "a" (optional)
- HSB string: "hue saturation brightness" or "hue saturation brightness alpha"
- HSB dictionary with keys "h", "s", "b", "a" (optional)
- Hex string: "rrggbb", "rrggbbaa", "rgb", "rgba". Optionally with leading "#" or "0x".
- Name: e.g. "red" or "darkGray". See [here](http://developer.apple.com/library/ios/documentation/UIKit/Reference/UIColor_Class/Reference/Reference.html#//apple_ref/doc/uid/TP40006892-CH3-SW18) for a list of color names (just omit the "Color" suffix).

All color components must be float values between `0.0f` and `1.0f`.
The alpha component is optional and defaults to `1.0f`.

Skinnable UI elements
=====================

### General attributes ###

Method        | Declared in | Meaning | SKSkin | SKDefaultSkin
------------- | ----------- | ------- | ------ | ------------- 
(UIColor *)baseTintColor | `SKSkinDataSource` | The base tint color for this skin, used as a base for other attributes. | from `Info.plist`. | average color from navigation bar image
(UIColor *)accentTintColor | `SKSkinDataSource` | The accent color (used for highlights etc.). | from `Info.plist`. | -
(UIColor *)backgroundColor | `SKSkinDataSource` | The background color (or pattern image) for views. | from `Info.plist`. | lighten(baseTintColor)
(UIImage *)shadowTopImage | `SKSkinDataSource` | The top shadow for bar elements. | nil | imageNamed(shadowTopImageName)
(UIImage *)shadowBottomImage | `SKSkinDataSource` | The bottom shadow for bar elements. | nil | imageNamed(shadowBottomImageName)
(NSString *)shadowTopImageName | `SKDefaultSkin` | Image name for top shadow. | - | "shadowTop"
(NSString *)shadowBottomImageName | `SKDefaultSkin` | Image name for bottom shadow. | - | "shadowBottom"
(NSString *)stringFromControlState:(UIControlState)state | `SKSkin` | String for control state. | "", "Highlighted", "Selected", "Disabled" | -
(NSString *)stringFromBarMetrics:(UIBarMetrics)barMetrics | `SKSkin` | String for bar metrics. | "", "Landscape" | -
(NSString *)stringFromBarButtonItemStyle:(UIBarButtonItemStyle)style | `SKSkin` | String for bar button item style. | "", "Done" | -
(NSString *)stringFromToolbarPosition:(UIToolbarPosition)position | `SKSkin` | String for toolbar position. | "", "Top", "Bottom" | -

### UITabBar ###

Method        | Declared in | Meaning | SKSkin | SKDefaultSkin
------------- | ----------- | ------- | ------ | ------------- 
(UIColor *)tabBarTintColor | `SKSkinDataSource` | The tab bar tint color. Dark colors look better. | from `Info.plist`. | darken(baseTintColor)
(UIImage *)tabBarBackgroundImage | `SKSkinDataSource` | The tab bar background image. | nil | imageNamed(tabBarBackgroundImageName)
(UIImage *)tabBarSelectionIndicatorImage | `SKSkinDataSource` | An image that indicates the selected tab bar item. | nil | imageNamed(tabBarSelectionIndicatorImageName)
(UIColor *)tabBarSelectedImageTintColor | `SKSkinDataSource` | The tint color of the selected tab bar item image. | from `Info.plist`. | accentColor
(NSString *)tabBarSelectionIndicatorImageName | `SKDefaultSkin` | Image name for tab bar background. | - | "tabBarBackground"
(NSString *)tabBarSelectionIndicatorImageName | `SKDefaultSkin` | Image name for selection indicator. | - | "tabBarSelectionIndicator"


### UINavigationBar ###

Method        | Declared in | Meaning | SKSkin | SKDefaultSkin
------------- | ----------- | ------- | ------ | ------------- 
(UIColor *)navigationBarTintColor | `SKSkinDataSource` | The navigation bar tint color. | from `Info.plist`. | baseTintColor
(UIImage *)navigationBarBackgroundImageForBarMetrics:(UIBarMetrics)barMetrics | `SKSkinDataSource` | The navigation bar background image for given bar metrics. | nil | imageNamed(navigationBarBackgroundImageName + str(barMetrics))
(NSDictionary *)navigationBarTitleTextAttributes | `SKSkinDataSource` | A dictionary containing text attributes. See [UITextAttributes](http://developer.apple.com/library/ios/documentation/uikit/reference/NSString_UIKit_Additions/Reference/Reference.html#//apple_ref/doc/uid/TP40006893-CH3-DontLinkElementID_3). | nil | -
(NSString *)navigationBarBackgroundImageName | `SKDefaultSkin` | Image name for navigation bar background. | - | "navigationBarBackground"


### UIToolbar ###

Method        | Declared in | Meaning | SKSkin | SKDefaultSkin
------------- | ----------- | ------- | ------ | ------------- 
(UIColor *)toolbarTintColor | `SKSkinDataSource` | The toolbar tint color. | from `Info.plist`. | baseTintColor
(UIImage *)toolbarBackgroundImageForToolbarPosition:(UIToolbarPosition)pos barMetrics:(UIBarMetrics)barMetrics | `SKSkinDataSource` | The toolbar background image for given position and bar metrics. | nil | imageNamed(toolbarBackgroundImageName + str(pos) + str(barMetrics))
(NSString *)toolbarBackgroundImageName | `SKDefaultSkin` | Image name for toolbar background. | - | "toolbarBackground"


### UISearchBar ###

Method        | Declared in | Meaning | SKSkin | SKDefaultSkin
------------- | ----------- | ------- | ------ | ------------- 
(UIColor *)searchBarTintColor | `SKSkinDataSource` | The search bar tint color. | from `Info.plist`. | baseTintColor
(UIImage *)searchBarBackgroundImage | `SKSkinDataSource` | The search bar background image. | nil | imageNamed(searchBarBackgroundImageName)
(NSString *)searchBarBackgroundImageName | `SKDefaultSkin` | Image name for search bar background. | - | "searchBarBackground"


### UIBarButtonItem ###

Method        | Declared in | Meaning | SKSkin | SKDefaultSkin
------------- | ----------- | ------- | ------ | ------------- 
(UIColor *)barButtonItemTintColor | `SKSkinDataSource` | The bar button item tint color. | from `Info.plist`. | baseTintColor
(UIImage *)barButtonItemBackgroundImageForState:(UIControlState)state style:(UIBarButtonItemStyle)style barMetrics:(UIBarMetrics)barMetrics | `SKSkinDataSource` | The bar button item background image for given control sate, button style and bar metrics. | nil | imageNamed(barButtonItemBackgroundImageName + str(style) + str(state) + str(barMetrics))
(UIImage *)backBarButtonItemBackgroundImageForState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics | `SKSkinDataSource` | The back bar button item background image for given control sate and bar metrics. | nil | imageNamed(backBarButtonItemBackgroundImageName + str(state) + str(barMetrics))
(NSDictionary *)barButtonItemTitleTextAttributesForState:(UIControlState)state | `SKSkinDataSource` | A dictionary containing text attributes for a given control state. See [UITextAttributes](http://developer.apple.com/library/ios/documentation/uikit/reference/NSString_UIKit_Additions/Reference/Reference.html#//apple_ref/doc/uid/TP40006893-CH3-DontLinkElementID_3). | nil | -
(NSString *)barButtonItemBackgroundImageName | `SKDefaultSkin` | Image name for bar button item background. | - | "barButtonItemBackground"
(NSString *)backBarButtonItemBackgroundImageName | `SKDefaultSkin` | Image name for back bar button item background. | - | "backBarButtonItemBackground"


### UITableView ###

Method        | Declared in | Meaning | SKSkin | SKDefaultSkin
------------- | ----------- | ------- | ------ | ------------- 
(UIImage *)tableViewBackgroundImage | `SKSkinDataSource` | The table view background image. | nil | imageNamed(tableViewBackgroundImageName)
(NSString *)tableViewBackgroundImageName | `SKDefaultSkin` | Image name for table view background. | - | "tableViewBackground"


### UIScrollView ###

Method        | Declared in | Meaning | SKSkin | SKDefaultSkin
------------- | ----------- | ------- | ------ | ------------- 
(NSValue *)scrollViewContentInsets | `SKSkinDataSource` | The scroll view content insets as `NSValue` wrapping a `UIEdgeInset` struct. | nil | -



### Controls ###

Skinnable controls: `UISwitch`, `UIStepper`, `UISegmentedControl`, `UISlider`, `UIProgressView`

Method        | Declared in | Meaning | SKSkin | SKDefaultSkin
------------- | ----------- | ------- | ------ | ------------- 
(UIColor *)controlBaseTintColor | `SKSkinDataSource` | The control base tint color. | from `Info.plist`. | baseTintColor
(UIColor *)controlAccentTintColor | `SKSkinDataSource` | The control accent tint color. | from `Info.plist`. | accentTintColor
(UIColor *)controlThumbTintColor | `SKSkinDataSource` | The control thumb tint color. | from `Info.plist`. | baseControlTintColor


Planned features and improvements
=================================

- Shared skins.
- Custom layout.
- `UICollectionView` customization (appearance and layout). 
- Skin generator companion app for Mac or iOS.
- CSS files.


Motivation
==========

The **SkinKit** framework is the result of a seminar ([iOS Advanced Topics](http://wwwbruegge.in.tum.de/static/lehrstuhl_1/teaching/timeline-st12/411-advanced-topics-in-ios)) at the Technical University Munich in summer 2012. The challenge was to create an open-source-licensed iOS framework that builds as a static library.  
// TODO: more information


License
=======

**SkinKit** is released under the MIT license:

```
Copyright (c) <2012> <Dominique d'Argent>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
