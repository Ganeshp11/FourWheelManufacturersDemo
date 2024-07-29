//
//  TableHeaderSearchView.swift
//  MachineTestIlaBank
//
//  Created by Neosoft on 24/06/24.
//

import UIKit
protocol CustomSearchBarDelegate {
    func searchBarTextDidChange(_ searchText: String)
    func searchBarCancelButtonClicked()
}

class TableHeaderSearchView: UITableViewHeaderFooterView {
    @IBOutlet var searchBar: UISearchBar!
    var searchDelegate: CustomSearchBarDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        searchBar.barTintColor = UIColor.black
        let color = UIColor.gray
        searchBar.searchTextField.textColor = UIColor.black
        searchBar.searchTextField.attributedPlaceholder =  NSAttributedString.init(string: StringConstants.searchPlaceholder, attributes: [NSAttributedString.Key.foregroundColor: color])
        searchBar.searchTextField.backgroundColor = UIColor.white
        searchBar.searchTextField.leftView?.tintColor = color
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
 
    func clearSearch() {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        self.searchBar.resignFirstResponder()
    }
}

extension TableHeaderSearchView : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {        searchDelegate?.searchBarTextDidChange(searchText)
        searchBar.showsCancelButton = !searchText.isEmpty
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        clearSearch()
        searchDelegate?.searchBarCancelButtonClicked()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
}


