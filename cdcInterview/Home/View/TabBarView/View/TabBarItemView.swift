//
//  TabBarItemView.swift
//  cdcInterview
//
//  Created by Hsu Chris on 2025/1/5.
//

import UIKit

class TabBarItemView: UIView {

    // MARK: - Properties
    private let imageView = UIImageView()
    private let label = UILabel()

    var isSelected: Bool = false {
        didSet {}
    }

    // MARK: - Initializer
    init(item: TabBarItem) {
        super.init(frame: .zero)
        setupView(item: item)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Setup View
    private func setupView(item: TabBarItem) {
        // 圖標
        imageView.image = UIImage(named: item.imageName)
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)

        // 標題
        label.text = item.title
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .gray
        label.textAlignment = .center
        addSubview(label)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let imageSize: CGFloat = 24
        let spacing: CGFloat = 4

        // 計算圖標位置
        imageView.frame = CGRect(
            x: (bounds.width - imageSize) / 2,
            y: 5,
            width: imageSize,
            height: imageSize
        )

        // 計算標題位置
        label.frame = CGRect(
            x: 0,
            y: imageView.frame.maxY + spacing,
            width: bounds.width,
            height: 16
        )
    }


}
