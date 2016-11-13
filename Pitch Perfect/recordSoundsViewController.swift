//
//  recordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Cody Flies on 11/3/16.
//  Copyright © 2016 Cody Flies. All rights reserved.
//

import UIKit
import AVFoundation

class recordSoundsViewController: UIViewController , AVAudioRecorderDelegate{

    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var startRecordingButton: UIButton!
    @IBOutlet weak var recordingLable: UILabel!
    
    var audioRecorder:AVAudioRecorder!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false;
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //write code here
        ////stopRecordingButton.isEnabled = false;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(_ sender: Any) {
        print("pushed record button")
        recordingLable.text = "Recording!!"
        stopRecordingButton.isEnabled = true;
        startRecordingButton.isEnabled = false;
        
        /////record audio copyied from udacity course////
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURL(withPathComponents: pathArray)
        print(filePath!)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self;
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
       
    }
    @IBAction func stopRecording(_ sender: Any) {
        print("stop record button pushed")
        recordingLable.text = "Press to start recording";
        startRecordingButton.isEnabled = true;
        stopRecordingButton.isEnabled = false;
        audioRecorder.stop();
        let audioSession = AVAudioSession.sharedInstance();
        try! audioSession.setActive(false);
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("audio recording did finish");
        if (flag) {
            self.performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url);
        }
        else{
            print("Saving of reding failed");
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! playSoundsViewController
            let recordedAudioURL = sender as! NSURL
            playSoundsVC.recordedAudioURL = recordedAudioURL as URL!
        }
    }
}

