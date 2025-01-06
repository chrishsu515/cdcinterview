//
//  NavItemViewModel.swift
//  cdcInterview
//
//  Created by Hsu Chris on 2025/1/6.
//

protocol NavItemViewModelProtocol: AnyObject {
    func updateUI()
}
class NavItemViewModel {
    weak var delegate: NavItemViewModelProtocol?

    func updateUI() {
        delegate?.updateUI()
    }
}
