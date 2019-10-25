//
//  Board.swift
//  NinjaCoders
//
//  Created by Roman Kyrylenko on 25.10.2019.
//  Copyright © 2019 Roman Kyrylenko. All rights reserved.
//

import UIKit

final class Board: UIView {
    
    var didFail: (() -> Void)?
    
    private let enemies: [Enemy] = (0...4).map { _ in Enemy() }
    private let player = Player()
    
    private var playerPoints: [CGPoint] = []
    private var pathes: [UIBezierPath] = []
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        pathes.forEach {
            UIColor(red: 0.16, green: 0.17, blue: 0.20, alpha: 1.00).set()
            UIBezierPath(rect: $0.bounds).fill()
        }
    }
    
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
        let activePath = buildPath(points: playerPoints)
        enemies.forEach { enemy in
            var center = enemy.offsetCenter
            
            if let path = activePath, path.bounds.contains(center) {
                player.movement = .calm
                player.center = playerPoints.first!
                playerPoints.removeAll()
                didFail?()
            }
            
            while !bounds.contains(center) {
                enemy.gradient = .randomGradient()
                center = enemy.offsetCenter
            }
            
            enemy.transform = CGAffineTransform(
                rotationAngle: enemy.frame.origin.angleToFace(point: enemy.offsetPoint)
            )
            enemy.center = center
        }
        
        let playerCenter = player.offsetCenter
        if playerCenter.x >= -35 && playerCenter.y >= -35 && playerCenter.x <= bounds.maxX + 35 && playerCenter.y <= bounds.maxY + 35 {
            player.center = playerCenter
        } else {
            playerPoints.append(player.center)
            if let path = buildPath(points: playerPoints) {
                pathes.append(path)
            }
            setNeedsDisplay()
            player.movement = .calm
            playerPoints.removeAll()
        }
    }
    
    private func buildPath(points: [CGPoint]) -> UIBezierPath? {
        guard !points.isEmpty else {return nil }
        
        let path = UIBezierPath()
        path.move(to: points.first!)
        
        for point in points {
            path.addLine(to: point)
        }
        
        path.addLine(to: points.last!)
        path.close()
        return path
    }
    
    func playerDidChangeMovement(movement: PlayerMovement) {
        playerPoints.append(player.center)
        player.movement = movement
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
