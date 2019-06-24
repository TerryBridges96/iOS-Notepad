//
//  NoteCategoryTableViewController.swift
//  NotePad
//
//  Created by Terry Bridges on 24/06/2019.
//  Copyright © 2019 Terry Bridges. All rights reserved.
//

import UIKit
import CoreData

class NoteCategoryTableViewController: UITableViewController {
    
    var noteArray = [Note]()

    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask ))
        //Load data
        loadNote()
        
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return noteArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteItemCell", for: indexPath)
        
        cell.textLabel?.text = noteArray[indexPath.row].title
        
        return cell
    }

    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new note", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newNote = Note(context: self.context)
            newNote.title = textField.text!
            
            self.noteArray.append(newNote)
            
            //save data
            self.saveNote()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Note"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    //Data Manipulation
    
    func saveNote() {
        
        do {
            try context.save()
        } catch {
            print("Error")
        }
    
        tableView.reloadData()
        
    }
    
    func loadNote() {
        
        let request : NSFetchRequest<Note> = Note.fetchRequest()
        
        do {
            noteArray = try context.fetch(request)
        } catch {
            print("Error fetching \(error)")
        }
        
        tableView.reloadData()
        
    }
    
}
