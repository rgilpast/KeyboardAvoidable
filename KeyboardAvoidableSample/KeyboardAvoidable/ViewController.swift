//
//  ViewController.swift
//  KeyboardAvoidableFields
//
//  Created by Rafael Gil Pastor on 21/06/2019.
//  Copyright © 2019 Rafael Gil Pastor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerKeyboardNotifications()
    }
    
    deinit {
        unregisterKeyboardNotifications()
    }
    
}


extension ViewController:  KeyboardAvoidable {

    func keyboardWillShow(notification: Notification) {
        print("optional implementation for additional functionality of keyboardWillShow event")
    }
    
    func keyboardWillHide(notification: Notification) {
        print("optional implementation for additional functionality of keyboardWillHide event")
    }
}
