//
//  StatisticsPresenter.swift
//  NCOV_Map
//
//  Created by Dmitriy on 10/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

class StatisticsPresenter: BasePresenter {

    weak var view: StatisticsViewProtocol?
    private var wireFrame: StatisticsWireFrameProtocol
    private var interactor: StatisticsInteractorProtocol

    init(view: StatisticsViewProtocol, wireFrame: StatisticsWireFrameProtocol, interactor: StatisticsInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

extension StatisticsPresenter: StatisticsPresenterProtocol { }
