//
//  MainViewModel.swift
//  NewsApiMvvmTutorial
//
//  Created by dwKang on 2022/03/24.
//

import Foundation
import RxSwift

struct MainViewModel {
    
    private let articleService: ArticleServiceProtocol
    let title = "Apple News"
    
    init(articleService: ArticleServiceProtocol) {
        self.articleService = articleService
    }
    
    func getArticles() -> Observable<[ArticleViewModel]> {
        articleService.getArticles().map { $0.map { ArticleViewModel(article: $0) } }
    }
}
