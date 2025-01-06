//
//  CdcRequest.swift
//  cdcInterview
//
//  Created by Hsu Chris on 2025/1/3.
//

import Foundation
import UIKit

class NetworkService {

    /// 通用的資料請求函式
    /// - Parameters:
    ///   - url: 資料來源的 URL
    ///   - type: 要解析的模型類型 (必須符合 `Codable`)
    ///   - completion: 完成後的回呼，回傳成功的資料或錯誤
    func fetchData<T: Codable>(from url: URL, of type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // 檢查錯誤
            if let error = error {
                completion(.failure(error))
                return
            }

            // 確保有回傳資料
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: -1, userInfo: nil)))
                return
            }

            // 嘗試解析 JSON
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }

        // 啟動任務
        task.resume()
    }

    // MARK: - Load Image
    func loadImage(from url: URL, into imageView: UIImageView) {
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("圖片加載失敗: \(error)")
                return
            }

            guard let data = data, let image = UIImage(data: data) else { return }

            DispatchQueue.main.async {
                imageView.image = image
            }
        }
        task.resume()
    }
}
