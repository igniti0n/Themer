

#                                           T̼̼̖̾͟͞h̨͚͚͖ͯ̒̄͗͞ḛ̡̰̳͓̥ͬ͋ͪͧm̰̰̹͚̙̂ͦ͗͠ḛ̡̰̳͓̥ͬ͋ͪͧṛ̣̬̫̍͌ͩ͟


[![Version](https://img.shields.io/cocoapods/v/Themer.svg?style=flat)](https://cocoapods.org/pods/Themer)
[![License](https://img.shields.io/cocoapods/l/Themer.svg?style=flat)](https://cocoapods.org/pods/Themer)
[![Platform](https://img.shields.io/cocoapods/p/Themer.svg?style=flat)](https://cocoapods.org/pods/Themer)

Themer enabels you to switch between light, dark and system default theme modes, gives you default themed classes of each view and allowing you define all assets (color, border color, font, border width...) for them, as well as giving you the option to make your own custom themed views and their assets. Moves code from your view by defining their looks from one place and makes changes to styling easy.

## Installation

Themer is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Themer'
```

## Features

- [x] switching between light / dark / system default
- [x] animated theme changes
- [x] listening to theme changes
- [x] themed views, not just colors and fonts
- [x] adding multiple custom themed views

## How to use it

Themer is straight forward to use, setup your themes and apply whatever theme you want!

#### Setup a theme

Define your themes by inheriting from 'ApplicationTheme'. It enabels you to define many different assets for your themed views in that theme.

```swift
class DarkTheme: ApplicationTheme {
    var theme: Theme = Theme(
        assets: ThemeAssets(
            labelAssets: LabelAssets(
                color: .orange,
                font: .systemFont(ofSize: 48),
                backgroundColor: .white
            ),
            buttonAssets: ButtonAssets(
                buttonColor: .black,
                titleColor: .white,
                font: .systemFont(ofSize: 28),
                cornerRadius: 80,
                borderColor: .systemPurple
            ),
            imageViewAssets: ImageViewAssets(
                tintColor: .systemRed
            )))
}

class LightTheme: ApplicationTheme {
            var theme: Theme = DarkTheme().theme.copyWith(ThemeAssets(
                labelAssets: LabelAssets(
                    color: .blue
                )))
```

In your app, as soon as possible, setup your theme and apply it!

```swift
        Themer.shared.setup(lightTheme: LightTheme(), darkTheme: DarkTheme())
        Themer.shared.apply(.dark)
```

Anywhere in your application, you can apply a theme and your app theme will change. You can also use animations
when applying a theme.

```swift
        Themer.shared.apply(.systemDefault, withAnimation: ThemeAnimationSettings(duration: 0.4, delay: 0, animationOptions: .transitionFlipFromTop))
```

#### Use themed views in your view

In your theme, all assets correspond to their themed versions. So, 'ButtonAssets' define how 'ThemedButton' looks like.

Instead

```swift
    let button = UIButton()
```

Use

```swift
    let button = ThemedButton()
```

'ThemedButton' is just like a normal UIButton, but all the properties from 'ButtonAssets' will be applied to it. So, you  don't need any styling
for it anywhere. 

#### NavigationBarAssets

NavigationBarAssets are initialized differently than other assets. All three appearance's need to be accounted for: standard, compact and scroll edge. You  are given a closure for each one, with a paramater being an instance of the 'UINavigationBarAppearance' that you can change properties on for each appearance, everything else is the same

```swift
            navigationBarAssets: NavigationBarAssets(standardApprance: { appearance in
                appearance.backgroundColor = .blue
                appearance.titleTextAttributes = [.font : UIFont.systemFont(ofSize: 28), .foregroundColor : UIColor.purple]
            }, scrollEdgeApperance: { appearance in
                appearance.titleTextAttributes = [.font : UIFont.systemFont(ofSize: 24), .foregroundColor : UIColor.yellow]
            }, compactApperance: { appearance in
                appearance.titleTextAttributes = [.font : UIFont.systemFont(ofSize: 20), .foregroundColor : UIColor.blue]
            }
```

## Listen to theme changes

Anywhere in your application, you can listen to theme changes  using 'NotificationCenter'

```swift
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(onThemeChanged), name: Themer.notificationName, object: nil)
```

## Custom themed views

Out of the box, from Themer,  you get themed view like ThemedButton, ThemedNavigationBar, ThemedLabel... But, what if you want  2 or 3 different
styles fo buttons in light and dark theme? No problem, just add custom themed and attach assets to them.

#### Create a themed view, by extending one of the 'Themable' prefixed protocols.

```swift
        class CustomThemedButton: ThemableButton {}
```

#### Add assets for that custom themed view to light, dark or both themes.

```swift
        Themer.shared.addCustomAssets(to: .both, asset: ButtonAssets<CustomThemedButton>(buttonColor: .systemBrown))
```

#### Use it!

```swift
    let button = CustomThemedButton()
```

## Author

igniti0n, ivanat735@gmail.com

## License

Themer is available under the MIT license. See the LICENSE file for more info.



