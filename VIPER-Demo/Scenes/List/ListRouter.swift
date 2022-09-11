//
//  ListRouter.swift
//  VIPER-Demo
//
//  Created by Martin Regas on 07/09/2022.
//

import UIKit

typealias EntryPoint = ListViewProtocol & UIViewController

protocol ListRouterProtocol {
    var entry: EntryPoint? { get }
    
    static func start() -> ListRouterProtocol
    func present(view: UIViewController, originFrame: CGRect)
}

class ListRouter: NSObject, ListRouterProtocol {

    var entry: EntryPoint?
    
    private let transition = TransitionAnimator()
    private var originFrame: CGRect?
    
    static func start() -> ListRouterProtocol {
        let listRouter = ListRouter()
        
        var view: ListViewProtocol = ListViewController()
        var interactor: ListInteractorProtocol = ListInteractor()
        var presenter: ListPresenterProtocol = ListPresenter()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = listRouter
        
        listRouter.entry = view as? EntryPoint
                
        return listRouter
    }
    
    func present(view: UIViewController, originFrame: CGRect) {
        self.originFrame = originFrame
        view.transitioningDelegate = self
        view.modalPresentationStyle = .overFullScreen
        entry?.present(view, animated: true)
    }
}

extension ListRouter: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let originFrame = originFrame else { return nil }
        transition.originFrame = originFrame
        transition.presenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}


