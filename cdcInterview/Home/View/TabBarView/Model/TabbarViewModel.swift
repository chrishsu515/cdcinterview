//
//  TabbarViewModel.swift
//  cdcInterview
//
//  Created by Hsu Chris on 2025/1/5.
//

struct TabBarItem {
    let title: String
    let imageName: String
}

let TabBarItems = [
    TabBarItem(title: "Home", imageName: ImageAsset.home.rawValue),
    TabBarItem(title: "Account", imageName: ImageAsset.account.rawValue),
    TabBarItem(title: "Location", imageName: ImageAsset.location.rawValue),
    TabBarItem(title: "Service", imageName: ImageAsset.service.rawValue)
]
