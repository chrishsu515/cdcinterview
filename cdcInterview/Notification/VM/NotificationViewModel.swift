//
//  NotificationViewModel.swift
//  cdcInterview
//
//  Created by Hsu Chris on 2025/1/3.
//

class NotificationViewModel {
    let apiService = NotificationService()

    func fetchNotifications(complete: @escaping (([NotificationModel]?)->Void)){

        apiService.fetchNotificationList { (notifications, error) in
            if let error {
                print("取得通知失敗: \(error.localizedDescription)")
                complete(nil)
            }
            print("成功取得通知清單:")
            complete(notifications)

        }
    }

    
}
