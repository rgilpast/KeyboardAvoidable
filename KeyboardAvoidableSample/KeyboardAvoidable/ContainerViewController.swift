//
//  ContainerViewController.swift
//  KeyboardAvoidableSample
//
//  Created by Rafael Gil Pastor on 26/06/2019.
//  Copyright © 2019 Rafael Gil Pastor. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    @IBOutlet weak var scrollContainerView: UIView!
    @IBOutlet weak var tableContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollContainerView.isHidden = false
        tableContainerView.isHidden = true
    }
    
    @IBAction func segementedButtonChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex
        {
        case 0:
            scrollContainerView.isHidden = false
            tableContainerView.isHidden = true
        case 1:
            scrollContainerView.isHidden = true
            tableContainerView.isHidden = false
        default:
            break;
        }
    }
}
