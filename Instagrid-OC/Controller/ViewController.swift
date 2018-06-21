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
    
    @IBAction func addPicture(_ sender: UIButton) {
        tag = sender.tag
        let myAlert = UIAlertController(title: "Select image from", message: "", preferredStyle: .actionSheet)
        myAlert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            self.addImageFromCamera()
        }))
        myAlert.addAction(UIAlertAction(title: "Library", style: .default, handler: { (action: UIAlertAction) in
            self.addImageFromLibrary()
        }))
        myAlert.addAction(UIAlertAction(title: "Canel", style: .cancel, handler: nil))
            self.present(myAlert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        centralView.isUserInteractionEnabled = true
        centralView.displayLayout(id: 1, type: .one)
        firstButton.isSelected = true
        NotificationCenter.default.addObserver(self, selector: #selector(setupSwipe), name: .UIDeviceOrientationDidChange, object: nil)
    }
    
    func unseclectButtons(){
        firstButton.isSelected = false
        secondButton.isSelected = false
        thirdButton.isSelected = false
    }
    
    func addImageFromCamera(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        } else {
            displayErrorPopUp(title: "Error", message: "No camera available")
        }
    }
    
    func addImageFromLibrary(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        guard let tag = tag else { return }
        centralView.imageViews[tag].image = image
        centralView.addButtons[tag].isHidden = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
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
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        tag = tapGestureRecognizer.view?.tag
        let myAlert = UIAlertController(title: "Select image from", message: "", preferredStyle: .actionSheet)
        myAlert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            self.addImageFromCamera()
        }))
        myAlert.addAction(UIAlertAction(title: "Library", style: .default, handler: { (action: UIAlertAction) in
            self.addImageFromLibrary()
        }))
        myAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(myAlert, animated: true)
    }
    
    @objc func share(){
        if centralView.availableToShare() {
            guard let finalPicture = GridManager.convertUiviewToImage(from: centralView) else { return }
            displayShareSheet(shareContent: finalPicture)
        } else {
            displayErrorPopUp(title: "Incomplet", message: "Veuillez remplir tous les champs")
            backAnimation(duration: 0.5)
        }
    }
    
    func displayShareSheet(shareContent:UIImage) {
        let activityViewController = UIActivityViewController(activityItems: [shareContent], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.postToFacebook, UIActivityType.postToTwitter]
        present(activityViewController, animated: true, completion: nil)
        activityViewController.completionWithItemsHandler = { activity, completed, items, error in
            self.backAnimation(duration: 0.5)
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
        swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(shareAction(gesture:)))
        guard let swipe = swipeGestureRecognizer else { return }
        swipeDirection()
        centralView.addGestureRecognizer(swipe)
    }
  
    @objc func shareAction(gesture: UISwipeGestureRecognizer) {
        if swipeGestureRecognizer?.direction == .up{
            animation(duration: 0.5, delay: 0, x: 0, y: -view.frame.height) { self.share() }
        } else {
            animation(duration: 0.5, delay: 0, x: -view.frame.width, y: 0) { self.share() }
        }
    }
    
    func animation(duration: Double,delay : Double,x: CGFloat, y: CGFloat, onSuccess: @escaping () -> Void){
        UIView.animate(withDuration: duration, animations: {
            self.centralView.transform = CGAffineTransform(translationX: x, y: y)
        }) { (success) in
            onSuccess()
        }
    }
    
    func backAnimation(duration: Double){
        UIView.animate(withDuration: duration, animations: {
            self.centralView.transform = .identity
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //         Dispose of any resources that can be recreated.
    }
    
}
