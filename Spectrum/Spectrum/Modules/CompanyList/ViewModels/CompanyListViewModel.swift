//
//  CompanyListViewModel.swift
//  Spectrum
//
//  Created by Derick on 5/6/20.
//  Copyright © 2020 DerickDev. All rights reserved.
//

import Foundation

class CompanyListViewModel {
    var provider = CompanyAndMemberProvider()
    var companies: [Company] = []
    
    func getCompanyList(completion: @escaping () -> Void) {
        provider.getCompanyList { (companies, error) in
            guard error == nil, let companies = companies else { return }
            
            self.companies = companies

            completion()
        }
    }
}
