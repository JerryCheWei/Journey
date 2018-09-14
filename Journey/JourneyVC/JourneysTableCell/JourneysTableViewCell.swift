//
//  JourneysTableViewCell.swift
//  Journey
//
//  Created by chang-che-wei on 2018/9/14.
//  Copyright © 2018年 chang-che-wei. All rights reserved.
//

import UIKit

class JourneysTableViewCell: UITableViewCell {

    @IBOutlet weak var journeyImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lineCircleView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        lineCircleView.layer.borderWidth = 0.5
        lineCircleView.layer.borderColor = UIColor(red: 171/255, green: 179/255, blue: 176/255, alpha: 1).cgColor

        journeyImageView.layer.shadowRadius = 2
        journeyImageView.layer.shadowColor = UIColor(red: 171/255, green: 179/255, blue: 176/255, alpha: 1).cgColor
        journeyImageView.layer.shadowOpacity = 0.4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
