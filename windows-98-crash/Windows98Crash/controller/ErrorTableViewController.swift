//
//  ErrorTableViewController.swift
//  Windows98Crash
//
//  Created by Otávio Baziewicz Filho on 16/05/19.
//  Copyright © 2019 Otávio Baziewicz Filho. All rights reserved.
//

import UIKit

class ErrorTableViewController: UITableViewController {

    let singleton: Model = Model.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return section == 0 ? self.singleton.windowsDiscoveredErrors.count : self.singleton.windowsDiscoveredCritical.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let index = indexPath.item
        print("Section", indexPath.section, index, self.singleton.windowsDiscoveredCritical.count, self.singleton.windowsDiscoveredErrors.count)
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageErrorCell", for: indexPath) as! ImageTableViewCell
            
            let error = self.singleton.windowsDiscoveredErrors[index]
            cell.backgroundColor = #colorLiteral(red: 0.01376754604, green: 0.08896108717, blue: 0.5588117242, alpha: 1)
            cell.imageView?.image = error.image
            
            return cell
        }
        
        // Configure the cell...
        let cell = tableView.dequeueReusableCell(withIdentifier: "textErrorCell", for: indexPath) as! TextTableViewCell
        let error = self.singleton.windowsDiscoveredCritical[index]
        cell.errorLabel.text = error
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
