//
//  SecondViewController.swift
//  Buttons
//
//  Created by Egor Mezhin on 05.07.2023.
//

import UIKit

class SecondViewController: UIViewController {
    
    weak var delegate: SecondViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.tintAdjustmentMode = .dimmed
        view.backgroundColor = .orange
        
    }
}

protocol SecondViewControllerDelegate: AnyObject {
    func setDefaultButtons()
}

