//
//  TableHeaderSearchView.swift
//  MachineTestIlaBank
//
//  Created by Ashwini Mukade on 24/06/24.
//

import UIKit

class TableHeaderSearchView: UITableViewHeaderFooterView {
    
    //MARK: - @IBOutlet & Variables
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var isSearchActive: Bool = false {
        didSet {
            searchBar.searchTextField.text = isSearchActive ? searchBar.searchTextField.text : ""
        }
    }
    
    var searchText = "" {
        didSet {
            searchBar.searchTextField.placeholder = "Search car here"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        
        if let visualEffectView = self.subviews.first(where: { $0 is UIVisualEffectView }) as? UIVisualEffectView {
            visualEffectView.effect = nil
        }
        
        searchBar.barTintColor = .clear
        searchBar.searchTextField.backgroundColor = .white
    }
}
