//
//  JourneyViewController.swift
//  Journey
//
//  Created by chang-che-wei on 2018/9/14.
//  Copyright © 2018年 chang-che-wei. All rights reserved.
//

import UIKit

class JourneyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var jonerysTableView: UITableView!

    func tableViewXibSet() {
        self.jonerysTableView.register(UINib(nibName: "JourneysTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewXibSet()
        jonerysTableView.rowHeight = 230
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? JourneysTableViewCell
            else {
                fatalError("JourneysTableView error")
        }

        return cell
    }
}
