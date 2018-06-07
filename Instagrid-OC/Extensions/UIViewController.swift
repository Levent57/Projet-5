//
//  UIViewController.swift
//  Instagrid-OC
//
//  Created by Levent Bostanci on 25/05/2018.
//  Copyright © 2018 Levent Bostanci. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func displayErrorPopUp(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let canelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(canelAction)
        present(alert, animated: true, completion: nil)
    }
}
