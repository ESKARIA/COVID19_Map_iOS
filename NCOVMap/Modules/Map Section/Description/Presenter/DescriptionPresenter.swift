//
//  DescriptionPresenter.swift
//  NCOV_Map
//
//  Created by Emil Karimov on 17/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

class DescriptionPresenter: BasePresenter {

    weak var view: DescriptionViewProtocol?
    private var wireFrame: DescriptionWireFrameProtocol
    private var interactor: DescriptionInteractorProtocol
    private var type: DescriptionCase
    private var models: [ModelCountry]

    init(view: DescriptionViewProtocol, wireFrame: DescriptionWireFrameProtocol, interactor: DescriptionInteractorProtocol, type: DescriptionCase, models: [ModelCountry]) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
        self.type = type
        self.models = models
    }
}

extension DescriptionPresenter: DescriptionPresenterProtocol {
    
    func viewDidLoad() {
        self.view?.setContent(self.type, models: self.models)
    }
}
