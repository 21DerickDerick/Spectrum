//
//  CompanyAndMemberProvider.swift
//  Spectrum
//
//  Created by Derick on 5/6/20.
//  Copyright © 2020 DerickDev. All rights reserved.
//

import Alamofire

class CompanyAndMemberProvider {
    typealias companies = [Company]
    
    func getCompanyList(completion: @escaping (companies?, AFError?) -> Void) {
        let url = "https://next.json-generator.com/api/json/get/Vk-LhK44U"
        
        let headers: [String: String] = [:]
        
        NetworkProvider.shared.request(url: url, type: .get, headers: headers, body: nil) { data, error  in
            if let error = error {
                AlertWireframe.shared.showOneButtonAlert("Error", message: error.localizedDescription, actionButton: "OK", inViewController: ApplicationCoordinator.shared.window.rootViewController)
                completion(nil, error)
                return
            }
            
            if let data = data, let companies = try? JSONDecoder().decode(companies.self, from: data) {
            
                completion(companies, nil)
                return
            }
        }
    }
}
