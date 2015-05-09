//
//  MusicPlayer.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 07/03/2015.
//  Copyright (c) 2015 Effective Code. All rights reserved.
//

import Foundation
import AVFoundation

class MusicPlayer {
    private let player: AVAudioPlayer?
    
    init?(filename: String, type: String){
        if let resource = NSBundle.mainBundle().pathForResource(filename, ofType: type) {
            let url = NSURL(fileURLWithPath: resource)
            player = AVAudioPlayer(contentsOfURL: url, error: nil);
            player!.numberOfLoops = -1
            player!.prepareToPlay()
        } else {
            player = nil
            return nil
        }
    }
    
    func play() {
        if let player = player {
            player.play()
        }
    }
    func stop() {
        if let player = player {
            player.stop()
        }
    }
}
