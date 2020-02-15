//
//  StatisticsViewController.swift
//  NCOV_Map
//
//  Created by Dmitriy on 10/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit
import SnapKit

extension StatisticsViewController {
    private enum State {
        case partial
        case full
    }
    
    private enum Constant {
        static let fullViewYPosition: CGFloat = 100
        static var partialViewYPosition: CGFloat { UIScreen.main.bounds.height - 100 }
    }
}

class StatisticsViewController: BaseViewController {

    var presenter: StatisticsPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(panGesture))
        self.view.addGestureRecognizer(gesture)
        self.roundViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.6, animations: {
            self.moveView(state: .partial)
        })
    }
    
    private func createUI() {
        self.view.backgroundColor = .white
    }
    
    private func moveView(state: State) {
        let yPosition = state == .partial ? Constant.partialViewYPosition : Constant.fullViewYPosition
        self.view.frame = CGRect(x: 0, y: yPosition, width: self.view.frame.width, height: self.view.frame.height)
    }

    private func moveView(panGestureRecognizer recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        let minY = self.view.frame.minY
        
        if (minY + translation.y >= Constant.fullViewYPosition) && (minY + translation.y <= Constant.partialViewYPosition) {
            self.view.frame = CGRect(x: 0, y: minY + translation.y, width: self.view.frame.width, height: self.view.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        }
    }
    
    @objc private func panGesture(_ recognizer: UIPanGestureRecognizer) {
        moveView(panGestureRecognizer: recognizer)
        
        if recognizer.state == .ended {
            UIView.animate(withDuration: 1, delay: 0.0, options: [.allowUserInteraction], animations: {
                let state: State = recognizer.velocity(in: self.view).y >= 0 ? .partial : .full
                self.moveView(state: state)
            }, completion: nil)
        }
    }
    
    func roundViews() {
        self.view.layer.cornerRadius = 10
        self.view.clipsToBounds = true
    }
    

}
extension StatisticsViewController: StatisticsViewProtocol { }
