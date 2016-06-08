//
//  ScoreCardViewController.swift
//  Target Helper
//
//  Created by Ian Gristock on 06/06/2016.
//  Copyright © 2016 Ian Gristock. All rights reserved.
//

import UIKit

class ScoreCardViewController: UIViewController {

    @IBOutlet weak var scorecardStackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let customView = NSBundle.mainBundle().loadNibNamed("KeyMapView", owner: self, options: nil).first as? KeyMapView {
            scorecardStackView.addArrangedSubview(KeyMapView())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
