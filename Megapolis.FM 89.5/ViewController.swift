//
//  ViewController.swift
//  Megapolis.FM 89.5
//
//  Created by Павел Бондаренко on 04/06/16.
//  Copyright © 2016 Pavel Bondarenko. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class ViewController: UIViewController {
    @IBOutlet weak var playStream: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // The Do-Catch statement here is to enable the background audio playing
        // + seting up ability control the player remotely
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
            print("Receiving remote control events\n")
        } catch {
            print("Audio Session error.\n")
        }
        
        // Setting title on the lock screen
        if NSClassFromString("MPNowPlayingInfoCenter") != nil {
            let image:UIImage = UIImage(named: "new_logo.jpg")!
            let albumArt = MPMediaItemArtwork(image: image)
            let songInfo = [
                MPMediaItemPropertyTitle: "MEGAPOLIS",
                MPMediaItemPropertyArtist: "89,5 FM",
                MPMediaItemPropertyArtwork: albumArt
            ]
            MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo = songInfo
        }
    }
    
    override func remoteControlReceivedWithEvent(event: UIEvent?) {
        guard let event = event else {
            print("no event\n")
            return
        }
        guard event.type == UIEventType.RemoteControl else {
            print("received other event type\n")
            return
        }
        switch event.subtype {
        case UIEventSubtype.RemoteControlPlay:
            print("received remote play\n")
            RadioPlayer.sharedInstance.play()
        case UIEventSubtype.RemoteControlPause:
            print("received remote pause\n")
            RadioPlayer.sharedInstance.pause()
        case UIEventSubtype.RemoteControlTogglePlayPause:
            print("received toggle\n")
            RadioPlayer.sharedInstance.toggle()
        default:
            print("received \(event.subtype) which we did not process\n")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func playStream(sender: AnyObject) {
        toggle()
    }
    
    func toggle() {
        if RadioPlayer.sharedInstance.currentlyPlaying(){
            pauseRadio()
        } else {
            playRadio()
        }
    }
    
    func pauseRadio () {
        RadioPlayer.sharedInstance.pause()
        playStream.setTitle("Play Radio", forState: UIControlState.Normal)
    }
    
    func playRadio () {
        RadioPlayer.sharedInstance.play()
        playStream.setTitle("Pause Radio", forState: UIControlState.Normal)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}