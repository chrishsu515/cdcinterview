//
//  BalanceService.swift
//  cdcInterview
//
//  Created by Hsu Chris on 2025/1/4.
//

import Foundation

class BalanceService {
    func fetchBalanceList(currencyType: CurrencyType, balanceType: BalanceType, isRefresh: Bool, completion: @escaping (Double, Error?)-> Void) {
        var curUrl: URL?
        let networkService = NetworkService()

        switch currencyType {
        case .USD:
            switch balanceType {
            case .savings:
                curUrl = isRefresh ? APIEndpoint.usdSavingsRefreshed.url : APIEndpoint.usdSavingsFirst.url
            case .fixedDeposit:
                curUrl = isRefresh ? APIEndpoint.usdFixedDepositsRefreshed.url : APIEndpoint.usdFixedDepositsFirst.url
            case .digital:
                curUrl = isRefresh ? APIEndpoint.usdDigitalRefreshed.url : APIEndpoint.usdDigitalFirst.url
            }

        case .KHR:
            switch balanceType {
            case .savings:
                curUrl = isRefresh ? APIEndpoint.khrSavingsRefreshed.url : APIEndpoint.khrSavingsFirst.url
            case .fixedDeposit:
                curUrl = isRefresh ? APIEndpoint.khrFixedDepositsRefreshed.url : APIEndpoint.khrFixedDepositsFirst.url
            case .digital:
                curUrl = isRefresh ? APIEndpoint.khrDigitalRefreshed.url : APIEndpoint.khrDigitalFirst.url
            }
        }

        if let url = curUrl {
            networkService.fetchData(from: url, of: BalanceResponseModel.self) { result in
                switch result {
                case .success(let res):
                    var balanceList: [BalanceAccountModel]?
                    switch balanceType {
                    case .savings:
                        balanceList = res.result.savingsList
                    case .fixedDeposit:
                        balanceList = res.result.fixedDepositList
                    case .digital:
                        balanceList = res.result.digitalList
                    }
                    let totalBalance = balanceList?.reduce(0, { $0 + $1.balance }) ?? 0
                    print("取得餘額:\(totalBalance)")
                    completion(totalBalance, nil)
                case .failure(let error):
                    print("取得餘額失敗: \(error.localizedDescription)")
                    completion(0 , error)
                }
            }
        }
    }
}
