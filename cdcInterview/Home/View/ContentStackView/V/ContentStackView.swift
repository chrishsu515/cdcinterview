//
//  ContentStackView.swift
//  cdcInterview
//
//  Created by Hsu Chris on 2025/1/3.
//

import UIKit

class ContentStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupStackView()
    }

    private func setupStackView() {
        axis = .vertical
        alignment = .fill
        distribution = .fill
        spacing = 8 // 可選：設定子視圖之間的間距
    }


    func addContentView(_ view: UIView, height: CGFloat? = nil) { // height 變為 Optional
        addArrangedSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true

        if let height = height { // 只有當 height 有值時才設定高度約束
            view.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

// 如何使用：
//let contentStackView = ContentStackView()
//contentStackView.translatesAutoresizingMaskIntoConstraints = false
//view.addSubview(contentStackView)
////約束contentStackView
//contentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//// contentStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//let view1 = UIView()
//view1.backgroundColor = .red
//let view2 = UIView()
//view2.backgroundColor = .blue
//let view3 = UIView()
//view3.backgroundColor = .green
//
//contentStackView.addContentView(view1, height: 100)
//contentStackView.addContentView(view2, height: 50)
//contentStackView.addContentView(view3, height: 150)
