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
    
    init(resolver: DIResolver) {
        self.resolver = resolver
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
