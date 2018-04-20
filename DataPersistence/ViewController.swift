//
//  ViewController.swift
//  DataPersistence
//
//  Created by Ricardo V Del Frari on 19/04/2018.
//  Copyright © 2018 Ricardo V Del Frari. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var toSaveTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    //MARK: Properties
    
    //Singleton
    static let shared = ViewController()
    
    var tableView = TableViewController()
    var data : [DataModel] = []

    //MARK: DidLoad
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        toSaveTextField.delegate = self

        if let savedData = loadData() {
            ViewController.shared.data += savedData
            print(data.count)
        }
        
        // Hide the keyboard
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))

        updateSaveButtonState()
        tableView.uploadTableView()
    }

    //MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }

    //MARK: Data Persistence
    private func loadData() -> [DataModel]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: DataModel.ArchiveURL.path) as? [DataModel]
    }
    
    func saveData() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(ViewController.shared.data, toFile: DataModel.ArchiveURL.path)
        if isSuccessfulSave {
            print("Data successfully saved.")
        } else {
            print("Failed to save data...")
        }
    }
    
    //MARK: Button Methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = toSaveTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }

    @IBAction func saveData(_ sender: UIButton) {
        ViewController.shared.data.append(DataModel(text:toSaveTextField.text!))
        tableView.uploadTableView()
        toSaveTextField.text = ""
        updateSaveButtonState()
        saveData()
    }
    
    //Use to reload table view when inside a container
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "textTableView"
        {
            if let destinationVC = segue.destination as? TableViewController {
                tableView = destinationVC
            }
        }
    }
}

