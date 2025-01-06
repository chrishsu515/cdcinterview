//
//  ViewController.swift
//  cdcInterview
//
//  Created by Hsu Chris on 2025/1/3.
//

import UIKit

class HomeViewController: UIViewController {
    let scrollView = UIScrollView()
    let contentStackView = ContentStackView()
    let refreshControl = UIRefreshControl()
    private let viewModel = HomeViewModel()
    let balanceView = BalanceView()
    let favoriteView = FavoriteView()
    let bannerView = BannerView()
    let tabBarView = TabBarView()
    let featuresView = FeaturesView()
    // 建立導覽列右側鈴鐺按鈕
    let notificationButton = NavItemView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupScrollView()
        setupContentStackView()
        addContentToStackView()
        setupRefreshControl() 
    }


    private func setupNavigationBar() {
        // 建立左側頭像按鈕
        let avatarView = NavItemView(frame: CGRect(x: 24, y: 0, width: 40, height: 40)) //移除x的偏移量，在navigationItem裡面會自動排版
        avatarView.image = ImageAsset.avatar.image


        let leftBarButtonItem = UIBarButtonItem(customView: avatarView)
        navigationItem.leftBarButtonItem = leftBarButtonItem

        // 建立左側頭像按鈕
//        let notificationButton = NavItemView(frame: CGRect(x: 0, y: 0, width: 24, height: 24)) //移除x的偏移量，在navigationItem裡面會自動排版
        notificationButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        notificationButton.image = ImageAsset.iconBellNormal.image
        notificationButton.viewModel = viewModel.navItem
        notificationButton.onTap = {[weak self] in
            self?.NotificationButtonTapped()
        }

        let rightBarButtonItem = UIBarButtonItem(customView: notificationButton)

        // 建立右側按鈕

        navigationItem.rightBarButtonItem = rightBarButtonItem

    }

    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }


    private func setupContentStackView() {
        scrollView.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            // 重要的約束：寬度要等於 scrollView 的寬度
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }

    private func addContentToStackView() {

        balanceView.viewModel = self.viewModel.balance
        balanceView.viewModel?.updateBalance(isRefresh: false)


        favoriteView.viewModel = viewModel.favorite

        bannerView.viewModel = viewModel.banner
        bannerView.viewModel?.updateUI()

        tabBarView.configure()
        
        contentStackView.addContentView(balanceView, height: 176)
        contentStackView.addContentView(featuresView, height: 192)
        contentStackView.addContentView(favoriteView, height: 128)

        contentStackView.addContentView(bannerView, height: 116)
        contentStackView.addContentView(tabBarView, height: 56)
    }

    private func setupRefreshControl() {
        // 設定 UIRefreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged) // 設定觸發事件和處理函式
        scrollView.refreshControl = refreshControl // 將 refreshControl 加入 scrollView
        refreshControl.attributedTitle = NSAttributedString(string: "下拉更新") // 可選：設定顯示的文字
    }

    @objc private func refreshData() {
        // 在這裡執行讀取資料的程式碼
        print("開始讀取資料...")

        // 模擬讀取資料的延遲
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            // 讀取資料完成後，停止 refreshControl 的動畫
            self?.refreshControl.endRefreshing()
            self?.balanceView.viewModel?.updateBalance(isRefresh: true)
            self?.favoriteView.viewModel?.updateUI()
            self?.notificationButton.updateUI()
            print("讀取資料完成！")
        }


    }

    @objc func NotificationButtonTapped() {
        // 右側按鈕點擊事件處理
        print("訊息按鈕被點擊了！")
        // 進行頁面跳轉
        let nextVC = NotificationViewController() // 替換成你的下一個 View Controller
        nextVC.viewModel = viewModel.notification
        navigationController?.pushViewController(nextVC, animated: true)
    }


}


