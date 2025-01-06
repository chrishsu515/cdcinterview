//
//  NotificationModel.swift
//  cdcInterview
//
//  Created by Hsu Chris on 2025/1/3.
//

import Foundation



// 單一訊息的模型
struct NotificationModel: Codable {
    let status: Bool
    let updateDateTime: String
    let title: String
    let message: String
}

// 包含多個訊息的結果模型
struct NotificationListModel: Codable {
    let messages: [NotificationModel]
}

// 整個 JSON 資料的根模型
struct NotificationResponseModel: Codable {
    let msgCode: String
    let msgContent: String
    let result: NotificationListModel
}
