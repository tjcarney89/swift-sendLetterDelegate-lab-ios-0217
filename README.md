# Send Letter Delegate

## Objectives

1. Define a protocol that will be used by a `UIViewController` through an instance property on the `UIViewController` called `delegate`.
2. Use this property called `delegate` to call on the function available to this `delegate` instance property.
3. A _separate_ `UIViewController` should adopt and conform to this protocol. This instance of the _separate_ `UIViewController` will ultimately become the value to the `delegate` instance property on the other `UIViewController`.

In this fictitious scenario, `NewYorkViewController` sends a package to `LondonViewController`. The successful completion of the segue from `NewYorkViewController` to `LondonViewController` indicates that the package was received. The `LondonViewController` has a text view to write a thank you note that will be sent back to `NewYorkViewController`.

The goal of the lab is to define a protocol that contains a function. This function should be called via an instance property in `LondonViewController`. The function call will pass the thank you note (a text string from the text view) back to `NewYorkViewController`. `NewYorkViewController` will adopt and conform to the protocol in order to update the view to display the thank you note (the passed text string).

**NOTE:** _The following note does not impact the objectives of this lab._ The `LondonViewController` uses the iPhone `UIKeyboard` to allow the user to write text. View elements within the `LondonViewController` adjust position and appearance based on the entry and exit of the keyboard on the view. Using the hardware keyboard instead of the simulator iPhone `UIKeyboard` will change the intended behavior of the view elements but the general functionality of the controller will remain intact.

## Instructions

#### 1. Build and run the application to familiarize yourself with the flow

 The `NewYorkViewController` has a send button that triggers an animation and a segue to the `LondonViewController`. The user is then prompted to write a thank you note in the text view to send back to the `NewYorkViewController`. The send button in the `LondonViewController` will not appear unless the user enters at least one character in the text view.

#### 2. Declare a protocol above the `LondonViewController` class

 * Declare and define a protocol named,  `LondonViewControllerDelegate`.
 * Declare a function in the protocol named, `letterSent(from:message:)` where `from:` is of type `LondonViewController` and `message:` is of type `String`.
 * Limit the protocol to class types.
  * This is a class-only protocol meaning its adoption should be limited to class types. Go to [Apple's documentation](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Protocols.html) and find the section labeled, "Class-Only Protocols", to see how and why it's done. It's needed in part to use a weak reference to a delegate instance property.

#### 3. Add an instance property to `LondonViewController` of type `LondonViewControllerDelegate`

 * Name the instance property `delegate`. The property should be `weak` and the type should be marked optional.
  * The `weak` part of the declaration is to remove the chance of a strong reference cycle. Understanding `strong` versus `weak` and the dangers of retain cycles is beyond the scope of this lab. You can check out [Apple's documentation](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html) to learn more about this topic.

#### 4. Use the `delegate` property to call the protocol function

 * Call `letterSent(from:message:)` inside `sendButtonTapped(_:)` using the delegate property. The text from the text view is the argument for the message parameter.

#### 5. Adopt and conform to `LondonViewControllerDelegate` in `NewYorkViewController`

 * Add `LondonViewControllerDelegate` to the `NewYorkViewController` class declaration.
 * Adopt the `LondonViewController` delegate property.
  * `NewYorkViewController` needs to adopt the delegate but when and where should that happen? You could declare an instance of `LondonViewController` in `viewDidLoad()` to access the delegate property BUT that would not be the same instance created during the segue.
 * Define the `letterSent(from:message:)` delegate function.
  * Update `letterTextView.text` with the passed message.
  * Unhide `receivedHeaderLabel`.
  * Unhide `letterTextView`.
  * Hide `packageImageView`.
  * Hide `sendButton`.
 * Build and run the application. You should be able to see the thank you note written in `LondonViewController` in `NewYorkViewController` after `LondonViewController` is dismissed.
