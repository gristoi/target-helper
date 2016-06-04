//
//  ViewController.swift
//  Target Helper
//
//  Created by Ian Gristock on 16/05/2016.
//  Copyright © 2016 Ian Gristock. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate,
    CustomOverlayDelegate
{
    
    var picker = UIImagePickerController()
    //MARK: - Actions
    @IBAction func shootPhoto(sender: UIButton) {
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
            picker = UIImagePickerController() //make a clean controller
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.cameraCaptureMode = .Photo
            picker.showsCameraControls = false
            //picker.delegate = self  //uncomment if you want to take multiple pictures.
            
            
            //customView stuff
            let customViewController = CustomOverlayViewController(
                nibName:"CustomOverlayViewController",
                bundle: nil
            )
            let customView:CustomOverlayView = customViewController.view as! CustomOverlayView
            customView.frame = self.picker.view.frame
            customView.cameraLabel.text = "Hello Cute Camera"
            customView.delegate = self
            
            //presentation of the camera
            picker.modalPresentationStyle = .FullScreen
            presentViewController(picker,
                                  animated: true,
                                  completion: {
                                    self.picker.cameraOverlayView = customView
            })
            
        } else { //no camera found -- alert the user.
            let alertVC = UIAlertController(
                title: "No Camera",
                message: "Sorry, this device has no camera",
                preferredStyle: .Alert)
            let okAction = UIAlertAction(
                title: "OK",
                style:.Default,
                handler: nil)
            alertVC.addAction(okAction)
            presentViewController(
                alertVC,
                animated: true,
                completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - Delegates
    
    //MARK: Image Picker Controller Delegates
    func imagePickerController(
        picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //get the image from info
        UIImageWriteToSavedPhotosAlbum(chosenImage, self,nil, nil) //save to the photo library
    }
    //What to do if the image picker cancels.
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true,
                                      completion: nil)
        print("Canceled!!")
    }
    
    //MARK: Custom View Delegates
    func didCancel(overlayView:CustomOverlayView) {
        picker.dismissViewControllerAnimated(true,
                                             completion: nil)
        print("dismissed!!")
    }
    func didShoot(overlayView:CustomOverlayView) {
        picker.takePicture()
        overlayView.cameraLabel.text = "Shot Photo"
        print("Shot Photo")
    }
}


