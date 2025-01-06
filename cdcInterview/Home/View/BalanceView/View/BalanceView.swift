//
//  BalanceView.swift
//  cdcInterview
//
//  Created by Hsu Chris on 2025/1/4.
//
import UIKit



class BalanceView: UIView {

    var viewModel: BalanceViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }

    private var isBalanceHidden: Bool = true {
        didSet {
            updateBalanceVisibility()
        }
    }

    private var usdBalance = "0.00"
    private var khrBalance = "0.00"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "My Account Balance"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .gray
        return label
    }()

    private let eyeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "eyeOff"), for: .normal)
        button.tintColor = .orange
        return button
    }()

    private let usdCurrencyLabel: UILabel = {
        let label = UILabel()
        label.text = "USD"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        return label
    }()

    private let usdAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "********"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.backgroundColor = .clear
        label.layer.cornerRadius = 6
        label.layer.masksToBounds = true
        label.textAlignment = .left
        label.textColor = .darkGray
        return label
    }()

    private let khrCurrencyLabel: UILabel = {
        let label = UILabel()
        label.text = "KHR"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        return label
    }()

    private let khrAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "********"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.backgroundColor = .clear
        label.layer.cornerRadius = 6
        label.layer.masksToBounds = true
        label.textAlignment = .left
        label.textColor = .darkGray
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        applyGradientToKHRLabel()
        applyGradientToUSDLabel()
        eyeButton.addTarget(self, action: #selector(toggleVisibility), for: .touchUpInside)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // 確保Label 的漸層尺寸正確
        if let gradientLayer = khrAmountLabel.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = khrAmountLabel.bounds
        }
        if let gradientLayer = usdAmountLabel.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = usdAmountLabel.bounds
        }
    }

    private func setupViews() {
        addSubview(titleLabel)
        addSubview(eyeButton)
        addSubview(usdCurrencyLabel)
        addSubview(usdAmountLabel)
        addSubview(khrCurrencyLabel)
        addSubview(khrAmountLabel)
    }

    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        usdCurrencyLabel.translatesAutoresizingMaskIntoConstraints = false
        usdAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        khrCurrencyLabel.translatesAutoresizingMaskIntoConstraints = false
        khrAmountLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Title
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.heightAnchor.constraint(equalToConstant: 48),
            // Eye Button
            eyeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
//            eyeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            eyeButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            // USD Row
            usdCurrencyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            usdCurrencyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            usdCurrencyLabel.heightAnchor.constraint(equalToConstant: 24),
            usdAmountLabel.topAnchor.constraint(equalTo: usdCurrencyLabel.bottomAnchor, constant: 0),
            usdAmountLabel.leadingAnchor.constraint(equalTo: usdCurrencyLabel.leadingAnchor, constant: 0),
            usdAmountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            usdAmountLabel.heightAnchor.constraint(equalToConstant: 32),

            // KHR Row
            khrCurrencyLabel.topAnchor.constraint(equalTo: usdAmountLabel.bottomAnchor, constant: 4),
            khrCurrencyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            khrCurrencyLabel.heightAnchor.constraint(equalToConstant: 24),
            khrAmountLabel.topAnchor.constraint(equalTo: khrCurrencyLabel.bottomAnchor, constant: 0),
            khrAmountLabel.leadingAnchor.constraint(equalTo: khrCurrencyLabel.leadingAnchor, constant: 0),
            khrAmountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            khrAmountLabel.heightAnchor.constraint(equalToConstant: 32),

        ])
    }


    @objc private func toggleVisibility() {
        isBalanceHidden.toggle()
        let imageName = isBalanceHidden ? "eyeOff" : "eyeOn"
        eyeButton.setImage(UIImage(named: imageName), for: .normal)
        updateBalanceVisibility()
    }

    private func updateBalanceVisibility() {
        usdAmountLabel.text = isBalanceHidden ? "********" : usdBalance
        khrAmountLabel.text = isBalanceHidden ? "********" : khrBalance
    }

    private func applyGradientToKHRLabel() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.lightGray.cgColor, UIColor.white.cgColor] // 設定漸層顏色
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5) // 漸層起始點（水平左側）
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5) // 漸層結束點（水平右側）
        gradientLayer.frame = khrAmountLabel.bounds // 設定漸層框架為 Label 的邊界
        gradientLayer.cornerRadius = 6 // 確保漸層與 label 的圓角匹配

        // 因為使用 Auto Layout，所以需要延遲更新漸層的 frame
        khrAmountLabel.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func applyGradientToUSDLabel() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.lightGray.cgColor, UIColor.white.cgColor] // 設定漸層顏色
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5) // 漸層起始點（水平左側）
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5) // 漸層結束點（水平右側）
        gradientLayer.frame = usdAmountLabel.bounds // 設定漸層框架為 Label 的邊界
        gradientLayer.cornerRadius = 6 // 確保漸層與 label 的圓角匹配

        // 因為使用 Auto Layout，所以需要延遲更新漸層的 frame
        usdAmountLabel.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func removeGradientFromLabel() {
        if let sublayers = khrAmountLabel.layer.sublayers {
            for layer in sublayers {
                if layer is CAGradientLayer {
                    layer.removeFromSuperlayer() // 移除漸層
                }
            }
        }
        if let sublayers = usdAmountLabel.layer.sublayers {
            for layer in sublayers {
                if layer is CAGradientLayer {
                    layer.removeFromSuperlayer() // 移除漸層
                }
            }
        }
    }


}

extension BalanceView: BalanceViewProtocol {
    func updateBalance(usdBalance: Double, khrBalance: Double) {
        sleep(1)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2

        if let formattedUSDBalance = numberFormatter.string(from: NSNumber(value: usdBalance)) {
            self.usdBalance = formattedUSDBalance
        }

        if let formattedKHRBalance = numberFormatter.string(from: NSNumber(value: khrBalance)) {
            self.khrBalance = formattedKHRBalance
        }
        removeGradientFromLabel()
        updateBalanceVisibility()
    }
    

}
