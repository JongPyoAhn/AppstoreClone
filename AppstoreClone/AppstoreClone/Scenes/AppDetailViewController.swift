//
//  AppDetailViewController.swift
//  AppstoreClone
//
//  Created by 안종표 on 2023/04/14.
//

import SnapKit

import UIKit

final class AppDetailViewController: UIViewController{
    private let today: Today
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("받기", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemBlue
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        let action = UIAction {[weak self] _ in
            let activityItems: [Any] = [self!.today.title]
            let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
            self?.present(activityViewController, animated: true)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    init(today: Today) {
        self.today = today
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        view.backgroundColor = .systemBackground
    }
    
    func setUp(){
        configureUI()
        self.titleLabel.text = today.title
        self.descriptionLabel.text = today.subTitle
    }
    
    func configureUI(){
        [imageView, titleLabel, descriptionLabel, downloadButton, shareButton].forEach{
            self.view.addSubview($0)
        }
        
        self.imageView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(32)
            $0.leading.equalToSuperview().inset(16)
            $0.height.width.equalTo(100)
        }
        
        self.titleLabel.snp.makeConstraints{
            $0.top.equalTo(self.imageView.snp.top)
            $0.leading.equalTo(self.imageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
            
        }
        
        self.descriptionLabel.snp.makeConstraints{
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(self.titleLabel.snp.leading)
            $0.trailing.equalTo(self.titleLabel.snp.trailing)
        }
        
        self.downloadButton.snp.makeConstraints{
            $0.leading.equalTo(self.titleLabel.snp.leading)
            $0.bottom.equalTo(self.imageView.snp.bottom)
            $0.width.equalTo(60)
            $0.height.equalTo(25)
        }
        
        self.shareButton.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(self.downloadButton.snp.bottom)
            $0.width.height.equalTo(32)
        }
        
    }
        
}
