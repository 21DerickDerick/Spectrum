//
//  MemberListVC.swift
//  Spectrum
//
//  Created by Derick on 6/6/20.
//  Copyright © 2020 DerickDev. All rights reserved.
//

import UIKit

protocol MemberListVCDelegate {
    func didDismissView()
    func didTapSortButton(sortArr: [String], currentSortType: String)
}

class MemberListVC: BaseTableViewController {
    
    var delegate: MemberListVCDelegate?
    var company: Company?
    var viewModel = MemberListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.setupMembers(company: company)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        delegate?.didDismissView()
    }
    
    override func setupUI() {
        super.setupUI()
        setupSortButtonUI()
        
        title = "Members"
    }
    
    override func registerNIB() {
        super.registerNIB()

        [SearchCell.self, MemberCell.self].forEach { (type) in
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
        delegate?.didTapSortButton(sortArr: [MemberListSortType.defaultType.rawValue, MemberListSortType.nameAscending.rawValue, MemberListSortType.age.rawValue], currentSortType: viewModel.currentSortType)
    }
}

extension MemberListVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + viewModel.currentDisplayMembers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SearchCell.self), for: indexPath) as! SearchCell
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MemberCell.self), for: indexPath) as! MemberCell
            let member = viewModel.currentDisplayMembers[indexPath.row - 1]
            cell.setupCell(member: member)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension MemberListVC: MemberListCoordinatorDelegate {
    func didFinishSort(selection: String) {
        switch selection {
        case MemberListSortType.defaultType.rawValue:
            viewModel.currentDisplayMembers = viewModel.defaultMembers
            viewModel.currentSortType = MemberListSortType.defaultType.rawValue
        case MemberListSortType.nameAscending.rawValue:
            viewModel.currentDisplayMembers = viewModel.nameAscendingMembers
            viewModel.currentSortType = MemberListSortType.nameAscending.rawValue
        case MemberListSortType.age.rawValue:
            viewModel.currentDisplayMembers = viewModel.sortByAgeMembers
            viewModel.currentSortType = MemberListSortType.age.rawValue
        default:
            break
        }

        tableView.reloadData()
    }
}

extension MemberListVC: SearchCellDelegate {
    func textDidChange(search: String) {
        if search.trimmingCharacters(in: .whitespaces) == "" {
            switch viewModel.currentSortType {
            case MemberListSortType.defaultType.rawValue:
                viewModel.currentDisplayMembers = viewModel.defaultMembers
            case MemberListSortType.nameAscending.rawValue:
                viewModel.currentDisplayMembers = viewModel.nameAscendingMembers
            case MemberListSortType.age.rawValue:
                viewModel.currentDisplayMembers = viewModel.sortByAgeMembers
            default:
                break
            }
            tableView.reloadData()
        } else {
            viewModel.currentDisplayMembers = viewModel.defaultMembers.filter {
                guard let firstName = $0.name?.first, let lastName = $0.name?.last else { return false }
                return firstName.lowercased().contains(search.lowercased()) || lastName.lowercased().contains(search.lowercased())
            }

            if viewModel.currentSortType == CompanySortType.nameAscending.rawValue {
                viewModel.currentDisplayMembers = viewModel.currentDisplayMembers.sorted {
                    guard let firstName1 = $0.name?.first, let firstName2 = $1.name?.last else { return false }
                    return firstName1 < firstName2
                }
            }

            tableView.reloadData()
        }
    }
}

