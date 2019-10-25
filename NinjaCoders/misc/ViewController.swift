//
//  ViewController.swift
//  NinjaCoders
//
//  Created by Roman Kyrylenko on 25.10.2019.
//  Copyright © 2019 Roman Kyrylenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var gameView: GameView!
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  override var prefersHomeIndicatorAutoHidden: Bool {
    return true
  }
  
  override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
    return .bottom
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    gameView = GameView()
    gameView.frame = CGRect(x: 100.0, y: 100.0, width: 600.0, height: 700.0)
    view.addSubview(gameView)
  }
  
  @IBAction func left(_ sender: Any) {
    gameView.direction(direction: .left)
  }
  
  @IBAction func right(_ sender: Any) {
    gameView.direction(direction: .righ)
  }
  
  @IBAction func top(_ sender: Any) {
    gameView.direction(direction: .top)
  }
  
  @IBAction func bottom_(_ sender: Any) {
    gameView.direction(direction: .bottom)
  }
}

