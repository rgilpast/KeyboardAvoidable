//
//  TableViewController.swift
//  KeyboardAvoidableSample
//
//  Created by Rafael Gil Pastor on 26/06/2019.
//  Copyright © 2019 Rafael Gil Pastor. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerKeyboardNotifications()
        
    }
    
    deinit {
        unregisterKeyboardNotifications()
    }
}

extension TableViewController:  KeyboardAvoidable {
    
    var scrollView: UIScrollView {
        get {
            return tableView
        }
    }
    func keyboardWillShow(notification: Notification) {
        print("optional implementation for additional functionality of keyboardWillShow event")
    }
    
    func keyboardWillHide(notification: Notification) {
        print("optional implementation for additional functionality of keyboardWillHide event")
    }
}

extension TableViewController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = (indexPath.row % 2) == 0 ? "TextfieldCell" : "TextviewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
}

extension TableViewController:  UITableViewDelegate {
    
}
