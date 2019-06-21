
KeyboardAvoidable
==================

Swift protocol based solution for avoiding text fields be covered by keyboard in iOS, when they get the edition focus

Introduction
------------

This is a light and very simple solution to enable, any view controller with a scroll view (or table view),  the ability of every text field move out of the way of  the keyboard when editing.

Usage
-----

For use with `UITableViewController` or `UIViewController` with a scroll view classes, drop `KeyboardAvoidable.swift` into your project. 

Make you view controller class implements the protocol  `KeyboardAvoidable`.

Optionally you can add additional implementation for `keyboardWillShow` and `keyboardWillHide` events, writing the related functions in your view controller class.

You can open and test an example XCode project under `KeyboardAvoidableSample` directory. 

------------

Rafael Gil
rgilpast@gmail.com
