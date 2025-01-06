//
//  BalanceModel.swift
//  cdcInterview
//
//  Created by Hsu Chris on 2025/1/4.
//

enum BalanceType:String, CaseIterable {
    case savings
    case fixedDeposit
    case digital
}

enum CurrencyType:String, CaseIterable {
    case USD
    case KHR
}


// 頂層模型
struct BalanceResponseModel: Codable {
    let msgCode: String
    let msgContent: String
    let result: BalanceResultModel
}

// result 中包含三種不同的列表，根據 JSON 的結構，它們可以被封裝在一個結構內
struct BalanceResultModel: Codable {
    let savingsList: [BalanceAccountModel]?
    let fixedDepositList: [BalanceAccountModel]?
    let digitalList: [BalanceAccountModel]?
}

// 存款帳戶模型
struct BalanceAccountModel: Codable {
    let account: String
    let curr: String
    let balance: Double
}
