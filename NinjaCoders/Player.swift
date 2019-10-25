//
//  Player.swift
//  NinjaCoders
//
//  Created by Roman Kyrylenko on 25.10.2019.
//  Copyright © 2019 Roman Kyrylenko. All rights reserved.
//

import UIKit

enum Direction {
    
    case undefined, up, down, left, right
    
    var opposite: Direction {
        switch self {
        case .undefined:
            return self
        case .up:
            return .down
        case .down:
            return .up
        case .left:
            return .right
        case .right:
            return .left
        }
    }
    
    init(recognizerDirection: UISwipeGestureRecognizer.Direction) {
        switch recognizerDirection {
        case .up:
            self = .up
        case .down:
            self = .down
        case .left:
            self = .left
        case .right:
            self = .right
        default:
            self = .undefined
        }
    }
    
    var isHorizontal: Bool {
        return self == .left || self == .right
    }
    
    var isVertical: Bool {
        return self == .up || self == .down
    }
    
    func toVelocity() -> CGPoint {
        switch self {
        case .undefined:
            return .zero
        case .up:
            return CGPoint(x: 0, y: -1)
        case .down:
            return CGPoint(x: 0, y: 1)
        case .left:
            return CGPoint(x: -1, y: 0)
        case .right:
            return CGPoint(x: 1, y: 0)
        }
    }
}

final class Player: UIImageView {

    var velocity: CGPoint = .zero
    
    var offsetPoint: CGPoint {
        return CGPoint(x: velocity.x * playerMovementOffset, y: velocity.y * playerMovementOffset)
    }
    
    var offsetCenter: CGPoint {
        return CGPoint(x: center.x + offsetPoint.x, y: center.y + offsetPoint.y)
    }
    
    var isMoving: Bool {
        return velocity != .zero
    }
    
    var direction: Direction {
        if velocity.y.isZero && velocity.x.isZero {
            return .undefined
        }
        
        if abs(velocity.y) > abs(velocity.x) {
            return velocity.y < 0 ? .up : .down
        } else {
            return velocity.x < 0 ? .left : .right
        }
    }

    init() {
        super.init(image: UIImage(named: "ninja.png"))
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
