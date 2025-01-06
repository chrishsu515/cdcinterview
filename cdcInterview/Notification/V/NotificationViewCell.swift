//
//  NotificationCell.swift
//  cdcInterview
//
//  Created by Hsu Chris on 2025/1/4.
//

import UIKit

class NotificationViewCell: UITableViewCell {
    private let statusDot: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .orange
        view.layer.cornerRadius = 5
        view.isHidden = true
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()

    private let dateTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .gray
        label.numberOfLines = 2 // 支援多行顯示
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(statusDot)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateTimeLabel)
        contentView.addSubview(messageLabel)

        NSLayoutConstraint.activate([
            // 圓點
            statusDot.widthAnchor.constraint(equalToConstant: 10),
            statusDot.heightAnchor.constraint(equalToConstant: 10),
            statusDot.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            statusDot.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),

            // 標題
            titleLabel.leadingAnchor.constraint(equalTo: statusDot.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),

            // 時間
            dateTimeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateTimeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            dateTimeLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            // 內容
            messageLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            messageLabel.topAnchor.constraint(equalTo: dateTimeLabel.bottomAnchor, constant: 5),
            messageLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            messageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with message: NotificationModel) {
        // 創建兩個日期格式化器
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy/MM/dd HH:mm:ss"  // 第一種格式: "2022/09/01 15:07:30"

        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "HH:mm:ss yyyy/MM/dd"  // 第二種格式: "14:00:30 2022/08/23"

        var formattedDate: String?

        // 嘗試解析第一種格式
        if let date = dateFormatter1.date(from: message.updateDateTime) {
            dateFormatter1.dateFormat = "dd/MM/yyyy HH:mm:ss"  // 你要顯示的格式
            formattedDate = dateFormatter1.string(from: date)
        }
        // 如果第一種格式不成功，嘗試第二種格式
        else if let date = dateFormatter2.date(from: message.updateDateTime) {
            dateFormatter2.dateFormat = "dd/MM/yyyy HH:mm:ss"  // 你要顯示的格式
            formattedDate = dateFormatter2.string(from: date)
        }

        // 顯示格式化後的日期
        if let formattedDate = formattedDate {
            dateTimeLabel.text = formattedDate
        } else {
            // 若無法解析，顯示原始日期
            dateTimeLabel.text = message.updateDateTime
        }

        titleLabel.text = message.title
//        dateTimeLabel.text = message.updateDateTime
        messageLabel.text = message.message
        statusDot.isHidden = message.status // 根據 `status` 顯示或隱藏橘色圓點
    }
}
