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
    
    //Popup view set up
    @IBOutlet weak var popUpView: UIView!
    //Current Note Label
    let currentNoteLabel = UILabel(frame: CGRect(x: 0, y: 400, width: 270, height: 200))
    
    
    var sHeight: CGFloat!
    var sWidth: CGFloat!
    
    func showPopUpView() {
        //defining screen width and height
        let screenHeight = self.view.frame.size.height
        let screenWidth = self.view.frame.size.width
        
        //Setting up current note label, because it will change
        currentNoteLabel.text = tempNote
        currentNoteLabel.center = CGPoint(x: screenWidth/2, y: 200)
        currentNoteLabel.textAlignment = .center
        currentNoteLabel.textColor = UIColor.white
        currentNoteLabel.font = currentNoteLabel.font.withSize(72)
        currentNoteLabel.layer.opacity = 0.0
        popUpView.addSubview(currentNoteLabel)
        
        popUpView.isHidden = false
    
        //Setting up subviews
        
        //Descriptor Label
        let niceWorkLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (screenWidth - 150), height: screenHeight))
        niceWorkLabel.center = CGPoint(x: screenWidth/2, y: 100)
        niceWorkLabel.textAlignment = .center
        niceWorkLabel.text = "Nice work. You played: "
        niceWorkLabel.textColor = UIColor.white
        niceWorkLabel.adjustsFontSizeToFitWidth = true
        niceWorkLabel.font = niceWorkLabel.font.withSize(28)
        niceWorkLabel.layer.opacity = 0.0
        popUpView.addSubview(niceWorkLabel)
        
        //UI button... here we go
        let nextChordButton = UIButton(frame: CGRect(x: 0, y: ((screenHeight/4) * 3), width: 290, height: 60))
        nextChordButton.center = CGPoint(x: screenWidth/2, y: 600)
        nextChordButton.setTitle("Next Chord", for: .normal)
        nextChordButton.setTitleColor(UIColor.white, for: .normal)
        nextChordButton.backgroundColor = UIColor(red: 250/255.0, green: 179/255.0, blue: 0/255.0, alpha: 1.0)
        nextChordButton.layer.shadowColor = UIColor.black.cgColor
        nextChordButton.layer.shadowOffset = CGSize(width: 1, height: 3)
        nextChordButton.layer.shadowOpacity = 0.1
        nextChordButton.layer.shadowRadius = 5
        nextChordButton.showsTouchWhenHighlighted = false
        nextChordButton.addTarget(self, action: #selector(resetView), for: .touchUpInside)
        nextChordButton.layer.cornerRadius = 15
        nextChordButton.layer.opacity = 0.0
        popUpView.addSubview(nextChordButton)
        
        popUpView.frame = CGRect(x: (screenWidth/2), y: (screenHeight/2), width: 100.0, height: 100.0)
        popUpView.center = CGPoint(x: screenWidth/2, y: screenHeight/2)
        self.popUpView.layer.cornerRadius = popUpView.frame.size.width / 2
        self.popUpView.transform = CGAffineTransform(rotationAngle: CGFloat(360 * Double.pi / 180))
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            
            self.popUpView.transform = CGAffineTransform(rotationAngle: CGFloat(-360 * Double.pi / 180))
            self.popUpView.layer.cornerRadius = 25
            //Random background colors
            let red   = CGFloat((arc4random() % 256)) / 255.0
            let green = CGFloat((arc4random() % 256)) / 255.0
            let blue  = CGFloat((arc4random() % 256)) / 255.0
            let alpha = CGFloat(1.0)
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .autoreverse, animations: {
                self.popUpView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
            }, completion:nil)
            
            UIView.animate(withDuration: 0.2, delay: 0.3, animations: {
                self.popUpView.layer.cornerRadius = 0
                self.popUpView.frame = CGRect(x: 0.0, y: 0.0, width: screenWidth, height: screenHeight)
                self.popUpView.backgroundColor = UIColor(red: 115/255.0, green: 175/255.0, blue: 89/255.0, alpha: 1.0)
            })
            
            UIView.animate(withDuration: 0.2, delay: 0.7, options: .curveEaseIn, animations: {
                nextChordButton.layer.opacity = 1.0
                self.currentNoteLabel.layer.opacity = 1.0
                niceWorkLabel.layer.opacity = 1.0
            })
            
        })
        
        
        
    }

    
    //Button setup
    @IBOutlet weak var noteButton: UIButton!
    @IBOutlet weak var minorSwitch: UISwitch!
    var stopReading: UIButton!
    
    @objc func stopAudioKit(_ sender: Any) {
        addChord()
        print("chordArr before send: ", chordArr)
        showPopUpView()
        do {
            try AudioKit.stop()
        } catch {
            print("AudioKit did not stop.")
        }
        stopReading.isHidden = true

    }
    
    //Setting up chord array
    var chordCount = 0
    var chordArr = [String]()
    var currentNote = ""
    var tempNote = ""
    
    func addChord() {
        if (minorSwitch.isOn) {
            tempNote = currentNote + "m"
            chordArr.append(tempNote)
        }
        else {
            tempNote = currentNote
            chordArr.append(currentNote)
        }
        chordCount = chordCount + 1
    }
    
    @objc func resetView(_ sender: UIButton!) {
        popUpView.isHidden = true
        if (chordArr.count >= 4) {
            let storyboard: UIStoryboard = UIStoryboard(name: "QuizStoryboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "QuizViewController") as! QuizViewController
            vc.chordArr = chordArr
            self.show(vc, sender: self)
        }
        else {
            do {
                try AudioKit.start()
            } catch {
                print("AudioKit did not start.")
            }
            stopReading.isHidden = false
        }
    }

    
    
    var mic: AKMicrophone!
    var tracker: AKFrequencyTracker!
    var silence: AKBooster!
    
    let noteFrequencies = [16.35, 17.32, 18.35, 19.45, 20.6, 21.83, 23.12, 24.5, 25.96, 27.5, 29.14, 30.87]
    let noteNamesWithSharps = ["C", "C♯", "D", "D♯", "E", "F", "F♯", "G", "G♯", "A", "A♯", "B"]
    let noteNamesWithFlats = ["C", "D♭", "D", "E♭", "E", "F", "G♭", "G", "A♭", "A", "B♭", "B"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sHeight = view.frame.size.height
        sWidth = view.frame.size.width
        
        //Setting up the button
        stopReading = UIButton(frame: CGRect(x: 0, y: (sHeight / 4) * 3, width: 290, height: 60))
        stopReading.center = CGPoint(x: sWidth / 2, y: (sHeight / 8) * 7)
        stopReading.setTitle("Next Chord", for: .normal)
        stopReading.setTitleColor(UIColor.white, for: .normal)
        stopReading.backgroundColor = UIColor(red: 115/255.0, green: 175/255.0, blue: 89/255.0, alpha: 1.0)
        stopReading.layer.shadowColor = UIColor.black.cgColor
        stopReading.layer.shadowOffset = CGSize(width: 1, height: 3)
        stopReading.layer.shadowOpacity = 0.1
        stopReading.layer.shadowRadius = 5
        stopReading.showsTouchWhenHighlighted = false
        stopReading.addTarget(self, action: #selector(stopAudioKit), for: .touchUpInside)
        stopReading.layer.cornerRadius = 15
        view.addSubview(stopReading)
        
        popUpView.isHidden = true;
        AKSettings.audioInputEnabled = true
        mic = AKMicrophone()
        tracker = AKFrequencyTracker(mic)
        silence = AKBooster(tracker, gain: 0)
        makeUI()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("ViewDidAppear audioKit trying to start")
        AudioKit.output = silence
        do {
            try AudioKit.start()
        } catch {
            AKLog("AudioKit did not start!")
        }
        Timer.scheduledTimer(timeInterval: 0.2,
                             target: self,
                             selector: #selector(LearningViewController.updateUI),
                             userInfo: nil,
                             repeats: true)
    }
    
    @objc func updateUI() {
        
        if tracker.amplitude > 0.1 {
//            frequencyLabel.text = String(format: "%0.1f", tracker.frequency)
//            print(tracker.frequency)
//            print(tracker.amplitude)
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
            currentNote = noteNamesWithSharps[index]

        }
//        amplitudeLabel.text = String(format: "%0.3f", tracker.amplitude)
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
