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
    @IBOutlet weak var separatorView: UIView!
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
        separatorView.backgroundColor = UIColor.spectrumFollowButton.withAlphaComponent(0.3)
        searchTextField.placeholder = "Search by name"
        searchTextField.delegate = self
    }
}

extension SearchCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.textDidChange(search: searchTextField.text ?? "")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (string == "\n") {
            searchTextField.resignFirstResponder()
        }
        
        return true
    }
}

