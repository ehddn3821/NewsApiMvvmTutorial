//
//  MainViewModel.swift
//  NewsApiMvvmTutorial
//
//  Created by dwKang on 2022/03/24.
//

import Foundation
import RxSwift

struct MainViewModel {
    
    let disposeBag = DisposeBag()
    let articleService: ArticleServiceProtocol
    
    
    init(articleService: ArticleServiceProtocol) {
        self.articleService = articleService
    }
    
    
    func getArticles() -> Observable<[Article]> {
        articleService.getArticles()
    }
}
