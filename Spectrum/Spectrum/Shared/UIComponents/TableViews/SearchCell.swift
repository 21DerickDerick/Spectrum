//
//  SearchCell.swift
//  Spectrum
//
//  Created by Derick on 5/6/20.
//  Copyright © 2020 DerickDev. All rights reserved.
//

import UIKit

protocol SearchCellDelegate {
    func textDidChange(search: String)
}

class SearchCell: BaseTableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var searchTextField: SearchTextField!
    var delegate: SearchCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func setupUI() {
        super.setupUI()
        
        mainView.backgroundColor = .spectrumBackground
        searchTextField.placeholder = "Search by name"
        
        searchTextField.addTarget(self, action: #selector(textFieldDidChangeValue), for: UIControl.Event.editingChanged)
        
        searchTextField.delegate = self
    }
    
    @objc
    func textFieldDidChangeValue() {
        delegate?.textDidChange(search: searchTextField.text ?? "")
    }
}

extension SearchCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (string == "\n") {
            searchTextField.resignFirstResponder()
        }
        
        return true
    }
}

