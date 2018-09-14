//
//  JourneyViewController.swift
//  Journey
//
//  Created by chang-che-wei on 2018/9/14.
//  Copyright © 2018年 chang-che-wei. All rights reserved.
//

import UIKit
import CoreData

class JourneyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var jonerysTableView: UITableView!
    var fetchAll = [CellData]()

    func tableViewXibSet() {
        self.jonerysTableView.register(UINib(nibName: "JourneysTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewXibSet()
        jonerysTableView.rowHeight = 230
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }

    func fetchData() {
        // core data
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate
            else {
                return
        }
        let context = appdelegate.persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CellData")
        do {
            self.fetchAll.removeAll()
            var fetchItem = [CellData]()
            if let request = try context.fetch(fetch) as? [CellData] {
                for result in request {
                    if let title = result.title,
                        let text = result.text {
                        print("title : \(title), text : \(text)")
                        fetchItem.append(result)
                    }
                    self.fetchAll = fetchItem.reversed()
                    jonerysTableView.reloadData()
                }
            }
        }
        catch {
            print("error")
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchAll.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? JourneysTableViewCell
            else {
                fatalError("JourneysTableView error")
        }
        let fetchItem =  fetchAll[indexPath.row]
        print(fetchAll)
        cell.journeyImageView.image = UIImage(data: fetchItem.image! as Data)
        cell.titleLabel.text = fetchItem.title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fetchItem = fetchAll[indexPath.row]
        if let showImageVC = storyboard?.instantiateViewController(withIdentifier: "AddNew") as? AddNewJourneyViewController {
            showImageVC.commedInit(edited: true, cellTitle: fetchItem.title!, imageData: fetchItem.image! as Data, cellText: fetchItem.text!)
            self.navigationController?.pushViewController(showImageVC, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "刪除") { (_ action, _ view, completionHandler) in
            print("delete")
            let fetchItem =  self.fetchAll[indexPath.row]
            self.deleteData(cellTitle: fetchItem.title!)
            completionHandler(true)
        }
        deleteAction.backgroundColor = .red
        let comfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        comfiguration.performsFirstActionWithFullSwipe = true
        return comfiguration
    }

    func deleteData(cellTitle: String) {
        // core data
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate
            else {
                return
        }
        let context = appdelegate.persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CellData")
        do {
            if let request = try context.fetch(fetch) as? [CellData] {
                for result in request {
                    if result.title == cellTitle {
                        context.delete(result)
                    }
                }
            }
        }
        catch {
            print("error")
        }
        appdelegate.saveContext()
        fetchData()
        jonerysTableView.reloadData()
    }
}
