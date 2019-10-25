//
//  Enemy.swift
//  NinjaCoders
//
//  Created by Roman Kyrylenko on 25.10.2019.
//  Copyright © 2019 Roman Kyrylenko. All rights reserved.
//

import UIKit

final class Enemy: UIImageView {
  
  var gradient = CGPoint.zero
  var offsetPoint: CGPoint {
    return CGPoint(x: gradient.x * enemyMovementOffset, y: gradient.y * enemyMovementOffset)
  }
  var offsetCenter: CGPoint {
    return CGPoint(x: center.x + offsetPoint.x, y: center.y + offsetPoint.y)
  }
  
  init() {
    super.init(image: UIImage(named: "bug1.png"))
  }
  
  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  
}
