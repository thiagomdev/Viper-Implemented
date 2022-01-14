//
//  Router.swift
//  VIPER
//
//  Created by Thiago Monteiro on 03/01/22.
//

import UIKit

typealias EntryPoint =  UIViewController & View

protocol Router {
    var entry: EntryPoint? { get }
    static func start() -> Router
}

class UserRouter: Router {
    
    var entry: EntryPoint?
    
    static func start() -> Router {
        let router = UserRouter()
        // Assign VIP
        var view: View = UserViewController()
        var presenter: Presenter = UserPresenter()
        var interactor: Interactor = UserInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        return router
    }
}
