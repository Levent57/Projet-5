//
//  CentralView.swift
//  Instagrid-OC
//
//  Created by Levent Bostanci on 25/04/2018.
//  Copyright © 2018 Levent Bostanci. All rights reserved.
//

import UIKit
enum layouts: Int{
    case one = 1
    case two = 2
    case three = 3
}

class CentralView: UIView {
    
    var type:layouts = .one
    
    
    func getLayoutInfo(name:layouts) ->[Bool]{
        switch: name {
            case .one:
            return[false, true, true, true, false, false]
            case .two:
            return[true, false, false, false, true, true]
            case .three:
            return[true, true, false, false, false, false]
        }
    }

    @IBOutlet weak var rectTop : UIView!
    @IBOutlet weak var rectBot : UIView!
    @IBOutlet weak var SquareTopLeft : UIView!
    @IBOutlet weak var SquareTopRight : UIView!
    @IBOutlet weak var SquareBotLeft : UIView!
    @IBOutlet weak var SquareBotRight : UIView!

    
}
