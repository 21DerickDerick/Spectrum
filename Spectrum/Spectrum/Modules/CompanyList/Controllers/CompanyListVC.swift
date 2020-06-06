//
//  CompanyListVC.swift
//  Spectrum
//
//  Created by Derick on 5/6/20.
//  Copyright © 2020 DerickDev. All rights reserved.
//

import UIKit

protocol CompanyListVCDelegate {
    func didTapSortButton(sortArr: [String], currentSortType: String)
    func didTapCompany(company: Company)
}

class CompanyListVC: BaseTableViewController {
    
    let viewModel = CompanyListViewModel()
    var delegate: CompanyListVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showLoadingIndicator()
        viewModel.getCompanyList {
            self.hideLoadingIndicator()
            self.tableView.reloadData()
        }
    }
    
    override func setupUI() {
        super.setupUI()
        setupSortButtonUI()
        
        title = "Companies"
    }
    
    override func registerNIB() {
        super.registerNIB()

        [SearchCell.self, CompanyCell.self].forEach { (type) in
            tableView.register(UINib(nibName: String(describing: type), bundle: nil), forCellReuseIdentifier: String(describing: type))
        }
    }
    
    func setupSortButtonUI() {
        let sortButton = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(didTapSortButton))
        sortButton.tintColor = UIColor.spectrumMain
        navigationItem.rightBarButtonItem = sortButton
    }
    
    @objc
    func didTapSortButton() {
        delegate?.didTapSortButton(sortArr: [CompanySortType.defaultType.rawValue, CompanySortType.nameAscending.rawValue], currentSortType: viewModel.currentSortType)
    }
}

extension CompanyListVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + viewModel.currentDisplayCompanies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SearchCell.self), for: indexPath) as! SearchCell
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CompanyCell.self), for: indexPath) as! CompanyCell
            let company = viewModel.currentDisplayCompanies[indexPath.row - 1]
            cell.setupCell(company: company)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row > 0 else { return }
        
        let company = viewModel.currentDisplayCompanies[indexPath.row - 1]
        delegate?.didTapCompany(company: company)
    }
}

extension CompanyListVC: CompanyListCoordinatorDelegate {
    func didFinishSort(selection: String) {
        switch selection {
        case CompanySortType.defaultType.rawValue:
            viewModel.currentDisplayCompanies = viewModel.defaultCompanies
            viewModel.currentSortType = CompanySortType.defaultType.rawValue
        case CompanySortType.nameAscending.rawValue:
            viewModel.currentDisplayCompanies = viewModel.nameAscendingCompanies
            viewModel.currentSortType = CompanySortType.nameAscending.rawValue
        default:
            break
        }

        tableView.reloadData()
    }
}

extension CompanyListVC: SearchCellDelegate {
    func textDidChange(search: String) {
        if search.trimmingCharacters(in: .whitespaces) == "" {
            switch viewModel.currentSortType {
            case CompanySortType.defaultType.rawValue:
                viewModel.currentDisplayCompanies = viewModel.defaultCompanies
            case CompanySortType.nameAscending.rawValue:
                viewModel.currentDisplayCompanies = viewModel.nameAscendingCompanies
            default:
                break
            }
            tableView.reloadData()
        } else {
            viewModel.currentDisplayCompanies = viewModel.defaultCompanies.filter {
                guard let name = $0.name else { return false }
                return name.lowercased().contains(search.lowercased())
            }
            
            if viewModel.currentSortType == CompanySortType.nameAscending.rawValue {
                viewModel.currentDisplayCompanies = viewModel.currentDisplayCompanies.sorted {
                    guard let name1 = $0.name, let name2 = $1.name else { return false }
                    return name1 < name2
                }
            }
            
            tableView.reloadData()
        }
    }
}
