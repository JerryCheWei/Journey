//
//  AddNewJourneyViewController.swift
//  Journey
//
//  Created by chang-che-wei on 2018/9/14.
//  Copyright © 2018年 chang-che-wei. All rights reserved.
//

import UIKit

class AddNewJourneyViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageViewLabel: UILabel!
    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var addImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBAction func saveButtonAction(_ sender: Any) {
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
        }
        // 關閉圖庫
        dismiss(animated: true, completion: nil)
        self.addImageView.image = selectedImageFromPicker
        self.imageViewIcon.isHidden = true
        self.imageViewLabel.isHidden = true
    }
}
