//
//  ViewController.swift
//  Instagrid-OC
//
//  Created by Levent Bostanci on 24/04/2018.
//  Copyright © 2018 Levent Bostanci. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController {
    
    var tag : Int?
    let imagePicker = UIImagePickerController()
    var tapGestureRecognizer : UITapGestureRecognizer?
    var swipeGestureRecognizer : UISwipeGestureRecognizer?
    

    @IBOutlet weak var centralView: CentralView!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    
    @IBAction func paterneButtonTapped(_ sender: UIButton) {
        unseclectButtons()
        switch sender.tag {
        case 0:
            centralView.displayLayout(id: 1, type: .one)
            firstButton.isSelected = true
        case 1:
            centralView.displayLayout(id: 2, type: .two)
            secondButton.isSelected = true
        case 2:
            centralView.displayLayout(id: 3, type: .three)
            thirdButton.isSelected = true
        default:
            break
        }
    }

}
    
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func AddPicture(_ sender: UIButton) {
        tag = sender.tag
        let myAlert = UIAlertController(title: "Select image from", message: "", preferredStyle: .actionSheet)
        myAlert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            self.AddImageFromCamera()
        }))
        myAlert.addAction(UIAlertAction(title: "Library", style: .default, handler: { (action: UIAlertAction) in
            self.AddImageFromLibrary()
        }))
        myAlert.addAction(UIAlertAction(title: "Canel", style: .cancel, handler: nil))
            self.present(myAlert, animated: true)
    }
    
    func AddImageFromCamera(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        } else {
            displayErrorPopUp(title: "Error", message: "No camera available")
        }
    }
    
    func AddImageFromLibrary(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            imagePicker.sourceType = .photoLibrary
            //                imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        guard let tag = tag else { return }
        centralView.imageViews[tag].image = image
        centralView.addButtons[tag].isHidden = true
        guard let tapGestureRecognizer = tapGestureRecognizer else { return }
        centralView.imageViews[tag].addGestureRecognizer(tapGestureRecognizer)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func imageError(image: UIImageView,didFinishSavingWithError error: NSErrorPointer, contextInfo: UnsafeRawPointer){
        if error != nil {
            displayErrorPopUp(title: "Save failed", message: "Failed to save image")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        centralView.isUserInteractionEnabled = true
        centralView.displayLayout(id: 1, type: .one)
        firstButton.isSelected = true
        setupSwipe()
        NotificationCenter.default.addObserver(self, selector: #selector(setupSwipe), name: .UIDeviceOrientationDidChange, object: nil)
    }
    
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        tag = tapGestureRecognizer.view?.tag
        let myAlert = UIAlertController(title: "Select image from", message: "", preferredStyle: .actionSheet)
        myAlert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            self.AddImageFromCamera()
        }))
        myAlert.addAction(UIAlertAction(title: "Library", style: .default, handler: { (action: UIAlertAction) in
            self.AddImageFromLibrary()
        }))
        myAlert.addAction(UIAlertAction(title: "Canel", style: .cancel, handler: nil))
        self.present(myAlert, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func unseclectButtons(){
        firstButton.isSelected = false
        secondButton.isSelected = false
        thirdButton.isSelected = false
    }
    
    func share(){
        if centralView.AvailableToShare() {
            guard let finalPicture = convertUiviewToImage(from: centralView) else { return }
            displayShareSheet(shareContent: finalPicture)
        } else {
            displayErrorPopUp(title: "Incomplet", message: "Veuillez remplir tous les champs")
        }
    }
    
    @objc func swipeDirection(){
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight{
            swipeGestureRecognizer?.direction = .left
        } else {
            swipeGestureRecognizer?.direction = .up
        }
    }
    
    @objc func setupSwipe(){
        swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(shareAnimation))
        guard let swipe = swipeGestureRecognizer else { return }
        swipeDirection()
        centralView.addGestureRecognizer(swipe)
    }
    
    @objc func shareAnimation(){
        let transformVertical = CGAffineTransform(translationX: 0, y: -view.frame.height)
        let transformLandscape = CGAffineTransform(translationX: -view.frame.width, y: 0 )
        if swipeGestureRecognizer?.direction == .up{
            UIView.animate(withDuration: 0.3, animations: { self.centralView.transform = transformVertical })
        } else {
            UIView.animate(withDuration: 0.3, animations: { self.centralView.transform = transformLandscape })
        }
    }
//
//    func convertToShare(){
//        guard let collage = convertUiviewToImage(from: centralView) else { return }
//        displayShareSheet(shareContent: collage)
//        }
    
    func displayShareSheet(shareContent:UIImage) {
        let activityViewController = UIActivityViewController(activityItems: [shareContent], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.postToFacebook, UIActivityType.postToTwitter]
        present(activityViewController, animated: true, completion: nil)
    }

    
    func convertUiviewToImage(from view:CentralView) -> UIImage?{
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        guard let img = UIGraphicsGetImageFromCurrentImageContext() else {return nil}
        UIGraphicsEndImageContext()
        return img
    }
    
}
