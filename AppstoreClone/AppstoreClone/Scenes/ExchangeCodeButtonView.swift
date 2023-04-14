//
//  exchangeCodeButtonView.swift
//  AppstoreClone
//
//  Created by 안종표 on 2023/04/14.
//
import SnapKit

import UIKit

final class ExchangeCodeButtonView: UIView{
    private lazy var codeExchangeButton: UIButton = {
        let button = UIButton()
        button.setTitle("코드 교환", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.backgroundColor = .tertiarySystemGroupedBackground
        button.layer.cornerRadius = 7
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension ExchangeCodeButtonView {
    func configureUI(){
        self.addSubview(codeExchangeButton)
        self.codeExchangeButton.snp.makeConstraints{
            $0.top.bottom.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }
    }
}
