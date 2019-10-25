//
//  CGRect+Collision.swift
//  NinjaCoders
//

import UIKit

extension CGRect {
    
    func dummyCollisionEdge(for point: CGPoint) -> UIRectEdge? {
        if point.x < minX {
            return .left
        } else if point.x > maxX {
            return .right
        } else if point.y < minY {
            return .bottom
        } else if point.y > maxY {
            return .top
        } else {
            return nil
        }
    }
}

extension CGPoint {
    
    func toEdge() -> UIRectEdge? {
        if x < 0 {
            return .left
        } else if x > 0 {
            return .right
        } else if y < 0 {
            return .bottom
        } else if y > 0 {
            return .top
        } else {
            return nil
        }
    }
}
