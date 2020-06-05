//
//  CompanyListVC.swift
//  Spectrum
//
//  Created by Derick on 5/6/20.
//  Copyright © 2020 DerickDev. All rights reserved.
//

import UIKit

class CompanyListVC: BaseTableViewController {
    
    let viewModel = CompanyListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.getCompanyList {
            self.tableView.reloadData()
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        title = "Companies"
    }
    
    override func registerNIB() {
        super.registerNIB()

        [SearchCell.self, CompanyCell.self].forEach { (type) in
            tableView.register(UINib(nibName: String(describing: type), bundle: nil), forCellReuseIdentifier: String(describing: type))
        }
    }
}

extension CompanyListVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + viewModel.companies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SearchCell.self), for: indexPath) as! SearchCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CompanyCell.self), for: indexPath) as! CompanyCell
            let company = viewModel.companies[indexPath.row - 1]
            cell.setupCell(logoURL: company.logo,
                           companyName: company.name,
                           companyWebsite: company.website, companyDescription: company.about)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

