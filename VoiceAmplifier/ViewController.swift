//
//  ViewController.swift
//  VoiceAmplifier
//
//  Created by Prince Abraham on 1/23/19.
//  Copyright © 2019 Prince Abraham. All rights reserved.
//

import UIKit
import AudioKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var liveSpeakView: UIView!
    
    
    @IBOutlet weak var dropdown: UIPickerView!
    @IBOutlet weak var filterText: UIButton!
    @IBOutlet weak var firstText: UILabel!
    @IBOutlet weak var firstSlider: UISlider!
    @IBOutlet weak var secondText: UILabel!
    @IBOutlet weak var secondSlider: UISlider!
    @IBOutlet weak var thirdText: UILabel!
    @IBOutlet weak var thirdSlider: UISlider!
    
    var menuShown = false
    var filters = ["None", "Low Pass",  "Resonant Low Pass", "Low Shelf", "Resonant Low Shelf", "High Pass", "Resonant High Pass", "High Shelf", "Resonant High Shelf"]
    var selectedFilter = "None"
    //let mic:AKMicrophone = AKMicrophone()
    var engine = AVAudioEngine()
    var eqNode: AVAudioUnitEQ?
    var distortionNode: AVAudioUnitDistortion?
    var isPlaying = false
    
    override func viewDidLoad() {
        UIApplication.shared.isIdleTimerDisabled = true
        dropdown.isHidden = true
        
        //AK Settings
        //AKSettings.useBluetooth = true
//        AKSettings.ioBufferDuration = 0.01
//        AKSettings.audioInputEnabled = true
//        AKSettings.sampleRate = 44100
        
        
        
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        SetUpUIForFilter(filter: selectedFilter)
        }
    
    override func viewWillDisappear(_ animated: Bool) {
        menuTapped("")
        engine.reset()
        try! engine.stop()
        //mic.stop()
    }
    
    @IBAction func menuTapped(_ sender: Any) {
        if !menuShown{
            let originalTransform = liveSpeakView.transform
            let scaledTransform = originalTransform.scaledBy(x: 1, y: 1)
            let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 150.0, y: 0)
            UIView.animate(withDuration: 0.3, animations: {
                self.liveSpeakView.transform = scaledAndTranslatedTransform
            })
            menuShown = true
        }else{
            let originalTransform = liveSpeakView.transform
            let scaledTransform = originalTransform.scaledBy(x: 1, y: 1)
            let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: -150.0, y: 0)
            UIView.animate(withDuration: 0.3, animations: {
                self.liveSpeakView.transform = scaledAndTranslatedTransform
            })
            menuShown = false
        }
    }
    
    @IBAction func PlayLive(_ sender: UIButton) {
        
        if !isPlaying {
            //PassThrough from Core Audio
            if selectedFilter == "Low Pass"{
                let session = AVAudioSession.sharedInstance()
                try! session.setCategory(.playAndRecord, mode: .default, options: .allowBluetoothA2DP)
                try! session.setActive(true)
                
                let micInput = engine.inputNode
                let micFormat = micInput.inputFormat(forBus: 0)
                eqNode = AVAudioUnitEQ(numberOfBands: 1)
                eqNode!.bands.first!.filterType = AVAudioUnitEQFilterType.lowPass
                eqNode!.bands.first!.frequency = firstSlider.value
                eqNode!.bands.first!.bandwidth = secondSlider.value
                eqNode!.bands.first!.bypass = false
                eqNode!.globalGain = thirdSlider.value
                eqNode!.bypass = false
                engine.attach(eqNode!)
                
                //Cannot attach internal nodes
                //engine.attach(micInput)
                engine.connect(eqNode!, to: engine.mainMixerNode, format: micFormat)
                engine.connect(micInput, to: engine.mainMixerNode, format: micFormat)
                do{
                    engine.prepare()
                    try engine.start()
                }catch{
                    print("Engine failed to start")
                }
            }else if selectedFilter == "Resonant Low Pass" {
                let session = AVAudioSession.sharedInstance()
                try! session.setCategory(.playAndRecord, mode: .default, options: .allowBluetoothA2DP)
                try! session.setActive(true)
                
                let micInput = engine.inputNode
                let micFormat = micInput.inputFormat(forBus: 0)
                eqNode = AVAudioUnitEQ(numberOfBands: 1)
                eqNode!.bands.first!.filterType = AVAudioUnitEQFilterType.resonantLowPass
                eqNode!.bands.first!.frequency = firstSlider.value
                eqNode!.bands.first!.bandwidth = secondSlider.value
                eqNode!.bands.first!.bypass = false
                eqNode!.globalGain = thirdSlider.value
                eqNode!.bypass = false
                engine.attach(eqNode!)
                
                //Cannot attach internal nodes
                //engine.attach(micInput)
                engine.connect(eqNode!, to: engine.mainMixerNode, format: micFormat)
                engine.connect(micInput, to: engine.mainMixerNode, format: micFormat)
                do{
                    engine.prepare()
                    try engine.start()
                }catch{
                    print("Engine failed to start")
                }
            }else if selectedFilter == "Low Shelf" {
                let session = AVAudioSession.sharedInstance()
                try! session.setCategory(.playAndRecord, mode: .default, options: .allowBluetoothA2DP)
                try! session.setActive(true)
                
                let micInput = engine.inputNode
                let micFormat = micInput.inputFormat(forBus: 0)
                eqNode = AVAudioUnitEQ(numberOfBands: 1)
                eqNode!.bands.first!.filterType = AVAudioUnitEQFilterType.lowShelf
                eqNode!.bands.first!.frequency = firstSlider.value
                eqNode!.bands.first!.bandwidth = secondSlider.value
                eqNode!.bands.first!.bypass = false
                eqNode!.globalGain = thirdSlider.value
                eqNode!.bypass = false
                engine.attach(eqNode!)
                
                //Cannot attach internal nodes
                //engine.attach(micInput)
                engine.connect(eqNode!, to: engine.mainMixerNode, format: micFormat)
                engine.connect(micInput, to: engine.mainMixerNode, format: micFormat)
                do{
                    engine.prepare()
                    try engine.start()
                }catch{
                    print("Engine failed to start")
                }
            }else if selectedFilter == "Resonant Low Shelf" {
                let session = AVAudioSession.sharedInstance()
                try! session.setCategory(.playAndRecord, mode: .default, options: .allowBluetoothA2DP)
                try! session.setActive(true)
                
                let micInput = engine.inputNode
                let micFormat = micInput.inputFormat(forBus: 0)
                eqNode = AVAudioUnitEQ(numberOfBands: 1)
                eqNode!.bands.first!.filterType = AVAudioUnitEQFilterType.resonantLowShelf
                eqNode!.bands.first!.frequency = firstSlider.value
                eqNode!.bands.first!.bandwidth = secondSlider.value
                eqNode!.bands.first!.bypass = false
                eqNode!.globalGain = thirdSlider.value
                eqNode!.bypass = false
                engine.attach(eqNode!)
                
                //Cannot attach internal nodes
                //engine.attach(micInput)
                engine.connect(eqNode!, to: engine.mainMixerNode, format: micFormat)
                engine.connect(micInput, to: engine.mainMixerNode, format: micFormat)
                do{
                    engine.prepare()
                    try engine.start()
                }catch{
                    print("Engine failed to start")
                }
            }else if selectedFilter == "High Pass"{
                let session = AVAudioSession.sharedInstance()
                try! session.setCategory(.playAndRecord, mode: .default, options: .allowBluetoothA2DP)
                try! session.setActive(true)
                
                let micInput = engine.inputNode
                let micFormat = micInput.inputFormat(forBus: 0)
                eqNode = AVAudioUnitEQ(numberOfBands: 1)
                eqNode!.bands.first!.filterType = AVAudioUnitEQFilterType.highPass
                eqNode!.bands.first!.frequency = firstSlider.value
                eqNode!.bands.first!.bandwidth = secondSlider.value
                eqNode!.bands.first!.bypass = false
                eqNode!.globalGain = thirdSlider.value
                eqNode!.bypass = false
                engine.attach(eqNode!)
                
                //Cannot attach internal nodes
                //engine.attach(micInput)
                engine.connect(eqNode!, to: engine.mainMixerNode, format: micFormat)
                engine.connect(micInput, to: engine.mainMixerNode, format: micFormat)
                do{
                    engine.prepare()
                    try engine.start()
                }catch{
                    print("Engine failed to start")
                }
            }else if selectedFilter == "Resonant High Pass" {
                let session = AVAudioSession.sharedInstance()
                try! session.setCategory(.playAndRecord, mode: .default, options: .allowBluetoothA2DP)
                try! session.setActive(true)
                
                let micInput = engine.inputNode
                let micFormat = micInput.inputFormat(forBus: 0)
                eqNode = AVAudioUnitEQ(numberOfBands: 1)
                eqNode!.bands.first!.filterType = AVAudioUnitEQFilterType.resonantHighPass
                eqNode!.bands.first!.frequency = firstSlider.value
                eqNode!.bands.first!.bandwidth = secondSlider.value
                eqNode!.bands.first!.bypass = false
                eqNode!.globalGain = thirdSlider.value
                eqNode!.bypass = false
                engine.attach(eqNode!)
                
                //Cannot attach internal nodes
                //engine.attach(micInput)
                engine.connect(eqNode!, to: engine.mainMixerNode, format: micFormat)
                engine.connect(micInput, to: engine.mainMixerNode, format: micFormat)
                do{
                    engine.prepare()
                    try engine.start()
                }catch{
                    print("Engine failed to start")
                }
            }else if selectedFilter == "High Shelf" {
                let session = AVAudioSession.sharedInstance()
                try! session.setCategory(.playAndRecord, mode: .default, options: .allowBluetoothA2DP)
                try! session.setActive(true)
                
                let micInput = engine.inputNode
                let micFormat = micInput.inputFormat(forBus: 0)
                eqNode = AVAudioUnitEQ(numberOfBands: 1)
                eqNode!.bands.first!.filterType = AVAudioUnitEQFilterType.highShelf
                eqNode!.bands.first!.frequency = firstSlider.value
                eqNode!.bands.first!.bandwidth = secondSlider.value
                eqNode!.bands.first!.bypass = false
                eqNode!.globalGain = thirdSlider.value
                eqNode!.bypass = false
                engine.attach(eqNode!)
                
                //Cannot attach internal nodes
                //engine.attach(micInput)
                engine.connect(eqNode!, to: engine.mainMixerNode, format: micFormat)
                engine.connect(micInput, to: engine.mainMixerNode, format: micFormat)
                do{
                    engine.prepare()
                    try engine.start()
                }catch{
                    print("Engine failed to start")
                }
            }else if selectedFilter == "Resonant High Shelf" {
                let session = AVAudioSession.sharedInstance()
                try! session.setCategory(.playAndRecord, mode: .default, options: .allowBluetoothA2DP)
                try! session.setActive(true)
                
                let micInput = engine.inputNode
                let micFormat = micInput.inputFormat(forBus: 0)
                eqNode = AVAudioUnitEQ(numberOfBands: 1)
                eqNode!.bands.first!.filterType = AVAudioUnitEQFilterType.resonantHighShelf
                eqNode!.bands.first!.frequency = firstSlider.value
                eqNode!.bands.first!.bandwidth = secondSlider.value
                eqNode!.bands.first!.bypass = false
                eqNode!.globalGain = thirdSlider.value
                eqNode!.bypass = false
                engine.attach(eqNode!)
                
                //Cannot attach internal nodes
                //engine.attach(micInput)
                engine.connect(eqNode!, to: engine.mainMixerNode, format: micFormat)
                engine.connect(micInput, to: engine.mainMixerNode, format: micFormat)
                do{
                    engine.prepare()
                    try engine.start()
                }catch{
                    print("Engine failed to start")
                }
            }else{
                let session = AVAudioSession.sharedInstance()
                try! session.setCategory(.playAndRecord, mode: .default, options: .allowBluetoothA2DP)
                try! session.setActive(true)
                
                let micInput = engine.inputNode
                let micFormat = micInput.inputFormat(forBus: 0)
                engine.connect(micInput, to: engine.mainMixerNode, format: micFormat)
                do{
                    engine.prepare()
                    try engine.start()
                }catch{
                    print("Engine failed to start")
                }
            }
            
            isPlaying = true
            sender.setImage(UIImage(named: "pause"), for: .normal)
        }else{
            engine.stop()
            isPlaying = false
            sender.setImage(UIImage(named: "play"), for: .normal)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
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
        selectedFilter = filters[row]
        SetUpUIForFilter(filter: selectedFilter)
        dropdown.isHidden = true
        filterText.isHidden = false
    }
    
}



