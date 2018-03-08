//
//  RecordingViewController.swift
//  Hear for you
//
//  Created by Jack Perry on 7/3/18.
//  Copyright © 2018 Jack Perry. All rights reserved.
//

import UIKit
import AVFoundation

class RecordingViewController: UIViewController,AVAudioRecorderDelegate, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var myTableView: UITableView!
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var numberOfRecords:Int = 0
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
            super.viewDidLoad()
        recordingSession = AVAudioSession.sharedInstance()
        
        if let number:Int = UserDefaults.standard.object(forKey: "myNumber") as? Int
        {
            numberOfRecords = number
        
        AVAudioSession.sharedInstance().requestRecordPermission{ (hasPermission) in
            if hasPermission{
                print ("ACCEPTED")
            }
        }
    
        
        // Do any additional setup after loading the view.
    }
    }
    @IBOutlet weak var buttonLabel: UIButton!
    
    @IBAction func record(_ sender: Any) {

            if audioRecorder == nil
            {
                numberOfRecords += 1
                let filename = getDirectory().appendingPathComponent("\(numberOfRecords).m4a")
                
                let settings = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC), AVSampleRateKey: 12000, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
                
                //Start Audio Recording
                do
                {
                    audioRecorder = try AVAudioRecorder(url: filename, settings: settings)
                    audioRecorder.delegate = self
                    audioRecorder.record()
                
                    
                    
                    buttonLabel.setTitle("Stop Recording", for: .normal)
                }
                catch
                {
                    displayAlert(title: "oops" , message: "Recording Failed")
                    
                }
            }
            else
            {   audioRecorder.stop()
                audioRecorder = nil
                buttonLabel.setTitle("startRecording", for: .normal
                )
                
                
                UserDefaults.standard.set(numberOfRecords, forKey: "myNumber")
                myTableView.reloadData()
            }
        }
        
    
    


  //  override func didReceiveMemoryWarning() {
 //       super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
//    }


//Function that gets path to directory

func getDirectory() -> URL
{
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentDirectory = path[0]
    return documentDirectory
    
    
}

//Function that displays an alert
func displayAlert(title:String, message:String)
{
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "dismiss", style: .default, handler: nil))
    
    present(alert, animated: true, completion: nil)
    
    
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    //Setting up TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRecords
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = String(indexPath.row + 1)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let pathy = getDirectory().appendingPathComponent("\(indexPath.row + 1).m4a")
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: pathy)
            audioPlayer.play()
        }
        catch {
            
            
        }
        }
    }
    

