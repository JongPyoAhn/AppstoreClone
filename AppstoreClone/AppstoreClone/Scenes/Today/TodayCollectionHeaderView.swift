//
//  TodayCollectionHeaderView.swift
//  AppstoreClone
//
//  Created by 안종표 on 2023/04/12.
//

import SnapKit

import UIKit

final class TodayCollectionHeaderView: UICollectionReusableView {
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "4월 12일 수요일"
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "투데이"
        label.font = .systemFont(ofSize: 36.0, weight: .black)
        label.textColor = .label
        return label
    }()
    
    func configureUI(){
        [self.dateLabel, self.titleLabel].forEach{
            self.addSubview($0)
        }
        self.dateLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(32)
        }
        
        self.titleLabel.snp.makeConstraints{
            $0.left.equalTo(dateLabel)
            $0.top.equalTo(dateLabel.snp.bottom).offset(8)
        }
        
    }
}
