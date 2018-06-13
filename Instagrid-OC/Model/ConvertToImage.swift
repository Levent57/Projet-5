//
//  Logic.swift
//  Instagrid-OC
//
//  Created by Levent Bostanci on 07/06/2018.
//  Copyright © 2018 Levent Bostanci. All rights reserved.
//

import Foundation
import UIKit

class GridManager {
    
    static func convertUiviewToImage(from view:CentralView) -> UIImage?{
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        guard let img = UIGraphicsGetImageFromCurrentImageContext() else {return nil}
        UIGraphicsEndImageContext()
        return img
    }
    
}
