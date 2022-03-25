//
//  ArticleViewModel.swift
//  NewsApiMvvmTutorial
//
//  Created by dwKang on 2022/03/25.
//

import Foundation

struct ArticleViewModel {
    
    private let article: Article
    
    var title: String? { article.title }
    var description: String? { article.description }
    var urlToImage: String? { article.urlToImage }
    
    init(article: Article) {
        self.article = article
    }
}
