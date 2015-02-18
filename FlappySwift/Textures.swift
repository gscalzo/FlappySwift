//
//  Textures.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 07/09/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//

import Foundation


struct Textures {
    let sky: String
    let background: String
    let ground: String
    let pipes: [String]
    let bird: [String]
    
    static func classic() -> Textures {
        return Textures(
            sky: "sky.png",
            background: "background.png",
            ground: "ground.png",
            pipes: ["pipeTop.png", "pipeBottom.png"],
            bird: ["book_bird1", "book_bird1"])
    }

    static func cave() -> Textures {
        return Textures(
            sky: "sky.png",
            background: "cave_background.png",
            ground: "cave_ground.png",
            pipes: ["cave_pipeTop.png", "cave_pipeBottom.png"],
            bird: ["bird1", "bird2"])
    }
    static func book() -> Textures {
        return Textures(
            sky: "sky.png",
            background: "city.png",
            ground: "city_ground.png",
            pipes: ["toppipe.png", "bottompipe"],
            bird: ["book_bird1", "book_bird2"])
    }
}
