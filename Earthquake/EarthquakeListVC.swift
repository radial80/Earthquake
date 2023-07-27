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
    @IBOutlet weak var searchBar: UISearchBar!
    var isSearched = false
    var filteredData = [Codable]()
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

        hideKeyboardWhenTappedAround()
        title = "Son Depremler"
        manager.delegate = self
        manager.getEartquakes()
        let textFieldCell = UINib(nibName: "EarthquakeTableViewCell", bundle: nil)
        tableView.register(textFieldCell, forCellReuseIdentifier: "EarthquakeTableViewCell")
        refreshControl.addTarget(self, action: #selector(refresh), for:  UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
        tableView.keyboardDismissMode = .onDrag
    }
    @objc func refresh(send: UIRefreshControl) {
        DispatchQueue.main.async {
            self.manager.getEartquakes()

        }
    }
}
// MARK: - EarthquakeManagerDelegate
extension EartquakeListVC: EarthquakeManagerDelegate {
    func didUpdateEarthquake(response: BaseData) {
        earthdata = response.data
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension EartquakeListVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearched == true {
            return filteredData.count
        } else {
            return earthdata.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EarthquakeTableViewCell", for: indexPath) as! EarthquakeTableViewCell
        if isSearched == true {
            cell.setCell(data: filteredData[indexPath.row] as! EarthquakeManagerData, delegate: self , index: indexPath.row)
        } else {
            cell.setCell(data: earthdata[indexPath.row], delegate: self , index: indexPath.row)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

//MARK: - UISearchBarDelegate

extension EartquakeListVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            filteredData =
            earthdata.filter({$0.yer.lowercased().uppercased().prefix(searchText.count) == searchText.lowercased().uppercased()})
        }
        isSearched = true
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearched = false
        self.searchBar.text = ""
        self.searchBar.endEditing(true)
        tableView.reloadData()
    }
}

//MARK: - SearchBar Keyboard Dismiss
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(self.isEditing)
    }
}
