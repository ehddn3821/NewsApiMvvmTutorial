//
//  ArticleTableViewCell.swift
//  NewsApiMvvmTutorial
//
//  Created by dwKang on 2022/03/25.
//

import UIKit
import RxSwift
import SnapKit
import Kingfisher

class ArticleTableViewCell: UITableViewCell {

    let disposeBag = DisposeBag()
    var viewModel = PublishSubject<ArticleViewModel>()
    
    lazy var articleImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .secondarySystemBackground
        return iv
    }()
    
    lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.font = .boldSystemFont(ofSize: 20)
        return lb
    }()
    
    lazy var descriptionLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        return lb
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        subscribeArticle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func subscribeArticle() {
        viewModel.subscribe(onNext: { [weak self] article in
            guard let self = self else { return }
            
            self.articleImageView.image = nil
            
            if let urlString = article.urlToImage {
                self.articleImageView.kf.setImage(with: URL(string: urlString))
            }
            
            self.titleLabel.text = article.title
            self.descriptionLabel.text = article.description
            
        }).disposed(by: disposeBag)
    }
    
    func configureUI() {
        addSubview(articleImageView)
        articleImageView.snp.makeConstraints { make in
            make.size.equalTo(60)
            make.centerY.equalToSuperview()
            make.leading.equalTo(20)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.leading.equalTo(articleImageView.snp.trailing).offset(20)
            make.trailing.equalTo(-20)
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.equalTo(-20)
        }
    }
}
