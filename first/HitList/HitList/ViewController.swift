//
//  ViewController.swift
//  HitList
//
//  Created by Максим Шаптала on 10.07.2020.
//  Copyright © 2020 Максим Шаптала. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var names: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "List"
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        return cell
    }
    
    @IBAction func addButtonHandle(_ sender: UIBarButtonItem) {
    }

}

