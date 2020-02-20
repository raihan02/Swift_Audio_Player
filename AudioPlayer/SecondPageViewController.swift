//
//  SecondPageViewController.swift
//  AudioPlayer
//
//  Created by Twnibit_Raihan on 19/2/20.
//  Copyright © 2020 Twnibit_Raihan. All rights reserved.
//

import UIKit
import AVFoundation
class SecondPageViewController: UIViewController {

    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var currentSlider: UISlider!
    
    @IBOutlet weak var currentSongTimeLabel: UILabel!
    
    
    @IBOutlet weak var volumeSlider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        songNameLabel.text = songsList[thisSong]
        currentSlider.maximumValue = Float(TimeInterval(audioPlayer.duration))
        currentSlider.minimumValue = 0
        //currentSongTimeLabel.text = String(0)
       updateCurrentSlider()

    }
    
    @IBAction func playButton(_ sender: UIButton) {
       
        if audioPlayer.isPlaying == false{
            audioPlayer.play()
        }
    }
    
    @IBAction func pauseButton(_ sender: UIButton) {
        
        if audioPlayer.isPlaying == true{
            audioPlayer.pause()
        }
    }
    
    @IBAction func previousButton(_ sender: UIButton) {
       sliderReload()
       if thisSong != 0 && audioStuffed == true
       {
           playSong(currentSong : songsList[thisSong-1])
           thisSong -= 1
           songNameLabel.text = songsList[thisSong]
       }
       else
       {
        thisSong = songsList.count - 1;
        playSong(currentSong : songsList[thisSong])
        songNameLabel.text = songsList[thisSong]
       }
        viewDidLoad()
    }
    
    
    @IBAction func nextButton(_ sender: UIButton) {
       sliderReload()
            //print(thisSong)
        if thisSong < songsList.count-1 && audioStuffed == true
        {
            playSong(currentSong: songsList[thisSong + 1])
            thisSong += 1
            songNameLabel.text = songsList[thisSong]
        }
        else {
            thisSong = 0
            songNameLabel.text = songsList[thisSong]
             playSong(currentSong : songsList[thisSong])
             
        }
        
    }
    func sliderReload()
    {
        currentSlider.value = 0
    }
    @IBAction func volumeSlider(_ sender: UISlider) {
        audioPlayer.volume = sender.value
        
    }
    
    @IBAction func shuffleButton(_ sender: UIButton) {
        var randomIndex = 0
        randomIndex = Int(arc4random_uniform(UInt32(songsList.count)))
        let selectedFileName = songsList[randomIndex]
        playSong(currentSong: selectedFileName)
        songNameLabel.text = songsList[randomIndex]
        
        sliderReload()
    }
    
    
    @IBAction func currntSongTimeSlider(_ sender: UISlider) {
        audioPlayer.stop()
        audioPlayer.currentTime = TimeInterval(sender.value)
        audioPlayer.play()
        audioPlayer.prepareToPlay()
    }
    
    
    // MARK : For playing song
    func playSong (currentSong : String)
    {
        do{
            let audioPath = Bundle.main.path(forResource: currentSong, ofType: ".mp3")
                try audioPlayer = AVAudioPlayer(contentsOf:NSURL(fileURLWithPath: audioPath!) as URL)
                   audioPlayer.play()
        }
        catch{
            print(error)
        }
        
    }
    
    func updateCurrentSlider()
    {
        _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { timer in
            self.currentSlider.value = Float(audioPlayer.currentTime)
                        NSLog("Hello")
            })
        
        
    }

}

