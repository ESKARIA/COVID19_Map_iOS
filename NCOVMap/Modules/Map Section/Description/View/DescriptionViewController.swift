//
//  DescriptionViewController.swift
//  NCOV_Map
//
//  Created by Emil Karimov on 17/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit
import SnapKit
import SPStorkController

final class DescriptionViewController: BaseViewController {

    var presenter: DescriptionPresenterProtocol!

    private var tableView = UITableView()
    private var dataSource = DescriptionDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        self.presenter.viewDidLoad()
    }

    private func createUI() {

        self.tableView.register(StatsTitleCell.self, forCellReuseIdentifier: StatsTitleCell.identifier)
        self.tableView.register(StatsTextCell.self, forCellReuseIdentifier: StatsTextCell.identifier)
        self.tableView.register(StatsStatisticsCell.self, forCellReuseIdentifier: StatsStatisticsCell.identifier)

        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.tableView.separatorStyle = .none
        self.tableView.tableFooterView = UIView()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension DescriptionViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.dataSource.tableView(tableView, cellForRowAt: indexPath)
    }
}

extension DescriptionViewController: DescriptionViewProtocol {

    func setContent(_ type: DescriptionCase, models: [ModelCountry]) {
        self.dataSource.type = type
        self.dataSource.models = models
    }
}

// MARK: - UIScrollViewDelegate
extension DescriptionViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        SPStorkController.scrollViewDidScroll(scrollView)
    }
}
