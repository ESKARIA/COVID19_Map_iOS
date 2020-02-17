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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showMapScreen()
    }
    
    private func showMapScreen() {
        let vc = self.resolver.presentMapViewController()
        let new = self.resolver.presentNavigationViewController(rootController: vc)
        self.addChild(new)
        self.view.addSubview(new.view)
        new.didMove(toParent: self)
        
        self.current = new
    }
}
