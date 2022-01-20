//
//  ShoppingListTableViewController.swift
//  Shopping List
//
//  Created by Mitya Kim on 1/19/22.
//

import UIKit

class ShoppingListTableViewController: UITableViewController {
    
//    @IBOutlet weak var titleLabel: UILabel!
    
    var item: Item?
    var cell: ItemTableViewCell?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        ItemController.shared.loadFromPS()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - IBActions
    @IBAction func addButtonTapped(_ sender: Any) {
        let cancelAlert = UIAlertAction(title: "Cancel", style: .destructive)
        let alertController = UIAlertController(title: "Add Item", message: "Please add an item to your shopping list", preferredStyle: .alert)
        alertController.addTextField()
        let addAlert = UIAlertAction(title: "Add", style: .default)
        { [unowned alertController] _ in
            let titleTextField = alertController.textFields![0]
            guard let title = titleTextField.text, !title.isEmpty else { return }
            ItemController.shared.addItem(title: title, body: "", quality: 0)
            self.tableView.reloadData()
        }
        alertController.addAction(cancelAlert)
        alertController.addAction(addAlert)
        
        present(alertController, animated: true)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemController.shared.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? ItemTableViewCell else { return UITableViewCell() }
        let item = ItemController.shared.items[indexPath.row]
        cell.delegate = self
        cell.item = item

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let itemToDelete = ItemController.shared.items[indexPath.row]
            ItemController.shared.deleteItem(item: itemToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "shoppingDetailSegue" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? DetailViewController else { return }
            let item = ItemController.shared.items[indexPath.row]
            destinationVC.item = item
        }
    }
}

extension ShoppingListTableViewController: isDoneDelegate {
    func itemButtonTap(_ sender: ItemTableViewCell) {
        guard let item = sender.item else { return }
        ItemController.shared.toggleIsDone(item: item)
        sender.updateView()
    }
}
