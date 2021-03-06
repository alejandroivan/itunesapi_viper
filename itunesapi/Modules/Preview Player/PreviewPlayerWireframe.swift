//
//  PreviewPlayerWireframe.swift
//  itunesapi
//
//  Created by dpsmac1 on 09-05-18.
//  Copyright (c) 2018 Alejandro Iván. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class PreviewPlayerWireframe: BaseWireframe {

    // MARK: - Private properties -

    private let _storyboard = UIStoryboard(name: "PreviewPlayer", bundle: nil)

    // MARK: - Module setup -

    init(song: Media) {
        let moduleViewController = _storyboard.instantiateViewController(ofType: PreviewPlayerViewController.self)
        super.init(viewController: moduleViewController)
        
        let interactor = PreviewPlayerInteractor()
        let presenter = PreviewPlayerPresenter(wireframe: self, view: moduleViewController, interactor: interactor, song: song)
        interactor.presenter = presenter
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension PreviewPlayerWireframe: PreviewPlayerWireframeInterface {

    func navigate(to option: PreviewPlayerNavigationOption) {
    }
}
