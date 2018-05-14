//
//  CentralView.swift
//  Instagrid-OC
//
//  Created by Levent Bostanci on 25/04/2018.
//  Copyright © 2018 Levent Bostanci. All rights reserved.
//

import UIKit


class CentralView: UIView {
    
    @IBOutlet weak var topLeft : UIView!
    @IBOutlet weak var topRight : UIView!
    @IBOutlet weak var botLeft : UIView!
    @IBOutlet weak var botRight : UIView!
    
    enum Layout: Int{
        case one = 1
        case two = 2
        case three = 3
    }
    
    func getlayoutInfos(name: Layout) -> [Bool]{
        switch name {
        case .one:
            return[false, false, true, false]  //haut gauche, haut droite, bas gauche, bas droite
        case .two:
            return[true, false, false, false]
        case .three:
            return[false, false, false, false]
        }
    }
    
    func displayLayout(id: Int, type: Layout){
        let displays = getlayoutInfos(name: Layout(rawValue: id)!)
        topLeft.isHidden = displays[0]
        topRight.isHidden = displays[1]
        botLeft.isHidden = displays[2]
        botRight.isHidden = displays[3]
    }
    
//    func isFull() -> Bool{
//        var view1 = self.viewWithTag(0) as! UIImage
//    }
    
    
}
