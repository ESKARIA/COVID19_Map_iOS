//
//  MapWireFrame.swift
//  NCOV_Map
//
//  Created by Dmitriy on 10/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit
import SPStorkController

class MapWireFrame: BaseWireFrame { }

extension MapWireFrame: MapWireFrameProtocol {
    
    func presentStatisticsVC(from view: MapViewProtocol?) {
        
        guard let vc = view as? UIViewController else {
            return
        }
        
        let bottomSheetVC = self.resolver.presentStatisticsViewController()
        vc.addChild(bottomSheetVC)
        vc.view.addSubview(bottomSheetVC.view)
        bottomSheetVC.didMove(toParent: vc)
        
        let height = vc.view.frame.height
        let width  = vc.view.frame.width
        bottomSheetVC.view.frame = CGRect(x: 0, y: vc.view.frame.maxY, width: width, height: height)
    }
    
    func presentDescriptionViewController(from view: MapViewProtocol?, type: DescriptionCase, model: StatisticsModel) {
        guard let fromView = view as? UIViewController else { return }
        let controller = self.resolver.presentDescriptionViewController(type: type, model: model)
        fromView.presentAsStork(controller)
    }
}
