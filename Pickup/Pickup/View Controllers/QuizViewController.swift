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
    
    //Label set up
    @IBOutlet weak var chord1: UILabel!
    @IBOutlet weak var chord2: UILabel!
    @IBOutlet weak var chord3: UILabel!
    @IBOutlet weak var chord4: UILabel!
    
    
    let chromatic = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
    var tempChromatic = [String]()
    
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
    
    var testChordArr = ["E", "F#m", "A", "E"]
    //Loops through each key and determines which key the progression is in based on the matching chords
    func determineKey() {
        //search each key for the most matching chords
        var max = 0
        var match = ""
        for key in majorKeys {
            var index = 0
            for arrChord in testChordArr {
                if (arrChord == key.name) {
                    index == index + 2
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
                match = testChordArr[0]
            }
        }
        
        print(match)
    }

    override func viewDidLoad() {
//        runDBData { ([String]) in
//            for chord in chordsArr {
//                print(chord)
//            }
//        }
//        runDBData()
        
        populateMajorKeys()
//        for key in majorKeys {
//            print("-------------------")
//            print(key.name)
//            print(key.chords)
//            print(key.majorNotes)
//            print(key.pentNotes)
//        }
        
        if (chordArr.count > 0) {
            chord1.text = chordArr[0]
            chord2.text = chordArr[1]
            chord3.text = chordArr[2]
            chord4.text = chordArr[3]
        }
        else {
            chord1.text = "No chords yet"
        }
        determineKey()
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
