//
//  DetailViewController.swift
//  To Do List App
//
//  Created by Ale Escalante on 2/10/19.
//  Copyright © 2019 Ale Escalante. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
   
    @IBOutlet weak var toDoField: UITextField!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode{
            dismiss(animated: true, completion: nil)
        }else{
            navigationController?.popViewController(animated: true)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
