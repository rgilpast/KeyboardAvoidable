//
//  KeyBoardAvoidableProtocol.swift
//  KeyboardAvoidableFields
//
//  Created by Rafael Gil Pastor on 21/06/2019.
//  Copyright © 2019 Rafael Gil Pastor. All rights reserved.
//

import Foundation
import UIKit

public protocol KeyboardAvoidable  {
    
    var scrollView: UIScrollView! { get }
    func registerKeyboardNotifications()
    func unregisterKeyboardNotifications()
    func keyboardWillShow(notification: Notification)
    func keyboardWillHide(notification: Notification)
}

extension KeyboardAvoidable {
    
    public func registerKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification,
                                               object: nil, queue: OperationQueue.main,
                                               using: keyboardWillShowHandler(notification:))
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                               object: nil, queue: OperationQueue.main,
                                               using: keyboardWillHideHandler(notification:))
    }
    
    public func unregisterKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: Notification) {}
    func keyboardWillHide(notification: Notification) {}
}

private extension KeyboardAvoidable {
    
    private var screenHeight: CGFloat {
        
        get {
            let screenRect = UIScreen.main.bounds
            return screenRect.size.height
        }
    }
    
    private var scrollViewBottomPosition: CGFloat {
        get {
            let bottomPoint = CGPoint(x: scrollView.frame.maxX, y: scrollView.frame.maxY)
            let superView = scrollView.superview ?? scrollView
            return superView?.convert(bottomPoint, to: nil).y ?? 0
        }
    }
    
    private func keyboardWillShowHandler(notification: Notification) {
        
        let keyboardTopPosition = screenHeight - keyboardHeight(notification)
        let scrollViewCoveredHeight = scrollViewBottomPosition - keyboardTopPosition
        let yOffset = (scrollViewCoveredHeight > 0 ? scrollViewCoveredHeight : 0)
        
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: yOffset, right: 0)
        
        keyboardWillShow(notification: notification)
    }
    
    private func keyboardWillHideHandler(notification: Notification) {
        
        scrollView.contentInset = .zero
        
        keyboardWillHide(notification: notification)
    }
    
    private func keyboardHeight(_ notification: Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        var accessoryViewHeight: CGFloat = 0.0
        if let textField = scrollView.firstResponder as? UITextField {
            accessoryViewHeight = textField.inputAccessoryView?.bounds.height ?? 0.0
        }
        return keyboardSize.cgRectValue.height + accessoryViewHeight
    }
}

fileprivate extension UIView {
    
    var firstResponder: UIView? {
        guard !isFirstResponder else { return self }
        
        for subview in subviews {
            if let firstResponder = subview.firstResponder {
                return firstResponder
            }
        }
        return nil
    }
}
