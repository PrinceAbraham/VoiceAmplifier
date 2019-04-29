//
//  PlaybackViewController.swift
//  VoiceAmplifier
//
//  Created by Prince Abraham on 3/2/19.
//  Copyright © 2019 Prince Abraham. All rights reserved.
//

import UIKit
import AVFoundation
//import AudioKit

class PlaybackViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    var isPlaying = false
    var selectedFilter = "None"
    var filters = [
        "Play Sound 1-None", "Play Sound 2-None", "Play Sound 3-None",
        "Play Sound 1-Low Pass", "Play Sound 2-Low Pass", "Play Sound 3-Low Pass",
        "Play Sound 1-Resonant Low Pass", "Play Sound 2-Resonant Low Pass", "Play Sound 3-Resonant Low Pass",
        "Play Sound 1-Low Shelf", "Play Sound 2-Low Shelf", "Play Sound 3-Low Shelf",
        "Play Sound 1-Resonant Low Shelf", "Play Sound 2-Resonant Low Shelf", "Play Sound 3-Resonant Low Shelf",
        "Play Sound 1-High Pass", "Play Sound 2-High Pass", "Play Sound 3-High Pass",
        "Play Sound 1-Resonant High Pass", "Play Sound 2-Resonant High Pass", "Play Sound 3-Resonant High Pass",
        "Play Sound 1-High Shelf", "Play Sound 2-High Shelf", "Play Sound 3-High Shelf",
        "Play Sound 1-Resonant High Shelf", "Play Sound 2-Resonant High Shelf", "Play Sound 3-Resonant High Shelf"]
    var soundFile: AVAudioFile?
    var baseUrl: URL?
    var player: AVAudioPlayerNode?
    var eqNode: AVAudioUnitEQ?
    var engine = AVAudioEngine()
    var isPaused = false
    var currentSound = "";
    var selectedSound = "Play Sound 1";
    var currentFilter = ""
    let session = AVAudioSession.sharedInstance()
    
    
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var dropdown: UIPickerView!
    @IBOutlet weak var filterText: UIButton!
    @IBOutlet weak var firstText: UILabel!
    @IBOutlet weak var firstSlider: UISlider!
    @IBOutlet weak var secondText: UILabel!
    @IBOutlet weak var secondSlider: UISlider!
    @IBOutlet weak var thirdText: UILabel!
    @IBOutlet weak var thirdSlider: UISlider!
    
    override func viewDidLoad() {
        dropdown.isHidden = true
        //Load Rabii Sound
        
        baseUrl = URL(fileURLWithPath: Bundle.main.path(forResource: "rabbisound", ofType: "mp3")!)
        //let soundFile = try! AKAudioFile(forReading: baseURL)
        
        soundFile = try! AVAudioFile(forReading: baseUrl!)
        
        if (soundFile != nil) {
            
            // All the rest of your code goes in here
            
            //player = try! AKAudioPlayer(file: soundFile)
            
            //try! AudioKit.start()
            
            
        }
            
        else {
            
            print("File Error")
            
        }
        
        SetUpUIForFilter(filter: selectedFilter)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Playback Just Appeared")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //try! AudioKit.stop()
    }
    
    func SetUpUIForFilter(filter: String) {
        if filter != "None"{
            
            firstText.isHidden = false
            firstSlider.isHidden = false
            secondText.isHidden = false
            secondSlider.isHidden = false
            thirdText.isHidden = false
            thirdSlider.isHidden = false
            
            firstText.text = "Frequency"
            firstSlider.minimumValue = 20
            firstSlider.maximumValue = 22050
            firstSlider.value = 6990
            
            secondText.text = "Resonance"
            secondSlider.minimumValue = 0.5
            secondSlider.maximumValue = 5
            secondSlider.value = 1
            
            thirdText.text = "Gain"
            thirdSlider.minimumValue = 0
            thirdSlider.maximumValue = 24
            thirdSlider.value = 5
            
        }
            //        else if selectedFilter == "Low Shelf"{
            //
            //            firstText.isHidden = false
            //            firstSlider.isHidden = false
            //            secondText.isHidden = false
            //            secondSlider.isHidden = false
            //            thirdText.isHidden = false
            //            thirdSlider.isHidden = false
            //
            //            firstText.text = "Frequency"
            //            firstSlider.minimumValue = 20
            //            firstSlider.maximumValue = 22050
            //            firstSlider.value = 6990
            //
            //            secondText.text = "Resonance"
            //            secondSlider.minimumValue = 0.5
            //            secondSlider.maximumValue = 5
            //            secondSlider.value = 0
            //
            //            thirdText.text = "Gain"
            //            thirdSlider.minimumValue = 0
            //            thirdSlider.maximumValue = 24
            //            thirdSlider.value = 5
            //
            //        }else if selectedFilter == "Butterworth Low Pass"{
            //            firstText.isHidden = false
            //            firstSlider.isHidden = false
            //            secondText.isHidden = false
            //            secondSlider.isHidden = false
            //            thirdText.isHidden = false
            //            thirdSlider.isHidden = false
            //
            //            firstText.text = "Frequency"
            //            firstSlider.minimumValue = 20
            //            firstSlider.maximumValue = 22050
            //            firstSlider.value = 6990
            //
            //            secondText.text = "Resonance"
            //            secondSlider.minimumValue = 0.5
            //            secondSlider.maximumValue = 5
            //            secondSlider.value = 0
            //
            //            thirdText.text = "Gain"
            //            thirdSlider.minimumValue = 0
            //            thirdSlider.maximumValue = 24
            //            thirdSlider.value = 5
            //
            //        }else if selectedFilter == "Three Pole Low Pass"{
            //            firstText.isHidden = false
            //            firstSlider.isHidden = false
            //            secondText.isHidden = false
            //            secondSlider.isHidden = false
            //            thirdText.isHidden = false
            //            thirdSlider.isHidden = false
            //
            //            firstText.text = "Frequency"
            //            firstSlider.minimumValue = 20
            //            firstSlider.maximumValue = 22050
            //            firstSlider.value = 6990
            //
            //            secondText.text = "Resonance"
            //            secondSlider.minimumValue = 0.5
            //            secondSlider.maximumValue = 5
            //            secondSlider.value = 0
            //
            //            thirdText.text = "Gain"
            //            thirdSlider.minimumValue = 0
            //            thirdSlider.maximumValue = 24
            //            thirdSlider.value = 5
            //        }
        else{
            firstText.isHidden = true
            firstSlider.isHidden = true
            secondText.isHidden = true
            secondSlider.isHidden = true
            thirdText.isHidden = true
            thirdSlider.isHidden = true
        }
    }
    
    
    @IBAction func resetAudioKit(_ sender: Any) {
        
    }
    
    @IBAction func PlayFirstSound(_sender: UIButton) {

    }
    
    @IBAction func PlayPauseClicked(_ sender: Any) {
        if isPlaying{
            //Pause
            isPlaying = false
            player?.pause()
            playPauseButton.setImage(UIImage(named: "play"), for: .normal)
        }else{
            //Play
            isPlaying = true
            print(currentSound)
            print(selectedSound)
            if (currentSound != selectedSound) || (currentFilter != selectedFilter){
                
                //Reset Engine to remove filters, not sure if it actually does anything
                engine.reset()
                
                // New Sound or new Filter
                print(session)
                //let session = AVAudioSession.sharedInstance()
                try! session.setCategory(.playAndRecord, mode: .default, options: [.allowBluetoothA2DP, .defaultToSpeaker])
                try! session.setActive(true)
                
                if selectedSound == "Play Sound 1"{
                    baseUrl = URL(fileURLWithPath: Bundle.main.path(forResource: "rabbisound1", ofType: "mp3")!)
                } else  if selectedSound == "Play Sound 2"{
                    baseUrl = URL(fileURLWithPath: Bundle.main.path(forResource: "rabbisound2", ofType: "mp3")!)
                } else  if selectedSound == "Play Sound 3"{
                    baseUrl = URL(fileURLWithPath: Bundle.main.path(forResource: "rabbisound3", ofType: "mp3")!)
                }
                
                soundFile = try! AVAudioFile(forReading: baseUrl!)
                
                if (soundFile != nil) {
                    
                    player = AVAudioPlayerNode()
                    
                    if selectedFilter == "Low Pass"{
                        eqNode = AVAudioUnitEQ(numberOfBands: 1)
                        eqNode!.bands.first!.filterType = AVAudioUnitEQFilterType.lowPass
                        //Frequency around 4k and resonance to 5 makes sound a bit clearer
                        eqNode!.bands.first!.frequency = firstSlider.value
                        eqNode!.bands.first!.bandwidth = secondSlider.value
                        eqNode!.bands.first!.bypass = false
                        eqNode!.globalGain = thirdSlider.value
                        eqNode!.bypass = false

//                      Delay can be done
//                      let delay = AVAudioUnitDelay()
//                      delay.delayTime = 0.5
//                      delay.bypass = false;
//                      engine.attach(delay)
                        print("engine.attach")
                        engine.attach(player!)
                        engine.attach(eqNode!)
                        print("engine.connect")
                        engine.connect(player!, to: eqNode!)
                        //engine.connect(player!, to: eqNode!)
                        engine.connect(eqNode!, to: engine.mainMixerNode)
                    }else if selectedFilter == "Resonant Low Pass"{
                        eqNode = AVAudioUnitEQ(numberOfBands: 1)
                        eqNode!.bands.first!.filterType = AVAudioUnitEQFilterType.resonantLowPass
                        eqNode!.bands.first!.frequency = firstSlider.value
                        eqNode!.bands.first!.bandwidth = secondSlider.value
                        eqNode!.bands.first!.bypass = false
                        eqNode!.globalGain = thirdSlider.value
                        eqNode!.bypass = false
                        
                        engine.attach(player!)
                        engine.attach(eqNode!)
                        engine.connect(player!, to: eqNode!)
                        engine.connect(eqNode!, to: engine.mainMixerNode)
                    }else if selectedFilter == "Low Shelf"{
                        eqNode = AVAudioUnitEQ(numberOfBands: 1)
                        eqNode!.bands.first!.filterType = AVAudioUnitEQFilterType.lowShelf
                        eqNode!.bands.first!.frequency = firstSlider.value
                        eqNode!.bands.first!.bandwidth = secondSlider.value
                        eqNode!.bands.first!.bypass = false
                        eqNode!.globalGain = thirdSlider.value
                        eqNode!.bypass = false
                        
                        engine.attach(player!)
                        engine.attach(eqNode!)
                        engine.connect(player!, to: eqNode!)
                        engine.connect(eqNode!, to: engine.mainMixerNode)
                    }else if selectedFilter == "Resonant Low Shelf"{
                        eqNode = AVAudioUnitEQ(numberOfBands: 1)
                        eqNode!.bands.first!.filterType = AVAudioUnitEQFilterType.resonantLowShelf
                        eqNode!.bands.first!.frequency = firstSlider.value
                        eqNode!.bands.first!.bandwidth = secondSlider.value
                        eqNode!.bands.first!.bypass = false
                        eqNode!.globalGain = thirdSlider.value
                        eqNode!.bypass = false
                        
                        engine.attach(player!)
                        engine.attach(eqNode!)
                        engine.connect(player!, to: eqNode!)
                        engine.connect(eqNode!, to: engine.mainMixerNode)
                    }else if selectedFilter == "High Pass"{
                        eqNode = AVAudioUnitEQ(numberOfBands: 1)
                        eqNode!.bands.first!.filterType = AVAudioUnitEQFilterType.highPass
                        eqNode!.bands.first!.frequency = firstSlider.value
                        eqNode!.bands.first!.bandwidth = secondSlider.value
                        eqNode!.bands.first!.bypass = false
                        eqNode!.globalGain = thirdSlider.value
                        eqNode!.bypass = false
                        
                        engine.attach(player!)
                        engine.attach(eqNode!)
                        engine.connect(player!, to: eqNode!)
                        //engine.connect(player!, to: eqNode!)
                        engine.connect(eqNode!, to: engine.mainMixerNode)
                    }else if selectedFilter == "Resonant High Pass"{
                        eqNode = AVAudioUnitEQ(numberOfBands: 1)
                        eqNode!.bands.first!.filterType = AVAudioUnitEQFilterType.resonantHighPass
                        eqNode!.bands.first!.frequency = firstSlider.value
                        eqNode!.bands.first!.bandwidth = secondSlider.value
                        eqNode!.bands.first!.bypass = false
                        eqNode!.globalGain = thirdSlider.value
                        eqNode!.bypass = false
                        
                        engine.attach(player!)
                        engine.attach(eqNode!)
                        engine.connect(player!, to: eqNode!)
                        engine.connect(eqNode!, to: engine.mainMixerNode)
                    }else if selectedFilter == "High Shelf"{
                        eqNode = AVAudioUnitEQ(numberOfBands: 1)
                        eqNode!.bands.first!.filterType = AVAudioUnitEQFilterType.highShelf
                        eqNode!.bands.first!.frequency = firstSlider.value
                        eqNode!.bands.first!.bandwidth = secondSlider.value
                        eqNode!.bands.first!.bypass = false
                        eqNode!.globalGain = thirdSlider.value
                        eqNode!.bypass = false
                        
                        engine.attach(player!)
                        engine.attach(eqNode!)
                        engine.connect(player!, to: eqNode!)
                        engine.connect(eqNode!, to: engine.mainMixerNode)
                    }else if selectedFilter == "Resonant High Shelf"{
                        eqNode = AVAudioUnitEQ(numberOfBands: 1)
                        eqNode!.bands.first!.filterType = AVAudioUnitEQFilterType.resonantLowShelf
                        eqNode!.bands.first!.frequency = firstSlider.value
                        eqNode!.bands.first!.bandwidth = secondSlider.value
                        eqNode!.bands.first!.bypass = false
                        eqNode!.globalGain = thirdSlider.value
                        eqNode!.bypass = false
                        
                        engine.attach(player!)
                        engine.attach(eqNode!)
                        engine.connect(player!, to: eqNode!)
                        engine.connect(eqNode!, to: engine.mainMixerNode)
                    }else{
                        engine.attach(player!)
                        engine.connect(player!, to: engine.mainMixerNode)
                    }
                    print("nxt is engine start")
                    do{
                        engine.prepare()
                        try engine.start()
                    }catch{
                        print("Engine didn't start")
                    }
                    print("nxt is player sched")
                    player?.scheduleFile(soundFile!, at: nil, completionHandler: {
                        print("Done with the sound")
                    })
                    print("nxt is player start")
                    player?.play()
                    playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
                    
                    currentSound = selectedSound
                    currentFilter = selectedFilter
                    
                }
            }else{
                //continue playing - unpause
                if engine.isRunning{
                    player?.play()
                    playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
                }else{
                    print("Engine wasn't running")
                    do{
                        engine.prepare()
                        try engine.start()
                        player?.play()
                        playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
                    }catch{
                        print("Engine didn't start")
                    }
                }
            }
        }
    }
    
    @IBAction func FilterLabelClicked(_ sender: Any) {
        filterText.isHidden = true
        dropdown.isHidden = false
    }
    
    
    @IBAction func FirstSliderChanged(_ sender: UISlider) {
        firstText.text = "\(firstText.text!.split(separator: ":", maxSplits: 1, omittingEmptySubsequences: true)[0]): \(sender.value)"
    }
    @IBAction func SecondSliderChanged(_ sender: UISlider) {
        secondText.text = "\(secondText.text!.split(separator: ":", maxSplits: 1, omittingEmptySubsequences: true)[0]): \(sender.value)"
    }
    
    @IBAction func ThirdSliderChanged(_ sender: UISlider) {
        thirdText.text = "\(thirdText.text!.split(separator: ":", maxSplits: 1, omittingEmptySubsequences: true)[0]): \(sender.value)"
    }
    
    
    
    //DropDown Protocols
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return filters.count
    }
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return filters[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //row is selected
        filterText.setTitle(filters[row], for: .normal)
        selectedFilter = String(filters[row].split(separator: "-", maxSplits: 2, omittingEmptySubsequences: true)[1])
        selectedSound = String(filters[row].split(separator: "-", maxSplits: 2, omittingEmptySubsequences: true)[0])
        SetUpUIForFilter(filter: selectedFilter)
        dropdown.isHidden = true
        filterText.isHidden = false
    }
}



