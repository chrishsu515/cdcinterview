//
//  BannerModel.swift
//  cdcInterview
//
//  Created by Hsu Chris on 2025/1/5.
//

import Foundation

// MARK: - Root Structure
struct BannerResponseModel: Codable {
    let msgCode: String
    let msgContent: String
    let result: BannerResultModel
}

// MARK: - Result Structure
struct BannerResultModel: Codable {
    let bannerList: [BannerModel]
}

// MARK: - Banner Structure
struct BannerModel: Codable {
    let adSeqNo: Int
    let linkUrl: String
}
