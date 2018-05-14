//
//  ViewController.swift
//  Instagrid-OC
//
//  Created by Levent Bostanci on 24/04/2018.
//  Copyright © 2018 Levent Bostanci. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var centralView: CentralView!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    
    
    @IBAction func paterneButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            centralView.displayLayout(id: 1, type: .one)
            unseclectButtons()
            firstButton.isSelected = true
        case 1:
            centralView.displayLayout(id: 2, type: .two)
            unseclectButtons()
            secondButton.isSelected = true
        case 2:
            centralView.displayLayout(id: 3, type: .three)
            unseclectButtons()
            thirdButton.isSelected = true
        default:
            break
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func unseclectButtons(){
        firstButton.isSelected = false
        secondButton.isSelected = false
        thirdButton.isSelected = false
    }
    
    
    
    
    
}

