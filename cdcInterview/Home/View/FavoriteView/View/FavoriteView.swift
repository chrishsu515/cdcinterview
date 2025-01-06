//
//  FavoriteView.swift
//  cdcInterview
//
//  Created by Hsu Chris on 2025/1/5.
//

import UIKit

class FavoriteView: UIView {
    var viewModel: FavoriteViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }

    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "My Favorite"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .gray
        return label
    }()

    private let moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("More >", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()

    private let scrollView = UIScrollView()
    private let stackView = UIStackView()

    private let placeholderView: UIView = {
        let view = UIView()
        view.isHidden = true // 預設隱藏
        view.translatesAutoresizingMaskIntoConstraints = false

        // 圖標
        let icon = UIImageView()
        icon.image = ImageAsset.placeholderIcon.image
//        icon.tintColor = .gray
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(icon)

        // 說明文字
        let label = UILabel()
        label.text = "You can add a favorite through the transfer or payment function."
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        // Layout Constraints
        NSLayoutConstraint.activate([
            icon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            icon.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: 56),
            icon.heightAnchor.constraint(equalToConstant: 56),

            label.centerYAnchor.constraint(equalTo: icon.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            label.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        return view
    }()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Setup View
    private func setupView() {
        // 添加標題與按鈕
        addSubview(titleLabel)
        addSubview(moreButton)
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(placeholderView)
        addSubview(scrollView)
        // 顯示佔位圖，隱藏滾動視圖
        placeholderView.isHidden = false
        scrollView.isHidden = true

        // 配置 StackView
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 16
        scrollView.addSubview(stackView)

        // 設定 Layout
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // 標題
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            titleLabel.heightAnchor.constraint(equalToConstant: 48),
            // More 按鈕
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            moreButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),

            // 佔位圖
            placeholderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            placeholderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            placeholderView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            placeholderView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            placeholderView.heightAnchor.constraint(equalToConstant: 80),

            // ScrollView
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            scrollView.heightAnchor.constraint(equalToConstant: 80),
            // StackView
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])

    }

    // MARK: - Create Item View
    private func createItemView(nickname: String, transType: TransType) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 80).isActive = true

        // 圖標
        let imageView = UIImageView()
        imageView.image = imageForTransType(transType: transType)
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imageView)

        // 昵稱
        let label = UILabel()
        label.text = nickname
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(label)

        // 設定 Layout
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            imageView.widthAnchor.constraint(equalToConstant: 56),
            imageView.heightAnchor.constraint(equalToConstant: 56),

            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0),
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 4),
            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0)
        ])

        return containerView
    }

    // MARK: - Image for TransType
    private func imageForTransType(transType: TransType) -> UIImage? {
        switch transType {
        case .cubc: return ImageAsset.cubc.image
        case .mobile: return ImageAsset.mobile.image
        case .pmf: return ImageAsset.pmf.image
        case .creditCard: return ImageAsset.creditCard.image
        case .unknown: return UIImage()
        }
    }

}

extension FavoriteView: FavoriteViewModelProtocol {
    func updateUI(data: [FavoriteModel]?) {
        guard let data else { return }

        // 清空 StackView
        DispatchQueue.main.async {[weak self] in
            // 顯示滾動視圖，隱藏佔位圖
            self?.placeholderView.isHidden = true
            self?.scrollView.isHidden = false
            self?.stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            // 動態添加內容
            for favorite in data {
                guard let itemView = self?.createItemView(nickname: favorite.nickname, transType: favorite.transType) else { continue }
                self?.stackView.addArrangedSubview(itemView)
            }
        }

    }
    

}
