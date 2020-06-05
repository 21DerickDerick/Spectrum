//
//  SortByVC.swift
//  Spectrum
//
//  Created by Derick on 5/6/20.
//  Copyright © 2020 DerickDev. All rights reserved.
//

import UIKit

protocol SortByVCDelegate {
    func didFinishSelection(selection: String)
}

class SortByVC: UIViewController {
        
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var sortArr = [String]()
    var selectedRow = 0
    var currentSortType: String?
    var delegate: SortByVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.dataSource = self
        pickerView.delegate = self
        
        setupUI()
    }
    
    func setupUI() {
        doneButton.title = "Done"
        
        if let currentSortType = currentSortType {
            for (index, sortType) in sortArr.enumerated() {
                if sortType == currentSortType {
                    selectedRow = index
                    pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
                    return
                }
            }
        }
    }
    
    @IBAction func didTapDoneButton(_ sender: UIBarButtonItem) {
        let selectedSortType = sortArr[selectedRow]
        delegate?.didFinishSelection(selection: selectedSortType)
        dismiss(animated: true, completion: nil)
    }
}

extension SortByVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sortArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let view = view as? UILabel { label = view }
        label.font = UIFont.main
        let sortValue = sortArr[row]
        label.text =  sortValue
        label.textAlignment = .center
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
    }
}
