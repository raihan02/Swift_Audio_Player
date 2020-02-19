//
//  FirstPageViewController.swift
//  AudioPlayer
//
//  Created by Twnibit_Raihan on 19/2/20.
//  Copyright © 2020 Twnibit_Raihan. All rights reserved.
//

import UIKit
import AVFoundation
// MARK: Global variable
var audioPlayer = AVAudioPlayer()
var songsList : [String] = []
var thisSong = 0
var audioStuffed = false

class FirstPageViewController: UIViewController {

    @IBOutlet weak var songListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        songListTableView.delegate = self
        songListTableView.dataSource = self
        getAllSongFromProjectList()
        print("Size: ", songsList.count)

    }
    // MARK : Get all song names from project
    
    func getAllSongFromProjectList()
    {
        let folderURL = URL(fileURLWithPath:Bundle.main.resourcePath!)
        
        do
        {
            let songPath = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
            //loop through the found urls
            for song in songPath
            {
                var mySong = song.absoluteString
                
                if mySong.contains(".mp3")
                {
                    let findString = mySong.components(separatedBy: "/")
                    mySong = findString[findString.count-1]
                    mySong = mySong.replacingOccurrences(of: "%20", with: " ")
                    mySong = mySong.replacingOccurrences(of: ".mp3", with: "")
                    songsList.append(mySong)
                }
                
            }
            
            songListTableView.reloadData()
        }
        catch
        {
            print ("ERROR")
        }
    }

}
extension FirstPageViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = songsList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do
        {
            let audioPath = Bundle.main.path(forResource: songsList[indexPath.row], ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.play()
            thisSong = indexPath.row
            audioStuffed = true
        }
        catch
        {
            print ("ERROR")
        }
    }
}
