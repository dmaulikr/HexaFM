//
//  Utilities.swift
//  ProyectoF
//
//  Created by Tony Toussaint on 9/1/17.
//  Copyright © 2017 Jose Andres Salazar. All rights reserved.
//

import Foundation
import SpriteKit

class Utilities {
    
    static let sharedInstance = Utilities()
    
    func deleteChildren(node: SKNode) {
        for child in node.children {
            child.removeFromParent()
        }
    }
    
    func deleteSubViews(view: SKView) {
        for subview in view.subviews {
            subview.removeFromSuperview()
        }
    }
    
}
