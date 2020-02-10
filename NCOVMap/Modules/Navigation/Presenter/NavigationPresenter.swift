//
//  NavigationPresenter.swift
//  NCOV_Map
//
//  Created by Dmitriy on 10/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

class NavigationPresenter: BasePresenter {

    weak var view: NavigationViewProtocol?
    private var wireFrame: NavigationWireFrameProtocol
    private var interactor: NavigationInteractorProtocol

    init(view: NavigationViewProtocol, wireFrame: NavigationWireFrameProtocol, interactor: NavigationInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

extension NavigationPresenter: NavigationPresenterProtocol { }
