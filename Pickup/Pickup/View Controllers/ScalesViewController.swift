//
//  ScalesViewController.swift
//  AudioKit
//
//  Created by Keegan Davidson on 4/3/19.
//  Copyright © 2019 AudioKit. All rights reserved.
//

import UIKit

class ScalesViewController: UIViewController {
    
    //Instance variables from segue
    var scale = [String]()
    var scaleName = ""
    
    //Setting up labels
    @IBOutlet weak var scaleNameLabel: UILabel!
    
    //Scale view
    @IBOutlet weak var grid: GridView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        grid.scale = scale
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: grid.frame.size.height + 300)
//        scaleView.
        grid.isHidden = false
        
        scaleNameLabel.text = scaleName
        
        print(scale)
        print(scaleName)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
