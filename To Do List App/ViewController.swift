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
    
    @IBOutlet weak var EditBarButton: UIBarButtonItem!
    
    
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    var toDoNotesArray = ["I should be certain to do all the exercises at the end of the chapters before the exam", "Take myideas to the school's venture competition and win the big check", "Focus apps on empowerment for all, with extra hours for the users who are kind"]
    
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
            destination.toDoNoteItem = toDoNotesArray[index]
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
            toDoNotesArray[indexPath.row] = sourceViewController.toDoNoteItem!
            tableview.reloadRows(at: [indexPath], with: .automatic)
        }else{
            let newIndexPath = IndexPath(row: toDoArray.count, section: 0)
            toDoArray.append(sourceViewController.toDoItem!)
            toDoNotesArray.append(sourceViewController.toDoNoteItem!)
            tableview.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    @IBAction func editBarButtonPressed(_ sender: UIBarButtonItem) {
        if tableview.isEditing{
            tableview.setEditing(false, animated: true) // not exactly following this line
            addBarButton.isEnabled = true
            EditBarButton.title = "Edit"
        }else{
            tableview.setEditing(true, animated: true)
            addBarButton.isEnabled = false
            EditBarButton.title = "Done"
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
        cell.detailTextLabel?.text = toDoNotesArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            toDoArray.remove(at: indexPath.row)
            tableview.deleteRows(at: [indexPath], with: .fade)
        }
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = toDoArray[sourceIndexPath.row]
        let noteToMove = toDoNotesArray[sourceIndexPath.row]
        toDoArray.remove(at: sourceIndexPath.row)
        toDoNotesArray.remove(at: sourceIndexPath.row)
        toDoArray.insert(itemToMove, at: destinationIndexPath.row)
        toDoNotesArray.insert(noteToMove, at: destinationIndexPath.row)
    
    }
    
}
