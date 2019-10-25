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
    private var isTicking = false
    
    init() {
        board = Board()
        
        super.init(frame: .zero)
        
        backgroundColor = UIColor(red: 0.16, green: 0.17, blue: 0.20, alpha: 1.00)
        board.backgroundColor = UIColor(red: 0.71, green: 0.71, blue: 0.86, alpha: 0.75)
        
        addSubview(board)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(invertTick))
        doubleTap.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTap)
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
}
