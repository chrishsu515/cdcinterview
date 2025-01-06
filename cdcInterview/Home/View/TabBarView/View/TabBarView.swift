//
//  TabView.swift
//  cdcInterview
//
//  Created by Hsu Chris on 2025/1/5.
//

import UIKit

class TabBarView: UIView {

    // MARK: - Properties
    private let containerView = UIView()
    private let stackView = UIStackView()
    private var items: [TabBarItem] = []
    private var itemViews: [TabBarItemView] = []
    var onItemSelected: ((Int) -> Void)? // 點擊事件回調

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }

    // MARK: - Setup View
    private func setupView() {
        // 配置陰影效果
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 8
        // 配置容器視圖
        containerView.layer.cornerRadius = 28
        containerView.layer.masksToBounds = true
        containerView.layer.borderWidth = 0.1
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(containerView)

        // 配置 StackView
        stackView.axis = .horizontal

        stackView.distribution = .fillEqually
        stackView.spacing = 0
        containerView.addSubview(stackView)

        // 設定 StackView 的 Layout
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([

            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])

    }

    // MARK: - Configure Items
    func configure() {

        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() } // 移除舊的 View
        self.items = TabBarItems
        itemViews = []

        for (index, item) in TabBarItems.enumerated() {
            let itemView = TabBarItemView(item: item)
            itemView.tag = index
            itemView.isUserInteractionEnabled = true

            // 添加點擊手勢
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(itemTapped(_:)))
            itemView.addGestureRecognizer(tapGesture)

            stackView.addArrangedSubview(itemView)
            itemViews.append(itemView)
        }

        // 預設選中第一個
        selectItem(at: 0)
    }


    // MARK: - Item Tapped
    @objc private func itemTapped(_ gesture: UITapGestureRecognizer) {
        guard let index = gesture.view?.tag else { return }
        selectItem(at: index)
        onItemSelected?(index)
    }

    // MARK: - Select Item
    private func selectItem(at index: Int) {
        for (itemIndex, itemView) in itemViews.enumerated() {
            let isSelected = itemIndex == index
            let imageView = itemView.subviews.compactMap { $0 as? UIImageView }.first
            let label = itemView.subviews.compactMap { $0 as? UILabel }.first

            imageView?.tintColor = isSelected ? .systemOrange : .gray
            label?.textColor = isSelected ? .systemOrange : .gray
        }
    }
}
