//
//  ViewController.swift
//  To Do List App
//
//  Created by Ale Escalante on 2/9/19.
//  Copyright © 2019 Ale Escalante. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    var toDoArray = ["Learn Swift", "Build Apps", "Change the World"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableview.delegate = self
        tableview.dataSource = self
    }
    // setting up the segue from my tableview(so my viewController?) to my DetailViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditItem"{
            let destination = segue.destination as! DetailViewController
            let index = tableview.indexPathForSelectedRow!.row
            destination.toDoItem = toDoArray[index]
        }else{
            if let selectedPath = tableview.indexPathForSelectedRow {
                tableview.deselectRow(at: selectedPath, animated: false)
            }
        }
    }
    @IBAction func unwindFromDetailViewController(segue:UIStoryboardSegue){
        let sourceViewController = segue.source as! DetailViewController
        if let indexPath = tableview.indexPathForSelectedRow{
            toDoArray[indexPath.row] = sourceViewController.toDoItem!
            tableview.reloadRows(at: [indexPath], with: .automatic)
        }else{
            let newIndexPath = IndexPath(row: toDoArray.count, section: 0)
            toDoArray.append(sourceViewController.toDoItem!)
            tableview.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = toDoArray[indexPath.row]
        return cell
    }
}
