//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Yu Tian on 7/10/15.
//  Copyright (c) 2015 Yu Tian. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    // Declare an AVAudioPlayer variable
    var audioPlayer:AVAudioPlayer!
    var receiveAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        if var filePath = NSBundle.mainBundle().pathForResource("GodFather", ofType: "mp3")
//        {
//            var filePathUrl = NSURL.fileURLWithPath(filePath)
//            
//        }
//        else
//        {
//            println("the filePath is empty")
//        }
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receiveAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receiveAudio.filePathUrl, error: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        // Play audio slowly here...
        audioPlayer.stop()
        audioEngine.stop()
        audioPlayer.rate = 0.5
        // audioPlayer.currentTime = 0.0
        audioPlayer.play()
        
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        // Play audio fastly here...
        audioPlayer.stop()
        audioEngine.stop()
        audioPlayer.rate = 1.5
        // audioPlayer.currentTime = 0.0
        audioPlayer.play()
        
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        
        audioPlayer.stop()
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playJediAudio(sender: UIButton) {
        
        audioPlayer.stop()
        playAudioWithVariablePitch(-1000)
        
    }
    
    func playAudioWithVariablePitch(pitch: Float)
    {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    
    @IBAction func stopAudio(sender: UIButton) {
        // Stop the audio player
        audioPlayer.stop()
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
