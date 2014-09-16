//
//  Textures.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 07/09/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//

import Foundation


struct Textures {
    let background: String
    let ground: String
    let pipes: [String]
    let bird: [String]
    
    static func classic() -> Textures {
        return Textures(
            background: "background.png",
            ground: "ground.png",
            pipes: ["pipeTop.png", "pipeBottom.png"],
            bird: ["bird1", "bird2"])
    }

    static func cave() -> Textures {
        return Textures(
            background: "cave_background.png",
            ground: "cave_ground.png",
            pipes: ["cave_pipeTop.png", "cave_pipeBottom.png"],
            bird: ["bird1", "bird2"])
    }
}