//        let session = AVAudioSession.sharedInstance()
//        try! session.setCategory(.playAndRecord, mode: .default, options: .allowBluetooth)
//        try! session.setActive(true)
//        let baseURL = getDocumentsDirectory().appendingPathComponent("recording.m4a")
//        let settings = [
//            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
//            AVSampleRateKey: 12000,
//            AVNumberOfChannelsKey: 1,
//            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
//        ]
//        do {
//            recorder = try AVAudioRecorder(url: baseURL, settings: settings)
//            recorder?.record()
//            player = try AVAudioPlayer(contentsOf: baseURL)
//            player?.play()
//        }catch{
//            print("/nfailed\n")
//        }

//        let micInput = AudioKit.engine.inputNode
//        let micFormat = micInput.inputFormat(forBus: 0)
//        AudioKit.engine.connect(micInput, to: AudioKit.engine.mainMixerNode, format: micFormat)
//        if !AudioKit.engine.isRunning {
//            try? AudioKit.start()
//        }else{
//            sender.setTitle("Live Now", for: .normal)
//        }

//        var session = AKSettings.session
//
//        try! session.setCategory(.playAndRecord, mode: .default, options: .allowBluetoothA2DP)
//        try! session.setActive(true)
//
//        let mic = AKMicrophone()
//        mic.volume = Double(100)
//
//
//        AudioKit.output = mic
//
//        try! AudioKit.start()

//        let micInput = engine.inputNode
//        let micFormat = micInput.inputFormat(forBus: 0)
//        engine.connect(micInput, to: engine.mainMixerNode, format: micFormat)
//        engine.prepare()
//        do {
//            try engine.start()
//        }catch{
//            print("failed")
//        }


////        [EZMicrophone sharedMicrophone].delegate = self;
////        [[EZMicrophone sharedMicrophone] startFetchingAudio];
////        self.microphoneTextLabel.text = @"Microphone On";
//
//        let mic = EZMicrophone.shared()
//        mic?.startFetchingAudio()
//
////        [[EZMicrophone sharedMicrophone] setOutput:[EZOutput sharedOutput]];
////        [[EZOutput sharedOutput] startPlayback];
//
//        var output = EZOutput.shared()
//        mic?.output(<#T##output: EZOutput!##EZOutput!#>, shouldFill: <#T##UnsafeMutablePointer<AudioBufferList>!#>, withNumberOfFrames: <#T##UInt32#>, timestamp: <#T##UnsafePointer<AudioTimeStamp>!#>)
//        output?.startPlayback()
