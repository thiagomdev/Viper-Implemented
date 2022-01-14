//
//  Interactor.swift
//  VIPER
//
//  Created by Thiago Monteiro on 03/01/22.
//

import Foundation

protocol Interactor {
    var presenter: Presenter? { get set }
    func getUsers()
}

class UserInteractor: Interactor {
    
    var presenter: Presenter?
    
    func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                self.presenter?.interactorDidFecthUsers(with: .failure(FetchError.failed))
                return
            }
            do {
                let entities = try JSONDecoder().decode([User].self, from: data)
                self.presenter?.interactorDidFecthUsers(with: .success(entities ))
            } catch {
                self.presenter?.interactorDidFecthUsers(with: .failure(FetchError.failed))
            }
        }
        task.resume()
    }
}
