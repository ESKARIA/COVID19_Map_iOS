//
//  RootViewController.swift
//  NCOVMap
//
//  Created by Дмитрий Торопкин on 10.02.2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    var resolver: DIResolver
    var current: UIViewController!
    
    init(resolver: DIResolver) {
        self.resolver = resolver
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showMapScreen()
    }
    
    private func showMapScreen() {
        let new = self.resolver.presentMapViewController()
        let navVC = self.resolver.presentNavigationViewController(rootController: new)
        self.addChild(navVC)
        self.view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        
        self.current = navVC
    }
}
