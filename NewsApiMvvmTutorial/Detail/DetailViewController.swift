//
//  DetailViewController.swift
//  NewsApiMvvmTutorial
//
//  Created by dwKang on 2022/03/26.
//

import UIKit
import SnapKit
import Kingfisher

class DetailViewController: UIViewController {
    
    let articleViewModel: ArticleViewModel
    
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.font = .boldSystemFont(ofSize: 24)
        lb.numberOfLines = 0
        return lb
    }()
    
    let articleImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .secondarySystemBackground
        return iv
    }()
    
    let descriptionLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        return lb
    }()

    
    init(articleViewModel: ArticleViewModel) {
        self.articleViewModel = articleViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindData()
    }
    
    func bindData() {
        if let urlString = articleViewModel.urlToImage {
            articleImageView.kf.setImage(with: URL(string: urlString))
        }
        
        titleLabel.text = articleViewModel.title
        descriptionLabel.text = articleViewModel.description
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }
        
        view.addSubview(articleImageView)
        articleImageView.snp.makeConstraints { make in
            make.size.equalTo(UIScreen.main.bounds.width - 40)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(articleImageView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(titleLabel)
        }
    }
}
