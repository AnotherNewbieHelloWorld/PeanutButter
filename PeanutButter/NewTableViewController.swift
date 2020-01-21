//
//  NewTableViewController.swift
//  PeanutButter
//
//  Created by Apple User on 20.01.2020.
//  Copyright © 2020 Alena Khoroshilova. All rights reserved.
//

import UIKit

class NewTableViewController: UITableViewController {
    
    var peanutButter: PeanutButter!
    var imageIsChanged = false
    var like = false
    let dislikeImage = UIImage(systemName: "heart")
    let likeImage = UIImage(systemName: "heart.fill")

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tasteTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!    
    @IBOutlet weak var ratingStack: RatingControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect(x: 0,
                                                         y: 0,
                                                         width: tableView.frame.size.width,
                                                         height: 1))
        saveButton.isEnabled = false
        nameTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        setupEditScreen()
        like = peanutButter.like
    }
    
    @IBAction func chooseImage(_ sender: Any) {
        let cameraIcon = #imageLiteral(resourceName: "camera")
        let photoIcon = #imageLiteral(resourceName: "photo")
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Camera", style: .default) { _ in
            self.chooseImagePicker(source: .camera)
        }
        camera.setValue(cameraIcon, forKey: "image")
        camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let photo = UIAlertAction(title: "Photo", style: .default) { _ in
            self.chooseImagePicker(source: .photoLibrary)
        }
        photo.setValue(photoIcon, forKey: "image")
        photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        actionSheet.addAction(camera)
        actionSheet.addAction(photo)
        actionSheet.addAction(cancel)
        present(actionSheet, animated: true)
    }
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        like = !like
        if like == true {
            likeButton.setImage(likeImage, for: .normal)
        }
        else {
            likeButton.setImage(dislikeImage, for: .normal)
        }
    }
    
    //MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 1 {
            let cameraIcon = #imageLiteral(resourceName: "camera")
            let photoIcon = #imageLiteral(resourceName: "photo")
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            photo.setValue(photoIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            present(actionSheet, animated: true)
        }
        else {
            view.endEditing(true)
        }
    }
    
    // MARK: - Navigation

    func savePeanutButter() {
        let image = imageIsChanged ? imageView.image : #imageLiteral(resourceName: "sportyPeanut")
        let imageData = image?.pngData()
        
        let newPeanut = PeanutButter(name: nameTextField.text!,
                                     taste: tasteTextField.text,
                                     productInfo: textView.text,
                                     imageData: imageData,
                                     rating: Double(ratingStack.rating),
                                     like: like)
        if peanutButter != nil{
            try! realm.write {
                peanutButter?.name = newPeanut.name
                peanutButter?.taste = newPeanut.taste
                peanutButter?.productInfo = newPeanut.productInfo
                peanutButter?.imageData = newPeanut.imageData
                peanutButter?.rating = newPeanut.rating
                peanutButter?.like = newPeanut.like
            }
        }
        else {
            StoreManager.saveObject(newPeanut)
        }
    }
    
    func setupEditScreen() {
        if peanutButter != nil {
            setupNavigationBar()
            imageIsChanged = true
            guard let data = peanutButter?.imageData, let image = UIImage(data: data) else {
                return
            }
            imageView.image = image
            imageView.contentMode = .scaleAspectFill
            
            nameTextField.text = peanutButter?.name
            tasteTextField.text = peanutButter?.taste
            textView.text = peanutButter?.productInfo
            ratingStack.rating = Int(peanutButter.rating)
            // like
            if peanutButter.like == true {
                likeButton.setImage(likeImage, for: .normal)
            }
            else {
                likeButton.setImage(dislikeImage, for: .normal)
            }
        }
    }
    
    private func setupNavigationBar() {
        if let topItem = navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        navigationItem.leftBarButtonItem = nil
        title = peanutButter?.name
        saveButton.isEnabled = true
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
}
// MARK: - Text Field Delegate
    
extension NewTableViewController: UITextFieldDelegate{
    
    // Hide keyboard when user taps "Done" button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChanged() {
        if nameTextField.text?.isEmpty == false {
            saveButton.isEnabled = true
        }
        else {
            saveButton.isEnabled = false
        }
    }
}
// MARK: - Work With Image

extension NewTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            // choose who is delegate and whom delegate to
            imagePicker.delegate = self
            
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageView.image = info[.editedImage] as? UIImage
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        imageIsChanged = true
        dismiss(animated: true)
    }
}
