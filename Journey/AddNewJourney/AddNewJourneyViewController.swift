//
//  AddNewJourneyViewController.swift
//  Journey
//
//  Created by chang-che-wei on 2018/9/14.
//  Copyright © 2018年 chang-che-wei. All rights reserved.
//

import UIKit
import CoreData

class AddNewJourneyViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    @IBOutlet weak var textTextView: UITextView!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var imageViewLabel: UILabel!
    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var addImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    var imageData = Data()
    @IBAction func saveButtonAction(_ sender: Any) {
        self.saveData()
        dismiss(animated: true, completion: nil)
    }
    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    func imageViewBackColorSet() {
        addImageView.backgroundColor = .gray
    }
    func saveButtonColorSet() {
        saveButton.layer.shadowColor = UIColor(red: 247/255, green: 147/255, blue: 163/255, alpha: 1).cgColor
        saveButton.layer.shadowOpacity = 0.7
        saveButton.layer.shadowRadius = 10
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageViewBackColorSet()
        self.saveButtonColorSet()
        // 點擊imageView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imagePressed))
        addImageView.isUserInteractionEnabled = true
        addImageView.addGestureRecognizer(tapGesture)
        // reload
        self.titleTextView.text = ""
        self.textTextView.text = ""
        // keyboard set
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }

    @objc func keyboardWillShow(notify: NSNotification) {

        if let keyboardSize = (notify.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    @objc func keyboardWillHide(notify: NSNotification) {

        if let keyboardSize = (notify.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc func imagePressed() {
        print("Open photo library")
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        var selectedImageFromPicker: UIImage?
        // 取得從 UIImagePickerController 選擇到的檔案
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImageFromPicker = pickedImage
            self.imageData = UIImageJPEGRepresentation(pickedImage, 1)!
        }
        // 關閉圖庫
        dismiss(animated: true, completion: nil)
        self.addImageView.image = selectedImageFromPicker
        self.imageViewIcon.isHidden = true
        self.imageViewLabel.isHidden = true
    }

    func saveData() {
        // core data
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate
        else {
            return
        }
        let context = appdelegate.persistentContainer.viewContext
        let cellData = NSEntityDescription.insertNewObject(forEntityName: "CellData", into: context)
        cellData.setValue(self.titleTextView.text, forKey: "title")
        cellData.setValue(self.textTextView.text, forKey: "text")
        cellData.setValue(self.imageData, forKey: "image")
        appdelegate.saveContext()
    }
//    func fetchData() {
//        // core data
//        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate
//            else {
//                return
//        }
//        let context = appdelegate.persistentContainer.viewContext
//        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CellData")
//        do {
//            if let request = try context.fetch(fetch) as? [CellData] {
//                for result in request {
//                    if let title = result.title,
//                        let text = result.text {
//                        print("title : \(title), text : \(text)")
//                    }
//
//                }
//            }
//        }
//        catch {
//            print("error")
//        }
//    }

}
