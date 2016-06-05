//
//  RadioPlayer.swift
//  Megapolis.FM 89.5
//
//  Created by Павел Бондаренко on 04/06/16.
//  Copyright © 2016 Pavel Bondarenko. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class RadioPlayer {
    
    static var sharedInstance = RadioPlayer()
    private var streamPlayer = AVPlayer(URL: NSURL(string: "http://stream04.media.rambler.ru/megapolis128.mp3")!)
    private var isPlaying = false
    
    func play() {
        streamPlayer.play()
        isPlaying = true
    }
    
    func pause() {
        streamPlayer.pause()
        isPlaying = false
    }
    
    func toggle() {
        if isPlaying == true {
            pause()
        } else {
            play()
        }
    }
    
    func currentlyPlaying() -> Bool {
        return isPlaying
    }
}
