//
//  Player.swift
//  NinjaCoders
//
//  Created by Roman Kyrylenko on 25.10.2019.
//  Copyright © 2019 Roman Kyrylenko. All rights reserved.
//

import UIKit

final class Player: UIImageView {
    
    init() {
        super.init(image: UIImage(named: "ninja.png"))
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
