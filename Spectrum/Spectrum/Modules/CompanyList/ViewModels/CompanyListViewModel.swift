//
//  CompanyListViewModel.swift
//  Spectrum
//
//  Created by Derick on 5/6/20.
//  Copyright © 2020 DerickDev. All rights reserved.
//

import Foundation

enum CompanySortType: String {
    case defaultType = "Default"
    case nameAscending = "Ascending Name"
}

class CompanyListViewModel {
    var currentDisplayCompanies: [Company] = []
    var defaultCompanies: [Company] = []
    var nameAscendingCompanies: [Company] = []
    var currentSortType = CompanySortType.defaultType.rawValue
    
    func getCompanyList(completion: @escaping () -> Void) {
        CompanyAndMemberProvider.shared.getCompanyList { (companies, error) in
            guard error == nil, let companies = companies else {
                completion()
                return
            }
            
            self.defaultCompanies = companies
            
            self.nameAscendingCompanies = companies.sorted {
                guard let name1 = $0.name, let name2 = $1.name else { return false }
                return name1 < name2
            }
            
            self.currentDisplayCompanies = companies

            completion()
        }
    }
}
