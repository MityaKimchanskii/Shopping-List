//
//  ItemTableViewCell.swift
//  Shopping List
//
//  Created by Mitya Kim on 1/19/22.
//

import UIKit

protocol isDoneDelegate: AnyObject {
    func itemButtonTap(_ sender: ItemTableViewCell)
}

class ItemTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var isDoneButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var item: Item? {
        didSet {
            updateView()
        }
    }
    
    weak var delegate: isDoneDelegate?
    
    // MARK: - IBActions
    @IBAction func isDoneButtonTapped(_ sender: Any) {
        if let delegate = delegate {
            delegate.itemButtonTap(self)
        }
    }
    
    // MARK: - Other Methods
    func updateView() {
        guard let item = item else { return }
        titleLabel.text = item.title
        if item.isDone {
            isDoneButton.setBackgroundImage(UIImage(named: "complete"), for: .normal)
        } else {
            isDoneButton.setBackgroundImage(UIImage(named: "incomplete"), for: .normal)
        }
    }
}
