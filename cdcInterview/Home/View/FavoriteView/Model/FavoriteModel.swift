//
//  FavoriteModel.swift
//  cdcInterview
//
//  Created by Hsu Chris on 2025/1/5.
//

import Foundation

// MARK: - TransType Enum
enum TransType: String, Codable {
    case cubc = "CUBC"
    case mobile = "Mobile"
    case pmf = "PMF"
    case creditCard = "CreditCard"
    case unknown // 處理未知類型

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = TransType(rawValue: rawValue) ?? .unknown
    }
}

// MARK: - Root Structure
struct FavoriteResponseModel: Codable {
    let msgCode: String
    let msgContent: String
    let result: FavoriteResultModel
}

// MARK: - Result Structure
struct FavoriteResultModel: Codable {
    let favoriteList: [FavoriteModel]
}

// MARK: - Favorite Structure
struct FavoriteModel: Codable {
    let nickname: String
    let transType: TransType
}
