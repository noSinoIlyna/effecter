//
//  ViewController.swift
//  effecter
//
//  Created by 中村柊瑕 on 2018/06/09.
//  Copyright © 2018年 柊斗 中村. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var engine = AVAudioEngine()
    let audioUnitDelay = AVAudioUnitDelay()
    let audioUnitDistortion = AVAudioUnitDistortion()
    let audioUnitReverb = AVAudioUnitReverb()
    let audioUnitEQ = AVAudioUnitEQ(numberOfBands: 10)
    
    
    @IBOutlet weak var delayTime: UISlider!
    @IBOutlet weak var delayFeedBack: UISlider!
    @IBOutlet weak var delayLPC: UISlider!
    @IBOutlet weak var delayWDM: UISlider!
    
    @IBOutlet weak var distortionPG: UISlider!
    @IBOutlet weak var distortionLF: UISlider!
    @IBOutlet weak var distortionWDM: UISlider!
    
    @IBOutlet weak var reberbLF: UISlider!
    @IBOutlet weak var reberbWDM: UISlider!
    
    @IBOutlet weak var eqGG: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Prepare
        let input = engine.inputNode
        let mixer = engine.mainMixerNode
        
        engine.attach(audioUnitDelay)
        audioUnitDelay.wetDryMix = 0
        
        engine.attach(audioUnitDistortion)
        audioUnitDistortion.wetDryMix = 0
        
        engine.attach(audioUnitReverb)
        audioUnitReverb.loadFactoryPreset(AVAudioUnitReverbPreset.largeHall)
        audioUnitReverb.wetDryMix = 0
        
        engine.attach(audioUnitEQ)
        
        engine.connect(input, to: audioUnitDelay, format: input.inputFormat(forBus: 0))
        engine.connect(audioUnitDelay, to: audioUnitDistortion, format: input.inputFormat(forBus: 0))
        engine.connect(audioUnitDistortion, to: audioUnitReverb, format: input.inputFormat(forBus: 0))
        engine.connect(audioUnitReverb, to: audioUnitEQ, format: input.inputFormat(forBus: 0))
        engine.connect(audioUnitEQ, to: mixer, format: input.inputFormat(forBus: 0))
        try! engine.start()
        
    }
    
    @IBAction func delayTime(_ sender: UISlider) {
        audioUnitDelay.delayTime = TimeInterval(delayTime.value)
        print(delayTime)
    }
    @IBAction func delayFeedBack(_ sender: UISlider) {
        audioUnitDelay.feedback = delayFeedBack.value
        print(delayFeedBack)
    }
    @IBAction func delayLPC(_ sender: UISlider) {
        audioUnitDelay.lowPassCutoff = delayLPC.value
        print(delayLPC)
    }
    @IBAction func delayWDM(_ sender: UISlider) {
        audioUnitDelay.wetDryMix = delayWDM.value
        print(delayWDM)
    }
    
    @IBAction func distortionPG(_ sender: UISlider) {
        audioUnitDistortion.preGain = distortionPG.value
        print(distortionPG)
    }
    @IBAction func distortionLF(_ sender: UISlider) {
        audioUnitDistortion.loadFactoryPreset(AVAudioUnitDistortionPreset.init(rawValue: Int(distortionLF.value))!)
        print(distortionLF)
    }
    @IBAction func distortionWDM(_ sender: UISlider) {
        audioUnitDistortion.wetDryMix = distortionWDM.value
        print(distortionWDM)
    }
    
    @IBAction func reberbLF(_ sender: UISlider) {
        audioUnitReverb.loadFactoryPreset(AVAudioUnitReverbPreset.init(rawValue: Int(reberbLF.value))!)
        print(reberbLF)
    }
    @IBAction func reberbWDM(_ sender: UISlider) {
        audioUnitReverb.wetDryMix = reberbWDM.value
        print(reberbWDM)
    }
    @IBAction func eqGG(_ sender: UISlider) {
        audioUnitEQ.globalGain = eqGG.value
        print(eqGG)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

