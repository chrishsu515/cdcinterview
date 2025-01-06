//
//  BannerView.swift
//  cdcInterview
//
//  Created by Hsu Chris on 2025/1/5.
//

import UIKit


class BannerView: UIView {
    var viewModel: BannerViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    // MARK: - Properties
    private let scrollView = UIScrollView()
    private let pageControl = UIPageControl()
    private var banners: [BannerModel] = [] // 存放 Banner 圖片
    private var timer: Timer?

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
        // 設定 ScrollView
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        addSubview(scrollView)

        // 設定 PageControl
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
        addSubview(pageControl)

        // 設定 Layout
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 96),

            pageControl.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }


    private func setupBanners() {
        let networkService = NetworkService()

        // 移除所有子視圖
        scrollView.subviews.forEach { $0.removeFromSuperview() }
        
        // 添加圖片到 ScrollView
        for (index, banner) in banners.enumerated() {
            if let imageUrl = URL(string: banner.linkUrl) {
                let imageView = UIImageView()
                networkService.loadImage(from: imageUrl, into: imageView)
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
                scrollView.addSubview(imageView)

                imageView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                    imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
                    imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: CGFloat(index) * frame.width),
                    imageView.topAnchor.constraint(equalTo: scrollView.topAnchor)
                ])
            }
        }

        // 設定 ScrollView 的內容尺寸
        scrollView.contentSize = CGSize(width: frame.width * CGFloat(banners.count), height: frame.height)
    }

    // MARK: - Auto Scroll
    private func startAutoScroll() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }
            let nextPage = (self.pageControl.currentPage + 1) % self.banners.count
            let offset = CGPoint(x: CGFloat(nextPage) * self.frame.width, y: 0)
            self.scrollView.setContentOffset(offset, animated: true)
        })
    }

    deinit {
        timer?.invalidate()
    }
}

// MARK: - UIScrollViewDelegate
extension BannerView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / frame.width + 0.5)
        pageControl.currentPage = page
    }
}

extension BannerView: BannerViewModelProtocol {
    func updateUI(data: [BannerModel]) {
        self.banners = data
        DispatchQueue.main.async {[weak self] in
            self?.setupBanners()
            self?.pageControl.numberOfPages = data.count
            self?.startAutoScroll()
        }
    }
    

}
