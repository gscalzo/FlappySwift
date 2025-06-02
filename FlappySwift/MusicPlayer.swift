//
//  MusicPlayer.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 07/03/2015.
//  Copyright (c) 2015 Effective Code. All rights reserved.
//

import Foundation
import AVFoundation

enum MusicPlayerError: Error {
    case resourceNotFound
}

class MusicPlayer {
    private var player: AVAudioPlayer? = nil
    
    init(filename: String, type: String) throws {
        if let resource = Bundle.main.path(forResource: filename, ofType: type) {
            let url = URL(fileURLWithPath: resource)
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1
            player?.prepareToPlay()
        } else {
            throw MusicPlayerError.resourceNotFound
        }
    }
    
    func play() {
        player?.play()
    }
    func stop() {
        player?.stop()
    }
}
