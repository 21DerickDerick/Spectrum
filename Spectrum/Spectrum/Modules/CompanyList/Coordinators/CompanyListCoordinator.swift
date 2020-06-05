//
//  CompanyListCoordinator.swift
//  Spectrum
//
//  Created by Derick on 5/6/20.
//  Copyright © 2020 DerickDev. All rights reserved.
//

import UIKit

protocol CompanyListCoordinatorDelegate: class {
    func didFinishSort(selection: String)
}

class CompanyListCoordinator: Coordinator {
    let window: UIWindow
    private var presenter: UINavigationController
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    weak var delegate: CompanyListCoordinatorDelegate?
    
    init(presenter: UINavigationController, window: UIWindow) {
        self.window = window
        self.presenter = presenter
    }
    
    func start() {
        let vc = CompanyListVC(nibName: "BaseTableViewController", bundle: nil)
        vc.delegate = self
        self.delegate = vc
        self.window.rootViewController = presenter
        presenter.pushViewController(vc, animated: false)
    }
}

extension CompanyListCoordinator: CompanyListVCDelegate {
    func didTapSortButton(sortArr: [String], currentSortType: String) {
        let storyBoard = UIStoryboard(name: "SortBy", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SortByVC") as! SortByVC
        vc.sortArr = sortArr
        vc.delegate = self
        vc.currentSortType = currentSortType
        presenter.present(vc, animated: true, completion: nil)
    }
}

extension CompanyListCoordinator: SortByVCDelegate {
    func didFinishSelection(selection: String) {
        delegate?.didFinishSort(selection: selection)
    }
}
