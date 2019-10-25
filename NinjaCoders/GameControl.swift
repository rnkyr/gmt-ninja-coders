//
//  GameControl.swift
//  NinjaCoders
//
//  Created by Maksim Pedko on 25.10.2019.
//  Copyright © 2019 Roman Kyrylenko. All rights reserved.
//

import Foundation
import UIKit

enum Course {
    case wight, right
}

class GameControl {
    
    var course: Course? = nil

    func startWay( _ startPoint: CGPoint, frameBoard: CGRect) {
//        let start = startPoint
        print("startPoint.x")
        print(startPoint.x)
        
        print("startPoint.y")
        print(startPoint.y)
        
        print(frameBoard)
    }
    
    func endWay(_ endPoint:  CGPoint, frameBoard: CGRect) {
        
    }
    
//    func courseWay(point: CGPoint) -> Course {
//        if point.x > 0 {
//            return Course.right
//        } else {
//            return Course.left
//        }
//
//    }
    
}
