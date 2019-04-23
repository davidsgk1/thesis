//
//  QuizViewController.swift
//  Pickup
//
//  Created by Keegan Davidson on 3/25/19.
//  Copyright © 2019 Keegan Davidson. All rights reserved.
//

import UIKit
//import FirebaseDatabase

class QuizViewController: UIViewController {
    
    //Instance variable from other view controller
    var chordArr = [String]()
    
    
    let chromatic = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
    var tempChromatic = [String]()
    
    //MAJOR KEY SET UP
    struct majorKey {
        var name: String!
        var chords: [String]!
        var majorNotes: [String]!
        var pentNotes: [String]!
        var index: Int!
//        var bluesNotes: [String]!
    }

    var majorKeys = [majorKey]()
    
    func setMajorKey(note: String) -> majorKey{
        setTempChromatic(note: note)
        var newKey = majorKey(name: note, chords: getMajorChords(note: note), majorNotes: getMajorScaleNotes(note: note), pentNotes: getPentScaleNotes(note: note), index: 0)
        return newKey
    }
    
    func populateMajorKeys() {
        for note in chromatic {
            majorKeys.append(setMajorKey(note: note))
            
        }
    }

    //Returns an array with each major chord for the key
    func getMajorChords(note: String) -> [String]{
        setTempChromatic(note: note)
        var majorScale = getMajorScaleNotes(note: note)
        var majorChordsArr = [String]()
        majorChordsArr.append(majorScale[0])
        majorChordsArr.append(majorScale[1] + "m")
        majorChordsArr.append(majorScale[2] + "m")
        majorChordsArr.append(majorScale[3])
        majorChordsArr.append(majorScale[4])
        majorChordsArr.append(majorScale[5] + "m")
        majorChordsArr.append(majorScale[6] + "dim")
        return majorChordsArr
    }
    
    //Returns an array with all the notes in the major scale based on the root note
    func getMajorScaleNotes(note: String) -> [String] {
        setTempChromatic(note: note)
        var majorArr = [String]()
        let startingNote = tempChromatic.index(of: note)!
        let secondNote = tempChromatic[startingNote + 2]
        let thirdNote = tempChromatic[startingNote + 4]
        let fourthNote = tempChromatic[startingNote + 5]
        let fifthNote = tempChromatic[startingNote + 7]
        let sixthNote = tempChromatic[startingNote + 9]
        let seventhNote = tempChromatic[startingNote + 11]
        majorArr.append(note)
        majorArr.append(secondNote)
        majorArr.append(thirdNote)
        majorArr.append(fourthNote)
        majorArr.append(fifthNote)
        majorArr.append(sixthNote)
        majorArr.append(seventhNote)
        return majorArr
    }
    
    //Returns an array of the pentatonic scale notes, which is the major scale but without the 4th and 7th degrees.
    func getPentScaleNotes(note: String) -> [String] {
        var majorNotes = getMajorScaleNotes(note: note)
        var pentNotes = [String]()
        pentNotes.append(majorNotes[0])
        pentNotes.append(majorNotes[1])
        pentNotes.append(majorNotes[2])
        pentNotes.append(majorNotes[4])
        pentNotes.append(majorNotes[5])
        return pentNotes
    }
    
//    func getBluesScaleNotes(note: String) -> [String] {
//
//    }
    
    //MINOR KEY SET UP
    struct minorKey {
        var name: String!
        var chords: [String]!
        var natural: [String]!
        var pent: [String]!
        var index: Int!
    }
    
    var minorKeys = [minorKey]()
    
    func setMinorKey(note: String) -> minorKey {
        setTempChromatic(note: (note))
        var newKey = minorKey(name: note, chords:getMinorChords(note: note), natural: getMinorScaleNotes(note: note), pent: getMinorPentNotes(note: note), index: 0)
        return newKey
    }
    
    func populateMinorKeys() {
        for note in chromatic {
            minorKeys.append(setMinorKey(note: note))
        }
    }
    
