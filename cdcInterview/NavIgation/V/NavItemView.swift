import UIKit

class NavItemView: UIImageView {
    var onTap: (() -> Void)?
    var viewModel: NavItemViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
        contentMode = .scaleAspectFill
        isUserInteractionEnabled = true // 啟用使用者互動

        // 添加點擊手勢辨識器 (Tap Gesture Recognizer)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }

    private func setImage(named: String) {
        image = UIImage(named: named)
    }

    @objc private func handleTap() {
        // 點擊事件發生時，執行閉包
        onTap?()
    }

}

extension NavItemView: NavItemViewModelProtocol {
    func updateUI() {
        setImage(named: ImageAsset.iconBellActive.rawValue)
    }
    

}
