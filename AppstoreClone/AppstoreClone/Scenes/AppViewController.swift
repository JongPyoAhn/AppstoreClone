//
//  AppViewController.swift
//  AppstoreClone
//
//  Created by 안종표 on 2023/04/13.
//

import SnapKit

import UIKit

final class AppViewController: UIViewController{
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 0.0
        
        let featureSectionView = FeatureSectionView(frame: .zero)
        let rankingFeatureSectionView = RankingFeatureSectionView(frame: .zero)
        let exchangeCodeButtonView = ExchangeCodeButtonView()
        
        let spacingView = UIView()
        spacingView.snp.makeConstraints {
            $0.height.equalTo(100)
        }
        
        [
            featureSectionView,
            rankingFeatureSectionView,
            exchangeCodeButtonView,
            spacingView
        ].forEach{
            stackView.addArrangedSubview($0)
        }
        
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationController()
        configureUI()
    }
}

private extension AppViewController{
    func configureNavigationController(){
        navigationItem.title = "앱"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureUI(){
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints{
            $0.edges.equalTo(scrollView)
            $0.width.equalToSuperview()
        }
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
