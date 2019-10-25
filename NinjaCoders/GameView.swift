//
//  GameView.swift
//  NinjaCoders
//
//  Created by Roman Kyrylenko on 25.10.2019.
//  Copyright © 2019 Roman Kyrylenko. All rights reserved.
//

enum Direction {
  case top
  case bottom
  case left
  case righ
}

import Foundation
import UIKit

let boardInset = UIEdgeInsets(top: 75, left: 75, bottom: 75, right: 75)
let playerSize = CGSize(width: 50, height: 50)
let playerMovementOffset: CGFloat = 10.0
let enemySize = CGSize(width: 50, height: 50)
let enemyMovementOffset: CGFloat = enemySize.width / 4

final class GameView: UIView {
  
  private let engine = Engine()
  private let board: Board
  private var isTicking = false
  
  init() {
    board = Board(engine: engine)
    
    super.init(frame: .zero)
    
    clipsToBounds = true
    backgroundColor = UIColor(red: 0.16, green: 0.17, blue: 0.20, alpha: 1.00)
    board.backgroundColor = UIColor(red: 0.71, green: 0.71, blue: 0.86, alpha: 0.75)
    
    addSubview(board)
    
    prepareView()
  }
  
  private func prepareView() {
    start()
    board.frame = CGRect(x: 0.0, y: 0.0, width: 600.0, height: 700.0)
  }
  
  func start() {
    engine.start()
  }
  
  func stop() {
    engine.stop()
  }
  
  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  
  func direction(direction: Direction) {
    board.direction(direction: direction)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    
    if engine.isPause {
      start()
    } else {
      stop()
    }
  }
  
}

