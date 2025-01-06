//
//  imageAsset.swift
//  cdcInterview
//
//  Created by Hsu Chris on 2025/1/3.
//
import UIKit

enum ImageAsset: String {
    case avatar
    case iconBellActive
    case iconBellNormal
    case eyeOn
    case eyeOff
    case myQRCode
    case payment
    case qrPayScan
    case topUp
    case transfer
    case utility
    case creditCard
    case cubc
    case mobile
    case pmf
    case placeholderIcon
    case account
    case home
    case location
    case service
    
    var image: UIImage? {
        return UIImage(named: self.rawValue)
    }
}

// 使用方式：
//let avatarImage = ImageAsset.avatar.image
//
//// 或直接使用 rawValue：
//let logoImage = UIImage(named: ImageAsset.avatar.rawValue)
