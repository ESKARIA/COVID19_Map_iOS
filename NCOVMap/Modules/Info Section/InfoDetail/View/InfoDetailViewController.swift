//
//  InfoDetailViewController.swift
//  NCOV_Map
//
//  Created by Emil Karimov on 19/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit
import SnapKit

class InfoDetailViewController: BaseViewController {

    var presenter: InfoDetailPresenterProtocol!
    
    private var scrollView = UIScrollView()
    private var label_title: UILabel = UILabel.makeLabel(size: 17, weight: .bold, color: R.color.appMarineBlue().unwrapped())
    private var label_text: UILabel = UILabel.makeLabel(size: 10, weight: .regular, color: R.color.appDark().unwrapped())

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        self.presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    internal func createUI() {
        self.view.backgroundColor = R.color.appDark()

        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = R.color.appDark()
        self.navigationController?.navigationBar.tintColor = R.color.appLightGray()
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.left.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.equalTo(self.view)
            $0.height.equalTo(self.view)
        }
        
        let contentView = UIView()
        contentView.backgroundColor = .white
        self.scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.top.equalTo(self.scrollView).offset(40)
            $0.left.right.equalTo(self.view)
            $0.bottom.equalTo(self.scrollView).offset(-50)
        }
        contentView.cornerRadius(10)
        
        contentView.addSubview(self.label_title)
        self.label_title.numberOfLines = 0
        self.label_title.snp.makeConstraints {
            $0.left.right.equalTo(contentView).inset(31)
            $0.top.equalTo(contentView).offset(21)
        }
        
        contentView.addSubview(self.label_text)
        self.label_text.numberOfLines = 0
        self.label_text.snp.makeConstraints {
            $0.left.right.equalTo(contentView).inset(31)
            $0.top.equalTo(self.label_title.snp.bottom).offset(8)
            $0.bottom.equalTo(contentView).offset(-20)
        }
        
    }

}
extension InfoDetailViewController: InfoDetailViewProtocol {
    func setDetails(_ text: InfoRow) {
        self.label_title.text = text.title
        self.label_text.text = text.description
    }
}
