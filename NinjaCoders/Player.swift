//
//  Player.swift
//  NinjaCoders
//
//  Created by Roman Kyrylenko on 25.10.2019.
//  Copyright © 2019 Roman Kyrylenko. All rights reserved.
//

import UIKit

enum PlayerMovement {
    case up, left, down, right, calm
    
    func horizontalOffset() -> CGFloat {
        switch self {
        case .left:
            return -playerMovementOffset
            
        case .right:
            return playerMovementOffset
            
        default:
            return 0.0
        }
    }
    
    func verticalOffset() -> CGFloat {
        switch self {
        case .up:
            return -playerMovementOffset
            
        case .down:
            return playerMovementOffset
            
        default:
            return 0.0
        }
    }
}

final class Player: UIImageView {
    
    var movement: PlayerMovement = .calm
    
    var offsetCenter: CGPoint {
        return CGPoint(
            x: center.x + movement.horizontalOffset(),
            y: center.y + movement.verticalOffset())
    }
    
    init() {
        super.init(image: UIImage(named: "ninja.png"))
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
