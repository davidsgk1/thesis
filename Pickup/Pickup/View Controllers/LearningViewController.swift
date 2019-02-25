//
//  LearningViewController.swift
//  Pickup
//
//  Created by Keegan Davidson on 2/16/19.
//  Copyright © 2019 Keegan Davidson. All rights reserved.
//

import UIKit
import AudioKit
import AudioKitUI
import CoreGraphics
@IBDesignable

class LearningViewController: UIViewController {
    
    @IBOutlet private var frequencyLabel: UILabel!
    @IBOutlet private var amplitudeLabel: UILabel!
    @IBOutlet private var noteNameWithSharpsLabel: UILabel!
    @IBOutlet private var noteNameWithFlatsLabel: UILabel!
    @IBOutlet private var audioInputPlot: EZAudioPlot!
    
    //Button setup
    @IBOutlet weak var noteButton: UIButton!
    @IBOutlet weak var minorSwitch: UISwitch!
    
    
    var mic: AKMicrophone!
    var tracker: AKFrequencyTracker!
    var silence: AKBooster!
    
    let noteFrequencies = [16.35, 17.32, 18.35, 19.45, 20.6, 21.83, 23.12, 24.5, 25.96, 27.5, 29.14, 30.87]
    let noteNamesWithSharps = ["C", "C♯", "D", "D♯", "E", "F", "F♯", "G", "G♯", "A", "A♯", "B"]
    let noteNamesWithFlats = ["C", "D♭", "D", "E♭", "E", "F", "G♭", "G", "A♭", "A", "B♭", "B"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AKSettings.audioInputEnabled = true
        mic = AKMicrophone()
        tracker = AKFrequencyTracker(mic)
        silence = AKBooster(tracker, gain: 0)
        makeUI()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AudioKit.output = silence
        do {
            try AudioKit.start()
        } catch {
            AKLog("AudioKit did not start!")
        }
        Timer.scheduledTimer(timeInterval: 0.5,
                             target: self,
                             selector: #selector(LearningViewController.updateUI),
                             userInfo: nil,
                             repeats: true)
    }
    
    @objc func updateUI() {
        
        if tracker.amplitude > 0.1 {
            frequencyLabel.text = String(format: "%0.1f", tracker.frequency)
            
            var frequency = Float(tracker.frequency)
            while frequency > Float(noteFrequencies[noteFrequencies.count - 1]) {
                frequency /= 2.0
            }
            while frequency < Float(noteFrequencies[0]) {
                frequency *= 2.0
            }
            
            var minDistance: Float = 10_000.0
            var index = 0
            
            for i in 0..<noteFrequencies.count {
                let distance = fabsf(Float(noteFrequencies[i]) - frequency)
                if distance < minDistance {
                    index = i
                    minDistance = distance
                }
            }
//            let octave = Int(log2f(Float(tracker.frequency) / frequency))
//            noteNameWithSharpsLabel.text = "\(noteNamesWithSharps[index])\(octave)"
//            noteNameWithFlatsLabel.text = "\(noteNamesWithFlats[index])\(octave)"
            noteNameWithSharpsLabel.text = "\(noteNamesWithSharps[index])"
            noteNameWithFlatsLabel.text = "\(noteNamesWithFlats[index])"

        }
        amplitudeLabel.text = String(format: "%0.3f", tracker.amplitude)
    }
    
    func makeUI() {
        let myGreen = UIColor(red: 60.0/255, green: 163.0/255, blue: 15.0/255, alpha: 1.0)
        let myLightGreen = UIColor(red: 60.0/255, green: 163.0/255, blue: 15.0/255, alpha: 0.85)
        noteButton.layer.shadowColor = myGreen.cgColor
        noteButton.layer.backgroundColor = UIColor.white.cgColor
        noteButton.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        noteButton.layer.masksToBounds = false
        noteButton.layer.shadowRadius = 5.0
        noteButton.layer.shadowOpacity = 0.5
        noteButton.layer.cornerRadius = noteButton.frame.width / 2
        noteButton.layer.borderColor = myGreen.cgColor
        noteButton.layer.borderWidth = 1.0
        
        noteNameWithSharpsLabel.textColor = myGreen
        noteNameWithFlatsLabel.textColor = myLightGreen
    }
}
