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
    
    var scrollView: UIScrollView { get }
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
            return superView.convert(bottomPoint, to: nil).y
        }
    }

    private var firstResponderBottomPosition: CGFloat {
        get {
            guard let responder = scrollView.firstResponder else {
                return 0
            }
            let bottomPoint = CGPoint(x: responder.frame.maxX, y: responder.frame.maxY)
            let superView = responder.superview ?? responder
            return superView.convert(bottomPoint, to: nil).y
        }
    }

    private func keyboardWillShowHandler(notification: Notification) {
        
        let yOffset = calculateYOffset(withKeyboardNotification: notification)
        scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: scrollView.contentOffset.y + yOffset)
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: yOffset, right: 0)
        
        keyboardWillShow(notification: notification)
    }
    
    private func keyboardWillHideHandler(notification: Notification) {
        
        let yOffset = calculateYOffset(withKeyboardNotification: notification)
        scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: scrollView.contentOffset.y - yOffset)
        scrollView.scrollIndicatorInsets = .zero

        keyboardWillHide(notification: notification)
    }
    
    private func calculateYOffset(withKeyboardNotification keyboardNotification: Notification) -> CGFloat {
        
        var yOffset: CGFloat = .zero
        
        if let firstResponder = scrollView.firstResponder {
            
            let keyboardHeight = calculateKeyboardHeight(keyboardNotification, withFirstResponder: firstResponder)
            let keyboardTopPosition = screenHeight - keyboardHeight
            let coveredAreaHeight = firstResponder.maxGlobalPosition.y - keyboardTopPosition
            yOffset = coveredAreaHeight > 0 ? coveredAreaHeight : 0
        }

        return yOffset
    }
    
    private func calculateKeyboardHeight(_ notification: Notification, withFirstResponder responder: UIResponder?) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        let accessoryViewHeight = responder?.inputAccessoryView?.bounds.height ?? 0.0
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
    
    var maxGlobalPosition: CGPoint {

        let bottomPoint = CGPoint(x: self.frame.maxX, y: self.frame.maxY)
        let superView = self.superview ?? self
        return superView.convert(bottomPoint, to: nil)
    }
}
