//
//  DIResolver.swift
//  NCOVMap
//
//  Created by Дмитрий Торопкин on 10.02.2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit

class DIResolver {
    
    func rootViewController() -> UIViewController {

        let controller = RootViewController(resolver: self)
        return controller
    }
}
