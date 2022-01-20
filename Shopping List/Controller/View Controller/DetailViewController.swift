//
//  DetailViewController.swift
//  Shopping List
//
//  Created by Mitya Kim on 1/19/22.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    // MARK: - Properties
    var item: Item?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        updateView()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty,
              let body = bodyTextView.text, !body.isEmpty else { return }
        if let item = item {
            ItemController.shared.updateItem(item: item, title: title, body: body)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func updateView() {
        guard let item = item else { return }
        titleTextField.text = item.title
        bodyTextView.text = item.body

    }
}
