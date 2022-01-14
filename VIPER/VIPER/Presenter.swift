//
//  Presenter.swift
//  VIPER
//
//  Created by Thiago Monteiro on 03/01/22.
//

import Foundation

enum FetchError: Error {
    case failed
}
protocol Presenter {
    
    var router: Router? { get set }
    var interactor: Interactor? { get set }
    var view: View? { get set }
    
    func interactorDidFecthUsers(with result: Result<[User], Error>)
}

class UserPresenter: Presenter {
 
    var router: Router?
    var view: View?
    
    var interactor: Interactor? {
        didSet {
            self.interactor?.getUsers()
        }
    }

    func interactorDidFecthUsers(with result: Result<[User], Error>) {
        switch result {
        case .success(let users):
            self.view?.update(with: users)
        case .failure:
            self.view?.update(with: "Something went wrong!")
        }
    }
}
