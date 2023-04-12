//
//  TodayCollectionViewCell.swift
//  AppstoreClone
//
//  Created by 안종표 on 2023/04/12.
//

import SnapKit

import UIKit

final class TodayCollectionViewCell: UICollectionViewCell{
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24.0, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12.0
        imageView.backgroundColor = .gray
        
        return imageView
    }()
    
    func setup() {
        configureUI()
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 10
        
        self.subTitleLabel.text = "서브타이틀"
        self.descriptionLabel.text = "설명설명"
        self.titleLabel.text = "앱의 이름"
    }
}
private extension TodayCollectionViewCell{
    func configureUI(){
        [imageView, titleLabel, subTitleLabel, descriptionLabel].forEach{ addSubview($0)}
        
        self.subTitleLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(24)
            $0.trailing.equalToSuperview().inset(24)
            $0.top.equalToSuperview().inset(24)
        }
        
        self.titleLabel.snp.makeConstraints{
            $0.leading.equalTo(subTitleLabel)
            $0.trailing.equalTo(subTitleLabel)
            $0.top.equalTo(self.subTitleLabel.snp.bottom).offset(4)
        }
        
        self.descriptionLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(24)
            $0.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().offset(-24)
        }
        self.imageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
    }
}
