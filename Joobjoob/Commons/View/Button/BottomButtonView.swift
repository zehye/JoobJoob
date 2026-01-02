//
//  BottomButtonView.swift
//  Joobjoob
//
//  Created by zehye on 12/29/25.
//

import UIKit

/// 하단 버튼 커스텀 뷰
class BottomButtonView: UIView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var button: UIButton!
    
    private var _isEnabled: Bool? {
        didSet {
            self.button.titleLabel?.tintColor = self.theme.tintColor
            self.button.backgroundColor = self.isEnable ? self.theme.backgroundColor : self.theme.unenabledBackgroundColor
        }
    }

    var theme: Theme = .tint
    
    var isEnable: Bool {
        get {
            return self._isEnabled ?? false
        }
        set {
            self._isEnabled = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
    }

    func initUI() {
        guard let view = Bundle.main.loadNibNamed("BottomButtonView", owner: self, options: nil)?.first as? UIView else { return }
        view.frame = self.bounds
        self.addSubview(view)
        
        self.button.layer.cornerRadius = 4
        self.button.titleLabel?.font = UIFont.spoqaHanSansNeo(type: .medium, size: CGFloat(14))
        
        self.containerView.backgroundColor = ColorTheme(background: .background)
    }

    // 버튼 타이틀과 상태 업데이트 시키는 메소드
    func update(title: String, isEnable: Bool = true) {
        self.button.setTitle(title, for: .normal)
        self.isEnable = isEnable
    }
}

extension BottomButtonView {
    enum Theme {
        case tint

        var backgroundColor: UIColor {
            switch self {
            case .tint: return ColorTheme(background: .background)
            }
        }

        var unenabledBackgroundColor: UIColor {
            switch self {
            case .tint: return ColorTheme(background: .grey)
            }
        }
        
        var tintColor: UIColor {
            switch self {
            case .tint: return ColorTheme(foreground: .white)
            }
        }

    }
}
