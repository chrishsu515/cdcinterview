//
//  BannerViewModel.swift
//  cdcInterview
//
//  Created by Hsu Chris on 2025/1/5.
//

import UIKit

protocol BannerViewModelProtocol: AnyObject {
    func updateUI(data: [BannerModel])
}

class BannerViewModel {
    let apiService = BannerService()
    weak var delegate: BannerViewModelProtocol?

    private func fetchBanners(complete: @escaping (([BannerModel]?)->Void)){

        apiService.fetchBannerList { banners, error in

            if let error {
                complete(nil)
            }
            print("成功取得最愛清單:")
            complete(banners)

        }
    }

    func updateUI(){
        let networkService = NetworkService()
        fetchBanners { bannersData in
            guard let bannersData else { return }
            self.delegate?.updateUI(data: bannersData)
        }
    }

}
