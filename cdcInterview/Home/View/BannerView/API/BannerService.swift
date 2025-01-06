//
//  BannerService.swift
//  cdcInterview
//
//  Created by Hsu Chris on 2025/1/5.
//

class BannerService {
    func fetchBannerList(completion: @escaping ([BannerModel], Error?)-> Void) {
        let networkService = NetworkService()
        if let url = APIEndpoint.bannerList.url {
            networkService.fetchData(from: url, of: BannerResponseModel.self) { result in
                switch result {
                case .success(let res):
                    print("成功取得廣告列表:")
                    completion(res.result.bannerList, nil)
                case .failure(let error):
                    print("取得廣告列表失敗: \(error.localizedDescription)")
                    completion([] , error)
                }
            }
        }
    }
}
