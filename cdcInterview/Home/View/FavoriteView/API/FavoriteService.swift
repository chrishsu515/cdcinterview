//
//  FavoriteService.swift
//  cdcInterview
//
//  Created by Hsu Chris on 2025/1/5.
//

class FavoriteService {
    func fetchFavoriteList(completion: @escaping ([FavoriteModel], Error?)-> Void) {
        let networkService = NetworkService()
        if let url = APIEndpoint.favoriteList.url {
            networkService.fetchData(from: url, of: FavoriteResponseModel.self) { result in
                switch result {
                case .success(let res):
                    print("成功取得最愛列表:")
                    completion(res.result.favoriteList, nil)
                case .failure(let error):
                    print("取得最愛列表失敗: \(error.localizedDescription)")
                    completion([] , error)
                }
            }
        }
    }

}
