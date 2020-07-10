//
//  ViewController.swift
//  HitList
//
//  Created by Максим Шаптала on 10.07.2020.
//  Copyright © 2020 Максим Шаптала. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {

    var people: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "List"
        fetchPeople()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = people[indexPath.row].value(forKey: "name") as? String
        return cell
    }
    
    @IBAction
    fileprivate func addButtonHandle(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "New name", message: "Add new person name", preferredStyle: .alert)
        alertController.addTextField { (tf) in
            tf.placeholder = "Name"
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: { [unowned self] (action) in
            guard let tf = alertController.textFields?.first, let text = tf.text else { return }
            self.save(name: text)
            self.fetchPeople()
            self.tableView.reloadData()
        }))
        present(alertController, animated: true, completion: nil)
    }

    fileprivate func save(name: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Person", in: context) else { return }
        let person = NSManagedObject(entity: entity, insertInto: context)
        person.setValue(name, forKey: "name")
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error, "   ", error.userInfo)
        }
    }
    
    fileprivate func fetchPeople() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        do {
            let result = try context.fetch(fetchRequest)
            people = result
        } catch let error as NSError {
            print(error, "   ", error.userInfo)
        }
    }
    
}

