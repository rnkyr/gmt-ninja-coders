//
//  GameView.swift
//  NinjaCoders
//
//  Created by Roman Kyrylenko on 25.10.2019.
//  Copyright © 2019 Roman Kyrylenko. All rights reserved.
//

import Foundation
import UIKit

let boardInset = UIEdgeInsets(top: 75, left: 75, bottom: 75, right: 75)
let playerSize = CGSize(width: 50, height: 50)
let playerMovementOffset: CGFloat = 10.0
let enemySize = CGSize(width: 50, height: 50)
let enemyMovementOffset: CGFloat = enemySize.width / 4
let fps: Double = 1 / 10

final class GameView: UIView {
    
    private let board: Board
    private let gameControl: GameControl
    private var isTicking = false
    var panGesture = UIPanGestureRecognizer()
    var firstPoint: CGPoint? = nil
    var cutView: UIView = UIView()
    
    init() {
        board = Board()
        gameControl = GameControl()
        
        super.init(frame: .zero)
        
        backgroundColor = UIColor(red: 0.16, green: 0.17, blue: 0.20, alpha: 1.00)
        board.backgroundColor = UIColor(red: 0.71, green: 0.71, blue: 0.86, alpha: 0.75)
        addSubview(cutView)
        addSubview(board)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(invertTick))
        doubleTap.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTap)
        
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedView))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(panGesture)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        board.frame = frame.inset(by: boardInset)
        if board.frame.size != .zero && !isTicking {
            isTicking = true
            tick()
        }
    }
    
    @objc
    private func invertTick() {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        isTicking = !isTicking
        if isTicking {
            tick()
        }
    }
    
    @objc
    private func tick() {
        board.tick()
        
        perform(#selector(tick), with: nil, afterDelay: fps)
    }
    
    @objc
   func draggedView(_ sender: UIPanGestureRecognizer) {
        
        bringSubviewToFront(board.player)
        let translation = sender.translation(in: self)
        
        
        let playerPointInBoard = board.convert(translation, to: board.player)
        
        if firstPoint == nil {
            firstPoint = playerPointInBoard
        }
        
        cutView.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
        cutView.backgroundColor = .red
        
        gameControl.startWay(playerPointInBoard, frameBoard: board.frame)
        
        if case .Down = self.panGesture.verticalDirection(target: self) {
           print("Swiping down")
        } else {
           print("Swiping up")
        }

        if case .Left = self.panGesture.horizontalDirection(target: self) {
            print("Swiping left")
        } else {
            print("Swiping right")
            cutView.frame.size.width = playerPointInBoard.x - board.frame.width
            cutView.frame.size.height = playerPointInBoard.y
            
        }
        
        board.player.center = CGPoint(x: board.player.center.x + translation.x, y: board.player.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self)
    }

}
 

public extension UIPanGestureRecognizer {

    enum GestureDirection {
        case Up
        case Down
        case Left
        case Right
    }

    /// Get current vertical direction
    ///
    /// - Parameter target: view target
    /// - Returns: current direction
    func verticalDirection(target: UIView) -> GestureDirection {
        return self.velocity(in: target).y > 0 ? .Down : .Up
    }

    /// Get current horizontal direction
    ///
    /// - Parameter target: view target
    /// - Returns: current direction
    func horizontalDirection(target: UIView) -> GestureDirection {
        return self.velocity(in: target).x > 0 ? .Right : .Left
    }

    /// Get a tuple for current horizontal/vertical direction
    ///
    /// - Parameter target: view target
    /// - Returns: current direction
    func versus(target: UIView) -> (horizontal: GestureDirection, vertical: GestureDirection) {
        return (self.horizontalDirection(target: target), self.verticalDirection(target: target))
    }

}
