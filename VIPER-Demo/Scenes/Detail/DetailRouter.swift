//
//  DetailRouter.swift
//  VIPER-Demo
//
//  Created by Martin Regas on 07/09/2022.
//

import UIKit

typealias DetailView = DetailViewProtocol & UIViewController

protocol DetailRouterProtocol {
    var view: DetailView? { get }
    
    static func start(with character: Character) -> DetailRouterProtocol
}

class DetailRouter: DetailRouterProtocol {
    var view: DetailView?
    
    static func start(with character: Character) -> DetailRouterProtocol {
        let detailRouter = DetailRouter()
        
        let view: DetailViewProtocol = DetailViewController()
        let presenter: DetailPresenterProtocol = DetailPresenter()
        let interactor: DetailInteractorProtocol = DetailInteractor()

        view.presenter = presenter
                
        interactor.presenter = presenter

        presenter.view = view
        presenter.router = detailRouter
        presenter.character = character
        presenter.interactor = interactor
        
        detailRouter.view = view as? DetailView
                
        return detailRouter
    }
}