    //Returns an array with each minor chord for the key
    func getMinorChords(note: String) -> [String]{
        setTempChromatic(note: note)
        var minorScale = getMinorScaleNotes(note: note)
        var minorChordsArr = [String]()
        minorChordsArr.append(minorScale[0] + "m")
        minorChordsArr.append(minorScale[1] + "dim")
        minorChordsArr.append(minorScale[2])
        minorChordsArr.append(minorScale[3] + "m")
        minorChordsArr.append(minorScale[4] + "m")
        minorChordsArr.append(minorScale[5])
        minorChordsArr.append(minorScale[6])
        return minorChordsArr
    }
    
    func getMinorScaleNotes(note: String) -> [String] {
        setTempChromatic(note: note)
        var minorArr = [String]()
        let startingNote = tempChromatic.index(of: note)!
        let secondNote = tempChromatic[startingNote + 2]
        let thirdNote = tempChromatic[startingNote + 3]
        let fourthNote = tempChromatic[startingNote + 5]
        let fifthNote = tempChromatic[startingNote + 7]
        let sixthNote = tempChromatic[startingNote + 8]
        let seventhNote = tempChromatic[startingNote + 10]
        minorArr.append(note)
        minorArr.append(secondNote)
        minorArr.append(thirdNote)
        minorArr.append(fourthNote)
        minorArr.append(fifthNote)
        minorArr.append(sixthNote)
        minorArr.append(seventhNote)
        return minorArr
    }
    
    func getMinorPentNotes(note: String) -> [String] {
//        let related = relative(match: note)
        var majorRef = getMajorScaleNotes(note: note)
        var minorPent = [String]()
        
        //You need to set flats on the second and fifth note... perhaps search the chromatic to find the value before the note. Remember, you only use sharps so you need to convert them to sharps.
        let startingNote = majorRef.index(of: note)!
        let secondRef = majorRef[startingNote + 2]
        setTempChromatic(note: secondRef)
        let secondNote = tempChromatic.last!
        let thirdNote = majorRef[startingNote + 3]
        let fourthNote = majorRef[startingNote + 4]
        let fifthRef = majorRef[startingNote + 6]
        setTempChromatic(note: fifthRef)
        let fifthNote = tempChromatic.last!
        minorPent.append(note)
        minorPent.append(secondNote)
        minorPent.append(thirdNote)
        minorPent.append(fourthNote)
        minorPent.append(fifthNote)
        
        return minorPent
    }
    
    //rearranges the chromatic starting from a certain index
    func setTempChromatic(note: String) {
        let index = chromatic.index(of: note)!
        tempChromatic.removeAll()
        if (index == 0) {
            for thisNote in chromatic {
                tempChromatic.append(thisNote)
            }
        }
        else {
            for i in index...chromatic.count - 1  {
                tempChromatic.append(chromatic[i])
            }
            
            for j in 0...index - 1 {
                tempChromatic.append(chromatic[j])
            }
        }
        
    }
    
    var testChordArr = ["Fm", "Cm", "Cm", "Fm"]
    //Loops through each key and determines which key the progression is in based on the matching chords
    func determineKey() -> String{
        //search each key for the most matching chords
        var max = 0
        var match = ""
        for key in majorKeys {
            var index = 0
            for arrChord in chordArr {
                if (arrChord == key.name) {
                    index = index + 2
                }
                for chord in key.chords {
                    if (arrChord == chord) {
                        index = index + 1
                    }
                }
            }
            if (index > max) {
                match = key.name
                max = index
            }
            else if (index == max) {
                match = chordArr[0]
            }
        }
        
        let charset = CharacterSet(charactersIn: "m")
        if (chordArr[0].rangeOfCharacter(from: charset) != nil) {
            match = relative(match: match)
        }
        
        return match
    }
    
    func relative(match: String) -> String {
        let relativeArr = ["Am", "A#m", "Bm", "Cm", "C#m", "Dm", "D#m", "Em", "Fm", "F#m", "Gm", "G#m"]
//        if (relativeArr.contains(match)) {
//            let minorSpot
//        }
//        if (chromatic.contains(match)) {
//            let spot = chromatic.index(of: match)
//        }
//        let spot = chromatic[relativeArr.index(of: match)]
        let charset = CharacterSet(charactersIn: "m")
        if (match.rangeOfCharacter(from: charset) != nil) {
            return match
        }
        let spot = chromatic.index(of: match)
        return relativeArr[spot!]
    }
    
