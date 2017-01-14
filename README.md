# PKToast
Simple to use and customizable toast/notifications for iOS
======================

This library provides an easy to use class to show little notification/toast views at the bottom of the screen.

The notifications hide with fadding animation after the specified time duration.

It is very easy to add new notification.

**Take a look at the Example project to see how to use this library.** 


# Installation

## Manually
Copy the source files PKToast and PKToastView into your project.


# Usage

To show notifications just call the show method of PKToast class, as the following code: 

`PKToast.shared.show(message: "You message goes here", animated: true)`


The following properties can be change (in PKToast class) to customize the toast view:

* **messageFont**: The font will use for the message in toast view.
* **messageTextColor**: The text color of the toast text.
* **backColor**: The background color of the toast view.
* **borderColor**: The border color of the toast view.
* **borderWidth**: The border width of the toast view.
* **messageInset**: The insets of the text in the toast view.


# License
PKToast is available under the MIT license. See the LICENSE file for more information.
