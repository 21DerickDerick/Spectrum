//
//  MemberListCoordinator.swift
//  Spectrum
//
//  Created by Derick on 6/6/20.
//  Copyright © 2020 DerickDev. All rights reserved.
//

import UIKit

protocol MemberListCoordinatorDelegate: class {
    func didFinishSort(selection: String)
}

class MemberListCoordinator: Coordinator {
    private var presenter: UINavigationController
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var company: Company?
    weak var delegate: MemberListCoordinatorDelegate?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let vc = MemberListVC(nibName: "BaseTableViewController", bundle: nil)
        vc.delegate = self
        delegate = vc
        vc.company = company
        presenter.pushViewController(vc, animated: false)
    }
}

extension MemberListCoordinator: MemberListVCDelegate {
    func didDismissView() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func didTapSortButton(sortArr: [String], currentSortType: String) {
        let storyBoard = UIStoryboard(name: "SortBy", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SortByVC") as! SortByVC
        vc.sortArr = sortArr
        vc.delegate = self
        vc.currentSortType = currentSortType
        presenter.present(vc, animated: true, completion: nil)
    }
}

extension MemberListCoordinator: SortByVCDelegate {
    func didFinishSelection(selection: String) {
        delegate?.didFinishSort(selection: selection)
    }
}
