//
//  CustomOverlay.swift
//  Target Helper
//
//  Created by Ian Gristock on 16/05/2016.
//  Copyright © 2016 Ian Gristock. All rights reserved.
//

import UIKit
import CoreMotion

protocol CustomOverlayDelegate{
    func didCancel(overlayView:CustomOverlayView)
    func didShoot(overlayView:CustomOverlayView)
}

class CustomOverlayView: UIView {
    
    let manager = CMMotionManager()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if manager.deviceMotionAvailable {
            manager.deviceMotionUpdateInterval = 1
            manager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue()) {
                (data: CMDeviceMotion?, error: NSError?) in
                    if let gravity = data?.gravity {
                        let angle = atan2(data!.gravity.x, data!.gravity.y) + M_PI_2;           // in radians
                        let angleDegrees = angle * 180.0 / M_PI;   // in degrees
                        
                        
                        
                        let r = sqrt(data!.gravity.x * data!.gravity.x + data!.gravity.y * data!.gravity.y + data!.gravity.z * data!.gravity.z);
                        let tiltForwardBackward = acos(data!.gravity.z / r) * 180.0 / M_PI - 90.0;
                        let result = 1.82 / tan(tiltForwardBackward)
                        self.cameraLabel.text = "\(result)"
                    }
                }
            
        }
//        if manager.gyroAvailable {
//            
//            manager.gyroUpdateInterval = 0.5
//            manager.startGyroUpdates()
//            let queue = NSOperationQueue.mainQueue()
//            manager.startGyroUpdatesToQueue(queue) {
//                (data, error) in
//                let result = 1.83 / tan((data?.rotationRate.y)!)
//                print(result)
//            }
//        }
    }
    
    
    @IBOutlet weak var cameraLabel: UILabel!
    var delegate:CustomOverlayDelegate! = nil
    
    @IBAction func cancelButton(sender: UIButton) {
        cameraLabel.text = "I want to exit"
        delegate.didCancel(self)
    }
    @IBAction func shootButton(sender: UIButton) {
        cameraLabel.text = "Even Cooler Camera"
        delegate.didShoot(self)
    }
}