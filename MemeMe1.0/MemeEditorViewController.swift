//
//  MemeEditorViewController.swift
//  MemeMe1.0
//
//  Created by Celia Gómez de Villavedón on 27/3/17.
//  Copyright © 2017 Celia Gómez de Villavedón Pedrosa. All rights reserved.
//

import Foundation
import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var pickImageFromAlbum: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var topTextFieldTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var topToolBarTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    
    
    private func configureText(_ textField: UITextField) {
        
        let centeringText = NSMutableParagraphStyle()
        centeringText.alignment = .center
        
        let memeTextAttributes: [String:Any] = [
            NSStrokeColorAttributeName : UIColor.black,
            NSForegroundColorAttributeName : UIColor.white,
            NSFontAttributeName : UIFont(name: "Impact", size: 40)!,
            NSStrokeWidthAttributeName : -5.0,
            NSParagraphStyleAttributeName : centeringText
        ]
        
        textField.defaultTextAttributes = memeTextAttributes
        textField.delegate = self
        
    }
    
    //Placeholder Text Attributes
    let placeholderTextAttributes: [String:Any] = [
        NSStrokeColorAttributeName : UIColor.black,
        NSForegroundColorAttributeName : UIColor.white,
        NSFontAttributeName : UIFont(name: "Impact", size: 40)!,
        NSStrokeWidthAttributeName : -5.0,
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureText(topTextField)
        configureText(bottomTextField)
        topTextField.attributedPlaceholder = NSAttributedString(string: "TOP",
                                                                attributes: placeholderTextAttributes)
        bottomTextField.attributedPlaceholder = NSAttributedString(string: "BOTTOM",
                                                                   attributes: placeholderTextAttributes)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if self.imageView.image == nil {
            shareButton.isEnabled = false
        } else {
            shareButton.isEnabled = true
        }
        
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        subscribeToKeyboardNotifications()
        subscribeToKeyboardWillHideNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        unsubscribeFromKeyboardWillHideNotifications()
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
    }
    
    func subscribeToKeyboardWillHideNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    }
    
    func unsubscribeFromKeyboardWillHideNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(_ notification:Notification) {
        
        if bottomTextField.isFirstResponder {
            view.frame.origin.y -= getKeyboardHeight(notification)
            topTextFieldTopConstraint.constant -= getKeyboardHeight(notification)
            topToolBarTopConstraint.constant -= getKeyboardHeight(notification)
            imageViewTopConstraint.constant -= getKeyboardHeight(notification)
            
        }
    }
    
    func keyboardWillHide(_ notification:Notification) {
        
        if bottomTextField.isFirstResponder {
            view.frame.origin.y += getKeyboardHeight(notification)
            topTextFieldTopConstraint.constant += getKeyboardHeight(notification)
            topToolBarTopConstraint.constant += getKeyboardHeight(notification)
            imageViewTopConstraint.constant += getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing \(textField.tag)")
        textField.resignFirstResponder()
        
    }
    
    
    
    func generateMemedImage() -> UIImage {
        // Render view to an image
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        bottomToolBar.isHidden = true
        topToolBar.isHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        bottomToolBar.isHidden = false
        topToolBar.isHidden = false
        
        return memeImage
    }
    
    
    @IBAction func share(_ sender: Any) {
        let image = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.present(controller, animated: true, completion: nil)
        controller.completionWithItemsHandler = completionHandler
        
    }
    
    func completionHandler(activityType: UIActivityType?, shared: Bool, items: [Any]?, error: Error?) {
        if (shared) {
            save()
        }
        else {
            print("Bad user canceled sharing")
        }
    }
    

    //Create a meme object and add it to the meme's array
    func save() {
        //Update the meme
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageView.image!, memedImage: generateMemedImage())
        
        //Add it to the meme array on the App Delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
        
    }
    
    @IBAction func cancel (_ sender: AnyObject) {
        print("Cancelled")
        dismiss(animated: true, completion: nil)
    }
 
}