    @IBOutlet weak var firstView: UIView!
    
    func firstViewShow() {
        let screenHeight = self.view.frame.size.height
        let screenWidth = self.view.frame.size.width
        
        firstView.isHidden = false
        quizView.isHidden = true
        correctView.isHidden = true
        falseView.isHidden = true
        scalesQuiz.isHidden = true
        
        //setting up first chord label
        let firstChordLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (100), height: 100))
        firstChordLabel.center = CGPoint(x: screenWidth/2, y: screenHeight/10)
        firstChordLabel.textAlignment = .center
        firstChordLabel.text = chordArr[0]
        firstChordLabel.textColor = UIColor.white
        firstChordLabel.adjustsFontSizeToFitWidth = true
        firstChordLabel.font = firstChordLabel.font.withSize(45)
        //background styles
        firstChordLabel.layer.masksToBounds = true
        firstChordLabel.backgroundColor = UIColor(red: 115/255.0, green: 175/255.0, blue: 89/255.0, alpha: 1.0)
        firstChordLabel.layer.cornerRadius = 50
        firstView.addSubview(firstChordLabel)
        
        //setting up second chord label
        let secondChordLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (100), height: 100))
        secondChordLabel.center = CGPoint(x: screenWidth/2, y: (screenHeight/10)*2.5)
        secondChordLabel.textAlignment = .center
        secondChordLabel.text = chordArr[1]
        secondChordLabel.textColor = UIColor.white
        secondChordLabel.adjustsFontSizeToFitWidth = true
        secondChordLabel.font = firstChordLabel.font.withSize(45)
        firstView.addSubview(secondChordLabel)
        //background styles
        secondChordLabel.layer.masksToBounds = true
        secondChordLabel.backgroundColor = UIColor(red: 115/255.0, green: 175/255.0, blue: 89/255.0, alpha: 1.0)
        secondChordLabel.layer.cornerRadius = 50

        
        //setting up third chord label
        let thirdChordLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (100), height: 100))
        thirdChordLabel.center = CGPoint(x: screenWidth/2, y: (screenHeight/10)*4)
        thirdChordLabel.textAlignment = .center
        thirdChordLabel.text = chordArr[2]
        thirdChordLabel.textColor = UIColor.white
        thirdChordLabel.adjustsFontSizeToFitWidth = true
        thirdChordLabel.font = firstChordLabel.font.withSize(45)
        firstView.addSubview(thirdChordLabel)
        //background styles
        thirdChordLabel.layer.masksToBounds = true
        thirdChordLabel.backgroundColor = UIColor(red: 115/255.0, green: 175/255.0, blue: 89/255.0, alpha: 1.0)
        thirdChordLabel.layer.cornerRadius = 50

        
        //setting up fourth chord label
        let fourthChordLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (100), height: 100))
        fourthChordLabel.center = CGPoint(x: screenWidth/2, y: (screenHeight/10)*5.5)
        fourthChordLabel.textAlignment = .center
        fourthChordLabel.text = chordArr[3]
        fourthChordLabel.textColor = UIColor.white
        fourthChordLabel.adjustsFontSizeToFitWidth = true
        fourthChordLabel.font = firstChordLabel.font.withSize(45)
        firstView.addSubview(fourthChordLabel)
        //background styles
        fourthChordLabel.layer.masksToBounds = true
        fourthChordLabel.backgroundColor = UIColor(red: 115/255.0, green: 175/255.0, blue: 89/255.0, alpha: 1.0)
        fourthChordLabel.layer.cornerRadius = 50
        

        
        //Setting up UIButton
        let showQuizButton = UIButton(frame: CGRect(x: 0, y: 0, width: 290, height: 60))
        showQuizButton.center = CGPoint(x: screenWidth/2, y: (screenHeight/10)*7)
        showQuizButton.setTitle("Quiz Me", for: .normal)
        showQuizButton.setTitleColor(UIColor.white, for: .normal)
        showQuizButton.backgroundColor = UIColor(red: 250/255.0, green: 179/255.0, blue: 0/255.0, alpha: 1.0)
        showQuizButton.layer.shadowColor = UIColor.white.cgColor
        showQuizButton.layer.shadowOffset = CGSize(width: 1, height: 3)
        showQuizButton.layer.shadowOpacity = 0.1
        showQuizButton.layer.shadowRadius = 5
        showQuizButton.showsTouchWhenHighlighted = false
        //Add Target Code
        showQuizButton.addTarget(self, action: #selector(showQuiz), for: .touchUpInside)
        showQuizButton.layer.cornerRadius = 15
        firstView.addSubview(showQuizButton)
        
        firstView.layer.opacity = 0.0
    }
    
    @IBOutlet weak var quizView: UIView!
    @objc func showQuiz(_ sender: UIButton!) {
        quizView.isHidden = false
        
        let sHeight = self.view.frame.size.height
        let sWidth = self.view.frame.size.width
        //Alright, time to set up some quiz stuff
        
        //First Label
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (sWidth - 150), height: (sHeight/10)))
        titleLabel.center = CGPoint(x:sWidth/2 - 50, y: sHeight/10)
        titleLabel.textAlignment = .center
        titleLabel.text = "Identifying Keys"
        titleLabel.textColor = UIColor.white
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = titleLabel.font.withSize(28)
        quizView.addSubview(titleLabel)
        
        //Description label
        let descriptionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (sWidth - 150), height: (sHeight/10)))
        descriptionLabel.center = CGPoint(x:sWidth/2 - 30, y: (sHeight/10)*1.7)
        descriptionLabel.textAlignment = .left
        descriptionLabel.text = "Great job with the chords. Looking at them, what key do you think this progression is in?"
        descriptionLabel.textColor = UIColor.white
        descriptionLabel.numberOfLines = 3
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.font = descriptionLabel.font.withSize(24)
        quizView.addSubview(descriptionLabel)
        
        //chord prog label
        let chordProgLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (sWidth - 150), height: (sHeight/10)))
        chordProgLabel.center = CGPoint(x:sWidth/2, y: (sHeight/10)*2.5)
        chordProgLabel.textAlignment = .center
        chordProgLabel.text = chordArr[0] + "   " + chordArr[1] + "   " + chordArr[2] + "   " + chordArr[3]
        chordProgLabel.textColor = UIColor.white
        chordProgLabel.numberOfLines = 3
        chordProgLabel.adjustsFontSizeToFitWidth = true
        chordProgLabel.font = chordProgLabel.font.withSize(26)
        quizView.addSubview(chordProgLabel)
        
        //Generating false answers
        let key = determineKey()
        var count = 0
        var falseAnsOne = ""
        var falseAnsTwo = ""
        while (count < 2) {
            let random = Int.random(in: 0...11)
            if (chromatic[random] != key && (chromatic[random] != falseAnsOne)) {
                if (count == 0) {
                    falseAnsOne = chromatic[random]
                    count = count + 1
                }
                else if (count == 1) {
                    falseAnsTwo = chromatic[random]
                    count = count + 1
                }
            }
        }
        
        //Generating question buttons
        let correctButton = UIButton(frame: CGRect(x: 0, y: 0, width: 290, height: 60))
        correctButton.center = CGPoint(x: sWidth/2, y: (sHeight/10)*4)
        correctButton.setTitle(key, for: .normal)
        correctButton.setTitleColor(UIColor.white, for: .normal)
        correctButton.backgroundColor = UIColor(red: 250/255.0, green: 179/255.0, blue: 0/255.0, alpha: 1.0)
        correctButton.layer.shadowColor = UIColor.white.cgColor
        correctButton.layer.shadowOffset = CGSize(width: 1, height: 3)
        correctButton.layer.shadowOpacity = 0.1
        correctButton.layer.shadowRadius = 5
        correctButton.showsTouchWhenHighlighted = false
        //Add Target Code
        correctButton.addTarget(self, action: #selector(showCorrect), for: .touchUpInside)
        correctButton.layer.cornerRadius = 15
        quizView.addSubview(correctButton)
        
        //Two false answers
        let falseOne = UIButton(frame: CGRect(x: 0, y: 0, width: 290, height: 60))
        falseOne.center = CGPoint(x: sWidth/2, y: (sHeight/10)*5)
        falseOne.setTitle(falseAnsOne, for: .normal)
        falseOne.setTitleColor(UIColor.white, for: .normal)
        falseOne.backgroundColor = UIColor(red: 250/255.0, green: 179/255.0, blue: 0/255.0, alpha: 1.0)
        falseOne.layer.shadowColor = UIColor.white.cgColor
        falseOne.layer.shadowOffset = CGSize(width: 1, height: 3)
        falseOne.layer.shadowOpacity = 0.1
        falseOne.layer.shadowRadius = 5
        falseOne.showsTouchWhenHighlighted = false
        //Add Target Code
        falseOne.addTarget(self, action: #selector(showFalse), for: .touchUpInside)
        falseOne.layer.cornerRadius = 15
        quizView.addSubview(falseOne)
        
        let falseTwo = UIButton(frame: CGRect(x: 0, y: 0, width: 290, height: 60))
        falseTwo.center = CGPoint(x: sWidth/2, y: (sHeight/10)*6)
        falseTwo.setTitle(falseAnsTwo, for: .normal)
        falseTwo.setTitleColor(UIColor.white, for: .normal)
        falseTwo.backgroundColor = UIColor(red: 250/255.0, green: 179/255.0, blue: 0/255.0, alpha: 1.0)
        falseTwo.layer.shadowColor = UIColor.white.cgColor
        falseTwo.layer.shadowOffset = CGSize(width: 1, height: 3)
        falseTwo.layer.shadowOpacity = 0.1
        falseTwo.layer.shadowRadius = 5
        falseTwo.showsTouchWhenHighlighted = false
        //Add Target Code
        falseTwo.addTarget(self, action: #selector(showFalse), for: .touchUpInside)
        falseTwo.layer.cornerRadius = 15
        quizView.addSubview(falseTwo)
        
        UIView.animate(withDuration: 0.7, animations: {
            self.quizView.backgroundColor = UIColor(red: 115/255.0, green: 175/255.0, blue: 89/255.0, alpha: 1.0)
        })
    }
    
    
    @IBOutlet weak var correctView: UIView!
    @objc func showCorrect(_ sender: Any) {
        correctView.isHidden = false
        
        //Getting the key object
        var key = determineKey()
        let height = correctView.frame.size.height
        let width = correctView.frame.size.width
        
        //Adding blur effect to the background
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = quizView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        quizView.addSubview(blurEffectView)
        
        //Background color
        correctView.backgroundColor = UIColor.gray
        correctView.layer.cornerRadius = 15
        
        //Adding title label
        let correctTitle = UILabel(frame: CGRect(x: 0, y: 0, width: (width - 150), height: (height/5)))
        correctTitle.center = CGPoint(x: width/2, y: (height/5))
        correctTitle.textAlignment = .center
        correctTitle.text = "Great job!"
        correctTitle.textColor = UIColor.white
        correctTitle.adjustsFontSizeToFitWidth = true
        correctTitle.font = correctTitle.font.withSize(28)
        correctView.addSubview(correctTitle)
        
        //Adding description.
        let correctDesc = UILabel(frame: CGRect(x: 0, y: 0, width: (width - 30), height: (height/5)*1.5))
        correctDesc.center = CGPoint(x: width/2, y: (height/5)*2.5)
        correctDesc.textAlignment = .center
        correctDesc.text = "The key for this progression is " + key + "! Remember, a key is the tonal center of a progression or song. Typically it's the first or last chord, but doesn't always have to be."
        correctDesc.textColor = UIColor.white
        correctDesc.adjustsFontSizeToFitWidth = true
        correctDesc.numberOfLines = 8
        correctDesc.font = correctDesc.font.withSize(22)
        correctView.addSubview(correctDesc)
        
        //Adding button to show scales OH BOY
        let sendToScales = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 45))
        sendToScales.center = CGPoint(x: width/2, y: (height/5)*4)
        sendToScales.setTitle("Show Scales", for: .normal)
        sendToScales.setTitleColor(UIColor.white, for: .normal)
        sendToScales.backgroundColor = UIColor(red: 250/255.0, green: 179/255.0, blue: 0/255.0, alpha: 1.0)
        sendToScales.layer.shadowColor = UIColor.white.cgColor
        sendToScales.layer.shadowOffset = CGSize(width: 1, height: 3)
        sendToScales.layer.shadowOpacity = 0.1
        sendToScales.layer.shadowRadius = 5
        sendToScales.showsTouchWhenHighlighted = true
        //Add Target Code
        sendToScales.addTarget(self, action: #selector(scalesView), for: .touchUpInside)
        sendToScales.layer.cornerRadius = 15
        correctView.addSubview(sendToScales)
        
    }
    
    @IBOutlet weak var scalesQuiz: UIView!
    @objc func scalesView(_ sender: Any) {
        scalesQuiz.isHidden = false
        correctView.isHidden = true
        quizView.isHidden = true
        
        var key = determineKey()
        let height = scalesQuiz.frame.size.height
        let width = scalesQuiz.frame.size.width
        
        //First Label
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: (width - 150), height: (height/10)))
        title.center = CGPoint(x:width/2 - 50, y: height/10)
        title.textAlignment = .center
        title.text = "Identifying Scales"
        title.textColor = UIColor.white
        title.adjustsFontSizeToFitWidth = true
        title.font = title.font.withSize(28)
        scalesQuiz.addSubview(title)
        
        //Description label
        let descriptionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (width - 150), height: (height/10)))
        descriptionLabel.center = CGPoint(x:width/2 - 30, y: (height/10)*1.7)
        descriptionLabel.textAlignment = .left
        descriptionLabel.text = "The progression is in the key of " + key + ". What scale can you use in that key, knowing your progression?"
        descriptionLabel.textColor = UIColor.white
        descriptionLabel.numberOfLines = 3
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.font = descriptionLabel.font.withSize(24)
        scalesQuiz.addSubview(descriptionLabel)
        
        //chord prog label
        let chordProgLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (width - 150), height: (height/10)))
        chordProgLabel.center = CGPoint(x:width/2, y: (height/10)*2.5)
        chordProgLabel.textAlignment = .center
        chordProgLabel.text = chordArr[0] + "   " + chordArr[1] + "   " + chordArr[2] + "   " + chordArr[3]
        chordProgLabel.textColor = UIColor.white
        chordProgLabel.numberOfLines = 3
        chordProgLabel.adjustsFontSizeToFitWidth = true
        chordProgLabel.font = chordProgLabel.font.withSize(26)
        scalesQuiz.addSubview(chordProgLabel)
        
        //Generating false answers
        var count = 0
        var falseAnsOne = ""
        var falseAnsTwo = ""
        var falseAnsThree = ""
        while (count < 3) {
            var random = Int.random(in: 0...11)
            if (chromatic[random] != key && (chromatic[random] != falseAnsOne)) {
                if (count == 0) {
                    falseAnsOne = chromatic[random] + " blues"
                    count = count + 1
                }
                else if (count == 1) {
                    falseAnsTwo = chromatic[random] + " pentatonic"
                    count = count + 1
                }
                else if (count == 2) {
                    falseAnsThree = chromatic[random] + " natural minor"
                    count = count + 1
                }
            }
        }
        
        //Generating question buttons
        let correctButton = UIButton(frame: CGRect(x: 0, y: 0, width: 290, height: 60))
        correctButton.center = CGPoint(x: width/2, y: (height/10)*4)
        correctButton.setTitle(key + " pentanonic", for: .normal)
        correctButton.setTitleColor(UIColor.white, for: .normal)
        correctButton.backgroundColor = UIColor(red: 250/255.0, green: 179/255.0, blue: 0/255.0, alpha: 1.0)
        correctButton.layer.shadowColor = UIColor.white.cgColor
        correctButton.layer.shadowOffset = CGSize(width: 1, height: 3)
        correctButton.layer.shadowOpacity = 0.1
        correctButton.layer.shadowRadius = 5
        correctButton.showsTouchWhenHighlighted = false
        //Add Target Code
        correctButton.addTarget(self, action: #selector(sendToScalesController), for: .touchUpInside)
        correctButton.layer.cornerRadius = 15
        scalesQuiz.addSubview(correctButton)
        
        //Two false answers
        let falseOne = UIButton(frame: CGRect(x: 0, y: 0, width: 290, height: 60))
        falseOne.center = CGPoint(x: width/2, y: (height/10)*5)
        falseOne.setTitle(falseAnsOne, for: .normal)
        falseOne.setTitleColor(UIColor.white, for: .normal)
        falseOne.backgroundColor = UIColor(red: 250/255.0, green: 179/255.0, blue: 0/255.0, alpha: 1.0)
        falseOne.layer.shadowColor = UIColor.white.cgColor
        falseOne.layer.shadowOffset = CGSize(width: 1, height: 3)
        falseOne.layer.shadowOpacity = 0.1
        falseOne.layer.shadowRadius = 5
        falseOne.showsTouchWhenHighlighted = false
        //Add Target Code
        falseOne.addTarget(self, action: #selector(showFalse), for: .touchUpInside)
        falseOne.layer.cornerRadius = 15
        scalesQuiz.addSubview(falseOne)
        
        let falseTwo = UIButton(frame: CGRect(x: 0, y: 0, width: 290, height: 60))
        falseTwo.center = CGPoint(x: width/2, y: (height/10)*6)
        falseTwo.setTitle(falseAnsTwo, for: .normal)
        falseTwo.setTitleColor(UIColor.white, for: .normal)
        falseTwo.backgroundColor = UIColor(red: 250/255.0, green: 179/255.0, blue: 0/255.0, alpha: 1.0)
        falseTwo.layer.shadowColor = UIColor.white.cgColor
        falseTwo.layer.shadowOffset = CGSize(width: 1, height: 3)
        falseTwo.layer.shadowOpacity = 0.1
        falseTwo.layer.shadowRadius = 5
        falseTwo.showsTouchWhenHighlighted = false
        //Add Target Code
        falseTwo.addTarget(self, action: #selector(showFalse), for: .touchUpInside)
        falseTwo.layer.cornerRadius = 15
        scalesQuiz.addSubview(falseTwo)
        
        let falseThree = UIButton(frame: CGRect(x: 0, y: 0, width: 290, height: 60))
        falseThree.center = CGPoint(x: width/2, y: (height/10)*7)
        falseThree.setTitle(falseAnsThree, for: .normal)
        falseThree.setTitleColor(UIColor.white, for: .normal)
        falseThree.backgroundColor = UIColor(red: 250/255.0, green: 179/255.0, blue: 0/255.0, alpha: 1.0)
        falseThree.layer.shadowColor = UIColor.white.cgColor
        falseThree.layer.shadowOffset = CGSize(width: 1, height: 3)
        falseThree.layer.shadowOpacity = 0.1
        falseThree.layer.shadowRadius = 5
        falseThree.showsTouchWhenHighlighted = false
        //Add Target Code
        falseThree.addTarget(self, action: #selector(showFalse), for: .touchUpInside)
        falseThree.layer.cornerRadius = 15
        scalesQuiz.addSubview(falseThree)
        
        UIView.animate(withDuration: 0.7, animations: {
            self.scalesQuiz.backgroundColor = UIColor(red: 115/255.0, green: 175/255.0, blue: 89/255.0, alpha: 1.0)
        })
        
    }
    
    @objc func sendToScalesController(_ sender: Any?) {
        print("Sending to scales controller")
        let storyboard: UIStoryboard = UIStoryboard(name: "Scales", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ScalesViewController") as! ScalesViewController
        let key = determineKey()
        var sendScale = [String]()
        var sendName = ""
        let charset = CharacterSet(charactersIn: "m")
//        var sendScale = [String]()
        if (key.rangeOfCharacter(from: charset) != nil) {
            for keys in minorKeys {
                if key == (keys.name + "m") {
                    sendScale = keys.pent
                    sendName = key + " pentatonic"
                }
            }
        }
        else {
            for keys in majorKeys {
                if key == keys.name {
                    sendScale = keys.pentNotes
                    sendName = key + " pentatonic"
                }
            }
        }
        vc.scale = sendScale
        vc.scaleName = sendName
        
        self.show(vc, sender: self)
    }
    
    @IBOutlet weak var falseView: UIView!
    @objc func showFalse(_ sender: Any) {
        falseView.isHidden = false
        let height = falseView.frame.size.height
        let width = falseView.frame.size.width
        
        //Adding blur effect to the background
//        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = quizView.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        quizView.addSubview(blurEffectView)
        
        //Background color
        falseView.backgroundColor = UIColor.gray
        falseView.layer.cornerRadius = 15
        
        //Adding title label
        let correctTitle = UILabel(frame: CGRect(x: 0, y: 0, width: (width - 150), height: (height/5)))
        correctTitle.center = CGPoint(x: width/2, y: (height/5))
        correctTitle.textAlignment = .center
        correctTitle.text = "Not quite!"
        correctTitle.textColor = UIColor.white
        correctTitle.adjustsFontSizeToFitWidth = true
        correctTitle.font = correctTitle.font.withSize(28)
        falseView.addSubview(correctTitle)
        
        //Adding description.
        let correctDesc = UILabel(frame: CGRect(x: 0, y: 0, width: (width - 30), height: (height/5)*1.5))
        correctDesc.center = CGPoint(x: width/2, y: (height/5)*2.5)
        correctDesc.textAlignment = .center
        correctDesc.text = "That's not the right key. Remember, the key for a progression is the tonal center and gives resolution to the progression. If you're stuck, take a look at the circle of fifths."
        correctDesc.textColor = UIColor.white
        correctDesc.adjustsFontSizeToFitWidth = true
        correctDesc.numberOfLines = 8
        correctDesc.font = correctDesc.font.withSize(22)
        falseView.addSubview(correctDesc)
        
        //Adding button to show scales OH BOY
        let sendToScales = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 45))
        sendToScales.center = CGPoint(x: width/2, y: (height/5)*4)
        sendToScales.setTitle("Try again", for: .normal)
        sendToScales.setTitleColor(UIColor.white, for: .normal)
        sendToScales.backgroundColor = UIColor(red: 250/255.0, green: 66/255.0, blue: 66/255.0, alpha: 1.0)
        sendToScales.layer.shadowColor = UIColor.white.cgColor
        sendToScales.layer.shadowOffset = CGSize(width: 1, height: 3)
        sendToScales.layer.shadowOpacity = 0.1
        sendToScales.layer.shadowRadius = 5
        sendToScales.showsTouchWhenHighlighted = false
        //Add Target Code
        sendToScales.addTarget(self, action: #selector(resetFalse), for: .touchUpInside)
        sendToScales.layer.cornerRadius = 15
        falseView.addSubview(sendToScales)
    }
    
    @objc func resetFalse(_ sender: Any?) {
        falseView.isHidden = true
        quizView.isHidden = false
        
    }
    
    

    override func viewDidLoad() {
//        runDBData { ([String]) in
//            for chord in chordsArr {
//                print(chord)
//            }
//        }
//        runDBData()
        
        populateMajorKeys()
        populateMinorKeys()
        for key in minorKeys {
            print("-----------------")
            print(key.name)
            print(key.chords)
            print(key.natural)
        }
        print(determineKey())
        firstViewShow()
        
        //Animations for the first view
        UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
            self.firstView.layer.opacity = 1.0
        })
        
        super.viewDidLoad()
    }

    //    var ref: DatabaseReference!
    ////    var databaseHandle: DatabaseHandle!
    //    static var chordsArr: [String] = []
    //
    //    func runDBData() {
    //        ref = Database.database().reference()
    //
    //        ref.child("keys").child("CSharp").observeSingleEvent(of: .value, with: {(snapshot) in
    //            //Take data from the snapshot and add it to the chords array
    //            //            let chord = snapshot as? String
    //            print("Ref is running")
    //            let dict = snapshot.value as? NSDictionary
    //            let chords = dict!["chords"] as! [String]
    //            for chord in chords {
    //                QuizViewController.chordsArr.append(chord)
    //            }
    //        }) { (error) in
    //            print(error.localizedDescription)
    //        }
    //    }

}
