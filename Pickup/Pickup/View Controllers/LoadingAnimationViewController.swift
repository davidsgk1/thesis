//
//  LoadingAnimationViewController.swift
//  
//
//  Created by Keegan Davidson on 4/22/19.
//

import UIKit

class LoadingAnimationViewController: UIViewController {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var topLayer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topLayer.layer.opacity = 0.0
        UIView.animate(withDuration: 0.4, animations: {
            self.icon.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            
        })
        UIView.animate(withDuration: 0.5, animations: {
            self.icon.transform = CGAffineTransform(scaleX: 8.0, y: 8.0)
            self.topLayer.layer.opacity = 1.0
        })
        UIView.animate(withDuration: 0.5, animations: {
            self.topLayer.layer.backgroundColor = UIColor.white.cgColor
        })
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let secondViewController = storyboard.instantiateViewController(withIdentifier: "MainStoryboard")
            self.show(secondViewController, sender: nil)
        }
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
