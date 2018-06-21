//
//  CentralView.swift
//  Instagrid-OC
//
//  Created by Levent Bostanci on 25/04/2018.
//  Copyright © 2018 Levent Bostanci. All rights reserved.
//

import UIKit


class CentralView: UIView {
    
    @IBOutlet weak var topLeftView : UIView!
    @IBOutlet weak var topRightView : UIView!
    @IBOutlet weak var botLeftView : UIView!
    @IBOutlet weak var botRightView : UIView!
    
    @IBOutlet var imageViews : [UIImageView]!
    @IBOutlet var addButtons : [UIButton]!
    @IBOutlet var mainView : [UIView]!
    
    
    enum Layout: Int{
        case one = 1
        case two = 2
        case three = 3
    }
    
    func getlayoutInfos(name: Layout) -> [Bool]{
        switch name {
        case .one:
            return[false, false, false, true]  //haut gauche, haut droite, bas gauche, bas droite
        case .two:
            return[false, true, false, false]
        case .three:
            return[false, false, false, false]
        }
    }
    
    func displayLayout(id: Int, type: Layout){
        let displays = getlayoutInfos(name: Layout(rawValue: id)!)
        topLeftView.isHidden = displays[0]
        topRightView.isHidden = displays[1]
        botLeftView.isHidden = displays[2]
        botRightView.isHidden = displays[3]
    }
    
    func hiddenView() -> [Int]{
        var tags = [Int]()
        for view in mainView{
            if view.isHidden{
                tags.append(view.tag)
            }
        }
        return tags
    }
    
    func availableToShare() -> Bool{
        let tags = hiddenView()
        var isAvailable = true
        for image in imageViews{
            if !tags.contains(image.tag), image.image == nil{
                isAvailable = false
            }
        }
        return isAvailable
    }

}
