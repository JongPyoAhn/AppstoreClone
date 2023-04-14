//
//  AppDetailViewController.swift
//  AppstoreClone
//
//  Created by 안종표 on 2023/04/14.
//

import SnapKit

import UIKit

final class AppDetailViewController: UIViewController{
    
    private var task: URLSessionDataTask!
    
    private var today: Today?
    private var feature: Feature?
    
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
            var title = ""
            if let today = self?.today{ title = today.title}
            if let feature = self?.feature {title = feature.appName}
            let activityItems: [Any] = [title]
            let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
            self?.present(activityViewController, animated: true)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(today: Today) {
        self.init()
        self.today = today
    }
    convenience init(feature: Feature){
        self.init()
        self.feature = feature
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
        if let today = self.today{
            self.titleLabel.text = today.title
            self.descriptionLabel.text = today.subTitle
            self.fetchImage(today.imageURL)
        }
        if let feature = self.feature{
            self.titleLabel.text = feature.appName
            self.descriptionLabel.text = feature.description
            self.fetchImage(feature.imageURL)
        }
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
    
    func fetchImage(_ url: String){
        guard let url = URL(string: url) else {return}
        let urlRequest = URLRequest(url: url)
        self.task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error{
                fatalError(error.localizedDescription)
            }
            
            guard let data = data, let image = UIImage(data: data) else {return}
            DispatchQueue.main.async {
                self.imageView.image = image
            }
            
        }
        self.task.resume()
    }
}
