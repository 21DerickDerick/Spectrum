//
//  NetworkProvider.swift
//  Spectrum
//
//  Created by Derick on 5/6/20.
//  Copyright © 2020 DerickDev. All rights reserved.
//

import Alamofire

class NetworkProvider {
    static var shared = NetworkProvider()
    
    func request(url: String, type: HTTPMethod, headers: [String: String], body: [String: Any]?, completion: @escaping (Data?, AFError?) -> Void) {
        
        if !ReachabilityManager.shared.hasConnection {
            AlertWireframe.shared.showNoInternetConnectionAlert(inViewController: ApplicationCoordinator.shared.window.rootViewController)
        }
        
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
        request.timeoutInterval = 60
        
        let httpHeaders = HTTPHeaders(headers)
        request.headers = httpHeaders
        
        if let body = body {
            let jsonData = try? JSONSerialization.data(withJSONObject: body)
            request.httpBody = jsonData
        }
        
        AF.request(request)
            .validate()
            .responseJSON(completionHandler: { (response) in
                
                switch response.result {
                case .failure(let error):
                    completion(nil, error)
                case .success:
                    completion(response.data, nil)
                }
        })
    }
}
