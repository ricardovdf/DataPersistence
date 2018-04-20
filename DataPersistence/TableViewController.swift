//
//  TableViewController.swift
//  DataPersistence
//
//  Created by Ricardo V Del Frari on 19/04/2018.
//  Copyright © 2018 Ricardo V Del Frari. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    //MARK: DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func uploadTableView() {
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ViewController.shared.data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = ViewController.shared.data[indexPath.row].text

        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            ViewController.shared.data.remove(at: indexPath.row)
            ViewController.shared.saveData()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

}
