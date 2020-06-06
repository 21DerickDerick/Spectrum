//
//  MemberListViewModel.swift
//  Spectrum
//
//  Created by Derick on 6/6/20.
//  Copyright © 2020 DerickDev. All rights reserved.
//

import Foundation

enum MemberListSortType: String {
    case defaultType = "Default"
    case nameAscending = "Ascending Name"
    case age = "Age"
}

class MemberListViewModel {
    var currentSortType = MemberListSortType.defaultType.rawValue
    var currentDisplayMembers: [Member] = []
    var defaultMembers: [Member] = []
    var nameAscendingMembers: [Member] = []
    var sortByAgeMembers: [Member] = []
    var currentQueryText = ""
    
    func setupMembers(company: Company?) {
        guard let company = company else { return }
        
        defaultMembers = company.members
        nameAscendingMembers = defaultMembers.sorted {
            guard let firstName1 = $0.name?.first, let firstName2 = $1.name?.first else { return false }
            return firstName1 < firstName2
        }
        
        sortByAgeMembers = defaultMembers.sorted {
            guard let member1Age = $0.age, let member2Age = $1.age else { return false }
            return member1Age < member2Age
        }
        
        currentDisplayMembers = defaultMembers
    }
}
