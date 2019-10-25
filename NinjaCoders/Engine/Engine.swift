import Foundation
import UIKit

protocol EngineDelegate: class {
  func engine(didUpdate engine: Engine)
}

class Engine {
  
  weak var delegate: EngineDelegate?
  
  var isPause: Bool {
    return displayLink.isPaused
  }
  
  var time: CFTimeInterval {
    return displayLink.targetTimestamp
  }
  
  private var displayLink: CADisplayLink!
  
  init() {
    setupTick()
  }
  
  private func setupTick() {
    displayLink = CADisplayLink(target: self, selector: #selector(tick))
    displayLink.add(to: .main, forMode: .default)
    
    stop()
  }
  
  func start() {
    displayLink.isPaused = false
  }
  
  func stop() {
    displayLink.isPaused = true
  }
  
  func getElapsedTimeSec() -> CFTimeInterval {
    return displayLink.targetTimestamp - CACurrentMediaTime()
  }
  
  @objc
  private func tick() {
    delegate?.engine(didUpdate: self)
  }
  
}
