//
//  FavoriteViewModel.swift
//  cdcInterview
//
//  Created by Hsu Chris on 2025/1/5.
//


protocol FavoriteViewModelProtocol: AnyObject {
    func updateUI(data: [FavoriteModel]?)
}

class FavoriteViewModel {
    let apiService = FavoriteService()
    weak var delegate: FavoriteViewModelProtocol?

    private func fetchFavorites(complete: @escaping (([FavoriteModel]?)->Void)){

        apiService.fetchFavoriteList { favorites, error in

            if let error {
                complete(nil)
            }
            print("成功取得最愛清單:")
            complete(favorites)

        }
    }

    func updateUI(){
        fetchFavorites { favorites in
            self.delegate?.updateUI(data: favorites)
        }
    }

}
