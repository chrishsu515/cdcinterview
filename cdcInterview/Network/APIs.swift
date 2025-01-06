//
//  APIs.swift
//  cdcInterview
//
//  Created by Hsu Chris on 2025/1/3.
//

import Foundation

// 定義 API 端點
enum APIEndpoint: String {
    case notificationList = "https://willywu0201.github.io/data/notificationList.json"
    // Balance first load
    case usdSavingsFirst = "https://willywu0201.github.io/data/usdSavings1.json"
    case usdFixedDepositsFirst = "https://willywu0201.github.io/data/usdFixed1.json"
    case usdDigitalFirst = "https://willywu0201.github.io/data/usdDigital1.json"
    case khrSavingsFirst = "https://willywu0201.github.io/data/khrSavings1.json"
    case khrFixedDepositsFirst = "https://willywu0201.github.io/data/khrFixed1.json"
    case khrDigitalFirst = "https://willywu0201.github.io/data/khrDigital1.json"

    // Balance after refresh
    case usdSavingsRefreshed = "https://willywu0201.github.io/data/usdSavings2.json"
    case usdFixedDepositsRefreshed = "https://willywu0201.github.io/data/usdFixed2.json"
    case usdDigitalRefreshed = "https://willywu0201.github.io/data/usdDigital2.json"
    case khrSavingsRefreshed = "https://willywu0201.github.io/data/khrSavings2.json"
    case khrFixedDepositsRefreshed = "https://willywu0201.github.io/data/khrFixed2.json"
    case khrDigitalRefreshed = "https://willywu0201.github.io/data/khrDigital2.json"

    // favorite
    case favoriteList = "https://willywu0201.github.io/data/favoriteList.json"

    // banner
    case bannerList = "https://willywu0201.github.io/data/banner.json"
    
    // 取得 URL
    var url: URL? {
        return URL(string: self.rawValue)
    }
}


