//
//  CurveLayer.swift
//  NinjaCoders
//
//  Created by Vlad Kochergin on 25.10.2019.
//  Copyright © 2019 Roman Kyrylenko. All rights reserved.
//

import Foundation
import UIKit

final class Line {
  
  private(set) var points = [CGRect]()
  private(set) var fillPoints = [CGRect]()
  
  var path: CGPath {
    let path = CGMutablePath()
    path.addRects(points)
    path.addRects(fillPoints)
    
    return path
  }
  
  private let size = CGSize(width: 10.0, height: 10.0)
  
  func addPoint(_ point: CGPoint) {
    points.append(CGRect(origin: point, size: size))
  }
  
  func closePath() {
    // :(
    if points.count > 10 {
      let prefferRect = calculateRect(rects: points)
      if prefferRect.height > 25.0 {
        fillPoints.append(calculateRect(rects: points))
        points.removeAll()
      }
    }
  }
  
  func collision(rect: CGRect) -> Bool {
    let fillRect = fillPoints.first(where: { $0.intersects(rect) })
    
    return fillRect != nil
  }
  
  func calculateRect(rects: [CGRect]) -> CGRect {
    let minX = rects.map({ ($0.origin.x) }).min() ?? 0.0
    let minY = rects.map({ ($0.origin.y) }).min() ?? 0.0
    let maxX = rects.map({ ($0.origin.x) }).max() ?? 0.0
    let maxY = rects.map({ ($0.origin.y) }).max() ?? 0.0
    
    return CGRect(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
  }
  
}


