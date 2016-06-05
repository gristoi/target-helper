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
    var motionLastYaw : Double! = 0
    
    func degrees(radians:Double) -> Double {
        return 180 / M_PI * radians
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if manager.deviceMotionAvailable {
            manager.deviceMotionUpdateInterval = 0.2
            manager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue()) {
                (deviceMotion: CMDeviceMotion?, error: NSError?) in
                
                var attitude = deviceMotion!.attitude
                var roll = self.degrees(attitude.roll)
                var pitch = self.degrees(attitude.pitch)
                var yaw = self.degrees(attitude.yaw)
                print("Roll: \(roll), Pitch: \(pitch), Yaw: \(yaw)")
                let result = 1.8 * tan((M_PI * pitch)/180)
                self.cameraLabel.text = "\(result)"
//                
//                let angle = (180/M_PI)*(data?.attitude.pitch)!
//                let distance = 1.8 / tan(angle)
//                
//                let quat = data!.attitude.quaternion;
//                let yaw = asin(2*(quat.x*quat.z - quat.w*quat.y));
//                
//                if (self.motionLastYaw == 0) {
//                    self.motionLastYaw = yaw;
//                }
//                
//                // kalman filtering
//                var  q = 0.1;   // process noise
//                var  r = 0.1;   // sensor noise
//                var  p = 0.1;   // estimated error
//                var  k = 0.5;   // kalman filter gain
//                
//                var x = self.motionLastYaw;
//                p = p + q;
//                k = p / (p + r);
//                x = x + k*(yaw - x);
//                p = (1 - k)*p;
//                self.motionLastYaw = x;
//                self.cameraLabel.text = "\(self.motionLastYaw)"
//                    if let gravity = data?.gravity {
//                        let angle = atan2(data!.gravity.x, data!.gravity.y) + M_PI_2;           // in radians
//                        let angleDegrees = angle * 180.0 / M_PI;   // in degrees
//                        
//                        
//                        
//                        let r = sqrt(data!.gravity.x * data!.gravity.x + data!.gravity.y * data!.gravity.y + data!.gravity.z * data!.gravity.z);
//                        let tiltForwardBackward = acos(data!.gravity.z / r) * 180.0 / M_PI - 90.0;
//                        let result = 1.82 / tan(tiltForwardBackward)
//                        self.cameraLabel.text = "\(result)"
//                    }
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