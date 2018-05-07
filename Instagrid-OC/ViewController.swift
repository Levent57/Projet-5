//
//  ViewController.swift
//  Instagrid-OC
//
//  Created by Levent Bostanci on 24/04/2018.
//  Copyright © 2018 Levent Bostanci. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
  
    @IBAction func LayoutSelected(_ sender: UIButton) {
        sender.isSelected = true
    }
    
    
//    func swipe(){
//        let swipeUp = UISwipeGestureRecognizer(target:, action:)
//        swipeUp.direction = UISwipeGestureRecognizer.up
//    }

    
    
    @IBOutlet weak var centralView: CentralView!
    
        override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

