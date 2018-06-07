//
//  UIImagePickerController.swift
//  Instagrid-OC
//
//  Created by Levent Bostanci on 25/05/2018.
//  Copyright © 2018 Levent Bostanci. All rights reserved.
//

import UIKit

extension UIImagePickerController {
    open override var shouldAutorotate: Bool { return true }
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return .all }
}

