//
//  Board.swift
//  NinjaCoders
//
//  Created by Roman Kyrylenko on 25.10.2019.
//  Copyright © 2019 Roman Kyrylenko. All rights reserved.
//

import UIKit

final class Board: UIView {
  
  private let engine: Engine
  private var enemies: [Enemy] = (0...4).map { _ in Enemy() }
  private let player = Player()
  private var currentLine = Line()
  
  init(engine: Engine) {
    self.engine = engine
    
    super.init(frame: .zero)
    
    self.engine.delegate = self
    prepare()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func prepare() {
    player.frame = CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0)
    addSubview(player)
    enemies.forEach({
      $0.gradient = .randomGradient()
      $0.frame.size = CGSize(width: 50, height: 50)
      addSubview($0)
    })
  }
  
  func direction(direction: Direction) {
    switch direction {
    case .bottom:
      player.direction = CGPoint(x: 0.0, y: 1.0)
    case .top:
      player.direction = CGPoint(x: 0.0, y: -1.0)
    case .left:
      player.direction = CGPoint(x: -1.0, y: 0.0)
    case .righ:
      player.direction = CGPoint(x: 1.0, y: 0.0)
    }
  }
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    
    guard let context = UIGraphicsGetCurrentContext() else { return }
    
    context.setFillColor(UIColor.blue.cgColor)
    context.addPath(currentLine.path)
    context.closePath()
    context.drawPath(using: .fill)
  }
  
}

extension CGPoint {
  
  static func randomGradient() -> CGPoint {
    return CGPoint(x: arc4random() % 2 == 0 ? 0.1 : -0.1, y: arc4random() % 2 == 0 ? -0.1 : 0.1)
  }
  
}

extension Board: EngineDelegate {
  
  func engine(didUpdate engine: Engine) {
    movePlayer(player: player, elepsed: engine.getElapsedTimeSec())
    enemies.forEach({ self.moveEnemy(enemy: $0, elepsed: engine.getElapsedTimeSec()) })
    
    setNeedsDisplay()
  }
  
}

extension Board {
  
  func moveEnemy(enemy: Enemy, elepsed: CFTimeInterval) {
    let offsetCenter = enemy.offsetCenter
    if offsetCenter.x >= bounds.width
      || offsetCenter.y >= bounds.height
      || offsetCenter.x <= 0.0
      || offsetCenter.y <= 0.0 {
      enemy.gradient = .randomGradient()
    }
    enemy.center = enemy.offsetCenter
  }
  
  func movePlayer(player: Player, elepsed: CFTimeInterval) {
    let xOffse = player.direction.x * (player.speed * CGFloat(elepsed))
    let yOffse = player.direction.y * (player.speed * CGFloat(elepsed))
    
    let newOrigin = CGPoint(x: player.center.x + xOffse , y: player.center.y + yOffse)
    
    if newOrigin.x >= bounds.width
      || newOrigin.y >= bounds.height
      || newOrigin.x <= 0.0
      || newOrigin.y <= 0.0 {
      
      currentLine.closePath()
      currentLine.fillPoints.forEach({ checkEnemyCollision(in: $0) })
      
      return
    }
    
    if currentLine.collision(rect: CGRect(x: newOrigin.x, y: newOrigin.y, width: 20.0, height: 20.0)) {
      currentLine.closePath()
      checkEnemyCollision(in: currentLine.fillPoints.last ?? .zero)
    }
    
    currentLine.addPoint(newOrigin)
    
    player.center = newOrigin
  }
  
  func checkEnemyCollision(in rect: CGRect) {
    let fl_enemies = enemies.filter({
      if $0.frame.intersects(rect) {
        $0.removeFromSuperview()
        return false
      }
      return true
    })
    enemies = fl_enemies
  }
  
}

