//
//  Board.swift
//  NinjaCoders
//
//  Created by Roman Kyrylenko on 25.10.2019.
//  Copyright © 2019 Roman Kyrylenko. All rights reserved.
//

import UIKit

final class Board: UIView {
    
    private let enemies: [Enemy] = (0...4).map { _ in Enemy() }
    public let player = Player()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard enemies.first?.superview == nil else {
            return
        }
        
        enemies.forEach { enemy in
            addSubview(enemy)
            enemy.center = center
            enemy.frame.size = enemySize
            enemy.gradient = .randomGradient()
        }
        
        addSubview(player)
        player.frame.size = playerSize
        player.center = CGPoint(x: -player.bounds.size.width / 2, y: -player.bounds.size.height / 2)
    }
    
    func tick() {
        enemies.forEach { enemy in
            var center = enemy.offsetCenter
            while !bounds.contains(center) {
                enemy.gradient = .randomGradient()
                center = enemy.offsetCenter
            }
            
            enemy.transform = CGAffineTransform(
                rotationAngle: enemy.frame.origin.angleToFace(point: enemy.offsetPoint)
            )
            enemy.center = center
        }
    }
}

extension CGPoint {
    
    static func random(in range: ClosedRange<CGFloat>) -> CGPoint {
        return CGPoint(x: .random(in: range), y: .random(in: range))
    }
    
    static func randomGradient() -> CGPoint {
        return CGPoint(x: arc4random() % 2 == 0 ? 1 : -1, y: arc4random() % 2 == 0 ? -1 : 1)
    }
    
    func angleToFace(point: CGPoint) -> CGFloat {
        return -atan2(point.x - x, point.y - y) - .pi
    }
    
    static func +(_ lhs: CGPoint, _ rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}
