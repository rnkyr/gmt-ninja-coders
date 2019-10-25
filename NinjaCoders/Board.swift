//
//  Board.swift
//  NinjaCoders
//
//  Created by Roman Kyrylenko on 25.10.2019.
//  Copyright © 2019 Roman Kyrylenko. All rights reserved.
//

import CoreGraphics
import UIKit

struct PlayerMovementSession {
    
    var path: UIBezierPath
}

final class Board: UIView {
    
    var score: Int = 0
    
    private var enemies: [Enemy] = (0...4).map { _ in Enemy() }
    private let player = Player()
    
    private var exludedPaths: [CGPath] = []
    private var effectivePlayerPath: UIBezierPath?
    
    init() {
        super.init(frame: .zero)
        
        let leftGR = UISwipeGestureRecognizer(target: self, action: #selector(swipeRecognized))
        leftGR.direction = .left
        addGestureRecognizer(leftGR)
        
        let rightGR = UISwipeGestureRecognizer(target: self, action: #selector(swipeRecognized))
        rightGR.direction = .right
        addGestureRecognizer(rightGR)
        
        let topGR = UISwipeGestureRecognizer(target: self, action: #selector(swipeRecognized))
        topGR.direction = .up
        addGestureRecognizer(topGR)
        
        let bottomGR = UISwipeGestureRecognizer(target: self, action: #selector(swipeRecognized))
        bottomGR.direction = .down
        addGestureRecognizer(bottomGR)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
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
        player.center = CGPoint(x: round(bounds.width / 2), y: 0)
    }
    
    func tick() {
        setNeedsDisplay()
        
        updateEnemies()
        updatePlayer()
    }
    
    private func updateEnemies() {
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
    
    private func updatePlayer() {
        let center = player.offsetCenter

        if
            player.isMoving,
            let collidedEdge = bounds.dummyCollisionEdge(for: center),
            let movingTowardsEdge = player.velocity.toEdge(),
            movingTowardsEdge == collidedEdge
        {
            // we've reach the end
            player.velocity = .zero

            switch collidedEdge {
            case .left:
                player.center.x = bounds.minX
                
            case .right:
                player.center.x = bounds.maxX
            
            case .bottom:
                player.center.y = bounds.minY
                
            case .top:
                player.center.y = bounds.maxY
                
            default:
                break
            }
            
            endPlayerMove(at: player.center)
            
            let idleBounds = bounds.insetBy(dx: -1, dy: -1)

            switch collidedEdge {
            case .left:
                player.center.x = idleBounds.minX
                
            case .right:
                player.center.x = idleBounds.maxX
            
            case .bottom:
                player.center.y = idleBounds.minY
                
            case .top:
                player.center.y = idleBounds.maxY
                
            default:
                break
            }
        } else if player.isMoving {
            if effectivePlayerPath == nil {
                startPlayerMove(at: player.center)
            } else {
                udpatePlayerMove(at: player.center)
            }
            
            player.center = player.offsetCenter
        }
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        
        context.setLineWidth(2)
        context.setFillColor(UIColor.blue.cgColor)
        context.setStrokeColor(UIColor.blue.cgColor)
        
        if let path = effectivePlayerPath {
            context.addPath(path.cgPath)
            context.strokePath()
        }
        
        exludedPaths.forEach {
            context.addPath($0)
            context.fillPath()
        }
    }
    
    @objc
    private func swipeRecognized(_ recognizer: UISwipeGestureRecognizer) {
        let direction = Direction(recognizerDirection: recognizer.direction)
        if direction == player.direction || direction == player.direction.opposite {
            return
        }

        let allowedDirection = allowedUserDirections()
        if allowedDirection.contains(direction) {
            player.velocity = direction.toVelocity()
        }
    }
    
    private func allowedUserDirections() -> [Direction] {
        var directions: [Direction] = []

        if player.center.x < bounds.maxX {
            directions.append(.right)
        }

        if player.center.x > bounds.minX {
            directions.append(.left)
        }
        
        if player.center.y < bounds.maxY {
            directions.append(.down)
        }
        
        if player.center.y > bounds.minY {
            directions.append(.up)
        }
        
        return directions
    }
    
    // Movement
    
    private func startPlayerMove(at point: CGPoint) {
        effectivePlayerPath = UIBezierPath()
        effectivePlayerPath?.move(to: point)
    }
    
    private func udpatePlayerMove(at point: CGPoint) {
        effectivePlayerPath?.addLine(to: point)
    }
    
    private func endPlayerMove(at point: CGPoint) {        
        effectivePlayerPath?.addLine(to: point)
                
        if let path = effectivePlayerPath {
            exludedPaths.append(path.cgPath)
            
            let deadEnemies = enemies.enumerated().filter { index, enemy in
                path.contains(enemy.center)
            }
            
            deadEnemies.reversed().forEach {
                enemies.remove(at: $0.offset)
                $0.element.removeFromSuperview()
            }
            
            score += deadEnemies.count
        }
        
        effectivePlayerPath = nil
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
