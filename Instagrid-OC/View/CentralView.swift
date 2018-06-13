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
        topLeft.isHidden = displays[0]
        topRight.isHidden = displays[1]
        botLeft.isHidden = displays[2]
        botRight.isHidden = displays[3]
    }
    
    func hiddenView() -> [Int]{
        var tags = [Int]()
//        for view in mainView{
//            if view.isHidden{
//                tags.append(view.tag)
//            }
//        }
        mainView.forEach { (view) in
            if view.isHidden {
                tags.append(view.tag)
            }
        }
        print(tags)
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
//        var isAvailable = false
//        for image in imageViews{
//                if !(image.superview?.isHidden)!, image.image != nil {
//                    isAvailable = true
//                }
//        }
//        print(isAvailable)
//        return isAvailable
    }

}
