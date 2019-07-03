//
//  ScrollViewController.swift
//  KeyboardAvoidableFields
//
//  Created by Rafael Gil Pastor on 21/06/2019.
//  Copyright © 2019 Rafael Gil Pastor. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {
    
    @IBOutlet weak var scrollViewOutlet: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerKeyboardNotifications()
    }
    
    deinit {
        unregisterKeyboardNotifications()
    }
    
}

extension ScrollViewController:  KeyboardAvoidable {

    var scrollView: UIScrollView {
        get {
            return scrollViewOutlet
        }
    }
    func keyboardWillShow(notification: Notification) {
        print("optional implementation for additional functionality of keyboardWillShow event")
    }
    
    func keyboardWillHide(notification: Notification) {
        print("optional implementation for additional functionality of keyboardWillHide event")
    }
}
