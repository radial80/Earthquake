//
//  ViewController.swift
//  Earthquake
//
//  Created by Recep Uyduran on 6.03.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            self.navigate()
        }
    }
    func navigate() {
        let secondWievController = self.storyboard?.instantiateViewController(withIdentifier: "EartquakeListVC") as! EartquakeListVC
        self.navigationController?.setViewControllers([secondWievController], animated: true)
    }
}

