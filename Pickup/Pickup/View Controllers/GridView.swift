//
//  GridView.swift
//  AudioKit
//
//  Created by Keegan Davidson on 4/4/19.
//

import UIKit

class GridView: UIView {
    
    var path = UIBezierPath()
//    fretboard[0] = ["E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E"]
    
    var scale = [String]()
    
    var fretboard = [
        ["E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E"],
        ["A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A"],
        ["D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D"],
        ["G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G"],
        ["B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"],
        ["E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E"]
    ]
    
    
    fileprivate var gridWidthMultiple: CGFloat {
        return 5
    }
    
    fileprivate var gridHeightMultiple: CGFloat {
        return 12
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
        
        for index in 0...Int(gridWidthMultiple)
        {
            let start = CGPoint(x: CGFloat(index) * gridWidth, y: 0)
            let end = CGPoint(x: CGFloat(index) * gridWidth, y: bounds.height)
            path.move(to: start)
            path.addLine(to: end)
            
            for index in 1...Int(gridHeightMultiple) - 1 {
                let start = CGPoint(x: 0, y: CGFloat(index) * gridHeight)
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
//        let noteTest = ScaleView()
//        noteTest.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
//        self.addSubview(noteTest)
        
        for str in 0...5 {
            //This loop runs over each horizontal line(i.e. each string)
            
            for index in 0...Int(gridHeightMultiple) {
                //This loop runs over each vertical line(i.e. each fret)
                if (scale.contains(fretboard[str][index])) {
                    let note = ScaleView()
                    note.frame = CGRect(x: CGFloat(str) * gridWidth, y: CGFloat(index) * gridHeight, width: 60, height: 60)
                    note.backgroundColor = UIColor.clear
                    self.addSubview(note)
                    print(fretboard[str][index])
                }
                else {
                    print("Note not in scale")
                }
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

class NoteCircle: UIView {
    override func draw(_ rect: CGRect)
    {
        drawRingFittingInsideView()
    }
    
    internal func drawRingFittingInsideView()->()
    {
        let halfSize:CGFloat = min( bounds.size.width/2, bounds.size.height/2)
        let desiredLineWidth:CGFloat = 1    // your desired value
        
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x:halfSize,y:halfSize),
            radius: CGFloat( halfSize - (desiredLineWidth/2) ),
            startAngle: CGFloat(0),
            endAngle:CGFloat(M_PI * 2),
            clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = desiredLineWidth
        
        layer.addSublayer(shapeLayer)
    }
}
