//
//  BalanceViewModel.swift
//  cdcInterview
//
//  Created by Hsu Chris on 2025/1/4.
//
import Foundation


protocol BalanceViewProtocol: AnyObject {
    func updateBalance(usdBalance: Double, khrBalance: Double)
}

class BalanceViewModel {
    let apiSevice = BalanceService()
    weak var delegate: BalanceViewProtocol?

    func fetchBalance(currencyType: CurrencyType, isRefresh: Bool, balanceType: BalanceType, complete: @escaping (Double?) -> Void) {
        apiSevice.fetchBalanceList(currencyType: currencyType, balanceType: balanceType, isRefresh: isRefresh) { (totalBalance, err) in
            if let err {
                complete(nil)
            }
            complete(totalBalance)
        }
    }

    func fetchBalanceAPIs(currencyType: CurrencyType, isRefresh: Bool, complete: @escaping (Double) -> Void) {
        let dispatchGroup = DispatchGroup() // 創建 DispatchGroup

        var totalBalance_saving = Double(0)
        var totalBalance_fixedDeposit = Double(0)
        var totalBalance_digital = Double(0)


        // API 1 請求

            for balanceType in BalanceType.allCases {
                dispatchGroup.enter()
                fetchBalance(currencyType: currencyType, isRefresh: isRefresh, balanceType: balanceType) { totalBalance in
                    if balanceType == .fixedDeposit {
                        totalBalance_fixedDeposit += totalBalance ?? 0
                    } else if balanceType == .savings {
                        totalBalance_saving += totalBalance ?? 0
                    } else if balanceType == .digital {
                        totalBalance_digital += totalBalance ?? 0
                    }
                    dispatchGroup.leave()
                }
        }


        // 等待所有請求完成
        dispatchGroup.notify(queue: .main) {
            // 當所有請求完成後執行的操作
            print("所有 API 請求已完成")
            print("totalBalance_saving = \(totalBalance_saving)")
            print("totalBalance_fixedDeposit = \(totalBalance_fixedDeposit)")
            print("totalBalance_digital = \(totalBalance_digital)")
            let totalBalance = totalBalance_saving + totalBalance_fixedDeposit + totalBalance_digital
            complete(totalBalance)
        }
    }

    func updateBalance(isRefresh: Bool) {

        let dispatchGroup = DispatchGroup()
        var khrBalance: Double = 0
        var usdBalance: Double = 0

        for currencyType in CurrencyType.allCases {
            dispatchGroup.enter()
            fetchBalanceAPIs(currencyType: currencyType ,isRefresh: isRefresh) { balance in
                if currencyType == .KHR {
                    print("KHR balance: \(balance)")
                    khrBalance = balance
                } else if currencyType == .USD {
                    print("USD balance: \(balance)")
                    usdBalance = balance
                }
                dispatchGroup.leave()
            }
        }


        // 等待所有請求完成
        dispatchGroup.notify(queue: .main) {[weak self] in
            self?.delegate?.updateBalance(usdBalance: usdBalance, khrBalance: khrBalance)

        }
    }
}
