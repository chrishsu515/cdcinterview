//
//  NotificationService.swift
//  cdcInterview
//
//  Created by Hsu Chris on 2025/1/3.
//

class NotificationService {
    func fetchNotificationList(completion: @escaping ([NotificationModel], Error?)-> Void) {
        let networkService = NetworkService()
        if let url = APIEndpoint.notificationList.url {
            networkService.fetchData(from: url, of: NotificationResponseModel.self) { result in
                switch result {
                case .success(let res):
                    print("通知列表:")
                    completion(res.result.messages, nil)
                case .failure(let error):
                    print("取得通知失敗: \(error.localizedDescription)")
                    completion([] , error)
                }
            }
        }
    }
}

