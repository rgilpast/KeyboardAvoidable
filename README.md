
KeyboardAvoidable
==================

Swift protocol based solution for avoiding text fields or text views be covered by keyboard in iOS, when they get the edition focus

Introduction
------------

This is a light and very simple solution to enable, any view controller with a scroll view (or table view),  the ability of every text field or text view move out of the way of the keyboard when editing.

Usage
-----

For use with view controllers or views, with a scroll or table view inside, drop `KeyboardAvoidable.swift` into your project. 

Make you view controller (or view) class implements the protocol `KeyboardAvoidable`.

Define a computed property called `scrollView` to return the scrollview (or tableview) subview you want add this funcionality.

Call the method `registerKeyboardNotifications()` before the scrollview be displayed.

Call the method `unregisterKeyboardNotifications()` when you don´t want this funcionality any more.

Optionally you can add additional implementation for `keyboardWillShow` and `keyboardWillHide` events, writing the related functions in your view controller class.

You can open and test an example XCode project under `KeyboardAvoidableSample` directory. 

------------

Rafael Gil
rgilpast@gmail.com
