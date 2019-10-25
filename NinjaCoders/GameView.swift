//
//  GameView.swift
//  NinjaCoders
//
//  Created by Roman Kyrylenko on 25.10.2019.
//  Copyright © 2019 Roman Kyrylenko. All rights reserved.
//

import Foundation
import UIKit

let boardInset = UIEdgeInsets(top: 75, left: 75, bottom: 150, right: 75)
let playerSize = CGSize(width: 50, height: 50)
let playerMovementOffset: CGFloat = 10.0
let enemySize = CGSize(width: 50, height: 50)
let enemyMovementOffset: CGFloat = enemySize.width / 4
let fps: Double = 1 / 10


final class GameView: UIView {
    
    private let failedAttemptsLabel: UILabel = .init()
    private let upButton: UIButton = .init()
    private let downButton: UIButton = .init()
    private let leftButton: UIButton = .init()
    private let rightButton: UIButton = .init()

    private let board: Board
    private var isTicking = false
    
    private var failuresCount: Int = 0
    
    init() {
        board = Board()
        
        super.init(frame: .zero)
        
        backgroundColor = UIColor(red: 0.16, green: 0.17, blue: 0.20, alpha: 1.00)
        board.backgroundColor = UIColor(red: 0.71, green: 0.71, blue: 0.86, alpha: 0.75)
        
        addSubview(board)
        addSubview(failedAttemptsLabel)
        failedAttemptsLabel.textColor = .white
        failedAttemptsLabel.text = "Failed attempts: \(failuresCount)"
        addButtons()
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(invertTick))
        doubleTap.numberOfTapsRequired = 2
        board.addGestureRecognizer(doubleTap)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        board.frame = frame.inset(by: boardInset)
        if board.frame.size != .zero && !isTicking {
            isTicking = true
            tick()
        }
        configureBoardHandlers()
        failedAttemptsLabel.frame = CGRect(x: 75, y: 0, width: frame.width, height: 44.0)
        upButton.frame = CGRect(x: 0, y: frame.height - 100, width: frame.width / 4, height: 100)
        downButton.frame = CGRect(x: upButton.frame.maxX, y: frame.height - 100, width: frame.width / 4, height: 100)
        leftButton.frame = CGRect(x: downButton.frame.maxX, y: frame.height - 100, width: frame.width / 4, height: 100)
        rightButton.frame = CGRect(x: leftButton.frame.maxX, y: frame.height - 100, width: frame.width / 4, height: 100)
    }
    
    private func configureBoardHandlers() {
        board.didFail = { [weak self] in
            guard let self = self else { return }
            
            self.failuresCount += 1
            self.failedAttemptsLabel.text = "Failed attempts: \(self.failuresCount)"
        }
    }
    
    private func addButtons() {
        addSubview(upButton)
        addSubview(downButton)
        addSubview(leftButton)
        addSubview(rightButton)
        upButton.backgroundColor = .yellow
        downButton.backgroundColor = .green
        leftButton.backgroundColor = .red
        rightButton.backgroundColor = .blue
        
        upButton.setTitle("UP", for: .normal)
        downButton.setTitle("DOWN", for: .normal)
        leftButton.setTitle("LEFT", for: .normal)
        rightButton.setTitle("RIGHT", for: .normal)

        upButton.addTarget(self, action: #selector(up), for: .touchUpInside)
        downButton.addTarget(self, action: #selector(down), for: .touchUpInside)
        leftButton.addTarget(self, action: #selector(left), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(right), for: .touchUpInside)

    }
    
    @objc
    private func up() {
        board.playerDidChangeMovement(movement: .up)
    }
    
    @objc
    private func right() {
        board.playerDidChangeMovement(movement: .right)
    }
    
    @objc
    private func left() {
        board.playerDidChangeMovement(movement: .left)
    }
    
    @objc
    private func down() {
        board.playerDidChangeMovement(movement: .down)
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
}
