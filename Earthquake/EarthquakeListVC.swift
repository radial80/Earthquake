//
//  EarthquakeListVC.swift
//  Earthquake
//
//  Created by Recep Uyduran on 6.03.2023.
//

import Foundation
import UIKit

class EartquakeListVC: UIViewController, EarthquakeTableViewCellDelegate {
    @IBOutlet weak var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    var manager = EarthquakeManager()
    var earthdata = [EarthquakeManagerData]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.getEartquakes()
        let textFieldCell = UINib(nibName: "EarthquakeTableViewCell", bundle: nil)
        tableView.register(textFieldCell, forCellReuseIdentifier: "EarthquakeTableViewCell")
        refreshControl.addTarget(self, action: #selector(refresh), for:  UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
    }
    @objc func refresh(send: UIRefreshControl) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
}
// MARK: - EarthquakeManagerDelegate
extension EartquakeListVC: EarthquakeManagerDelegate {
    func didUpdateEarthquake(response: BaseData) {
        earthdata = response.data
    }
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension EartquakeListVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return earthdata.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EarthquakeTableViewCell", for: indexPath) as! EarthquakeTableViewCell
        cell.setCell(data: earthdata[indexPath.row], delegate: self , index: indexPath.row)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
