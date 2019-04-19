//
//  GridView.swift
//  AudioKit
//
//  Created by Keegan Davidson on 4/4/19.
//

import UIKit
@IBDesignable

class GridView: UIView {
    
    var path = UIBezierPath()
//    fretboard[0] = ["E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E"]
    
    var scale = [String]()
    
    var fretboard = [
        ["E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E"],
        ["A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A"],
        ["D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D"],
        ["G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G"],
        ["B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"],
        ["E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E"]
    ]
    
    
    fileprivate var gridWidthMultiple: CGFloat {
        return 6
    }
    
    fileprivate var gridHeightMultiple: CGFloat {
        return 20
    }
    
    fileprivate var gridWidth: CGFloat
    {
        return bounds.width/CGFloat(gridWidthMultiple)
    }
    
    fileprivate var gridHeight: CGFloat
    {
        return bounds.height/CGFloat(gridHeightMultiple)
    }
    
    fileprivate var gridCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    fileprivate func drawGrid()
    {
//        print(scale)
        path = UIBezierPath()
        path.lineWidth = 3.0
        
        for index in 1...Int(gridWidthMultiple)
        {
            let start = CGPoint(x: CGFloat(index) * gridWidth, y: 0)
            let end = CGPoint(x: CGFloat(index) * gridWidth, y: bounds.height)
            path.move(to: start)
            path.addLine(to: end)
            
            for index in 1...Int(gridHeightMultiple) - 1 {
                let start = CGPoint(x: CGFloat(1) * gridWidth, y: CGFloat(index) * gridHeight)
                let end = CGPoint(x: bounds.width, y: CGFloat(index) * gridHeight)
                path.move(to: start)
                path.addLine(to: end)
            }
        }
        //Close the path.
        path.close()
        
    }
    
    
    override func draw(_ rect: CGRect)
    {
        drawGrid()
        print(scale)
        for str in 0...5 {
            //This loop runs over each horizontal line(i.e. each string)
        
            for index in 0...Int(gridHeightMultiple) {
                //This loop runs over each vertical line(i.e. each fret)
                if (scale.contains(fretboard[str][index])) {
                    let note = ScaleView()
                    note.frame = CGRect(x: CGFloat(str) * gridWidth + (gridWidth / 2), y: CGFloat(index) * gridHeight + (gridHeight / 20), width: 40, height: 40)
                    note.backgroundColor = UIColor.clear
                    self.addSubview(note)
                    let currentNote = fretboard[str][index]
                    let noteLabel = UILabel(frame: note.bounds)
                    noteLabel.center = CGPoint(x: note.frame.size.width / 2, y: note.frame.size.width / 2)
                    noteLabel.textAlignment = .center
                    noteLabel.textColor = UIColor.white
                    noteLabel.text = currentNote
                    note.addSubview(noteLabel)
                }
                
            }
            
        }
        
        for index in 0...Int(gridHeightMultiple) {
            let fretLabel = UILabel()
            fretLabel.frame = CGRect(x: 0, y: CGFloat(index) * gridHeight, width: 50, height: 50)
            fretLabel.text = String(index)
            self.addSubview(fretLabel)
            
            if (index % 2 != 0 || index == 12) {
                let inlay = Inlay()
                inlay.frame = CGRect(x: gridWidth/2, y: CGFloat(index) * gridHeight, width: 30, height: 30)
                inlay.center = CGPoint(x: self.bounds.width / 1.7, y: CGFloat(index) * gridHeight + (gridHeight / 2))
                inlay.layer.opacity = 0.7
                inlay.backgroundColor = UIColor.clear
                self.addSubview(inlay)
            }
        }
        
        // Specify a border (stroke) color.
        UIColor.darkGray.setStroke()
        path.stroke()
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

