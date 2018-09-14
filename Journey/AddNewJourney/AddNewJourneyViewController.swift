//
//  AddNewJourneyViewController.swift
//  Journey
//
//  Created by chang-che-wei on 2018/9/14.
//  Copyright © 2018年 chang-che-wei. All rights reserved.
//

import UIKit

class AddNewJourneyViewController: UIViewController {

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
    }

}
