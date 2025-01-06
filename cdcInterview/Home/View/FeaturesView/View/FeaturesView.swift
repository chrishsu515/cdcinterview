//
//  FeaturesView.swift
//  cdcInterview
//
//  Created by Hsu Chris on 2025/1/5.
//
import UIKit

class FeaturesView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private var features: [(UIImage?, String)] = [
        (ImageAsset.transfer.image, "Transfer"),
        (ImageAsset.payment.image, "Payment"),
        (ImageAsset.utility.image, "Utility"),
        (ImageAsset.qrPayScan.image, "QR pay scan"),
        (ImageAsset.myQRCode.image, "My QR code"),
        (ImageAsset.topUp.image, "Top up")
    ]

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 16
        layout.itemSize = CGSize(width: 56, height: 80) // 每個項目的大小

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FeatureCell.self, forCellWithReuseIdentifier: FeatureCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return features.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeatureCell.identifier, for: indexPath) as! FeatureCell
        let feature = features[indexPath.item]
        cell.configure(assetImage: feature.0, title: feature.1)
        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing = (16 * 2) + (16 * 2) // 左右間距 + 行間距
        let availableWidth = collectionView.frame.width - Double(totalSpacing)
        let itemWidth = availableWidth / 3 // 每行三個項目
        return CGSize(width: itemWidth, height: 90)
    }
}
