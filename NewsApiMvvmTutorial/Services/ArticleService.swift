//
//  ArticleService.swift
//  NewsApiMvvmTutorial
//
//  Created by dwKang on 2022/03/23.
//

import Foundation
import Alamofire
import RxSwift

protocol ArticleServiceProtocol {
    func getArticles() -> Observable<[Article]>
}


struct ArticleService: ArticleServiceProtocol {

    func getArticles() -> Observable<[Article]> {
        return Observable.create { observer -> Disposable in
            getArticles { (articles, error) in
                if let articles = articles {
                    observer.onNext(articles)
                }
                
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    private func getArticles(completion: @escaping (([Article]?, Error?) -> Void)) {

        guard let url = URL(string: Constant.API_URL) else { return }

        AF.request(url, method: .get, encoding: JSONEncoding.default)
            .responseDecodable(of: ArticleRes.self) { res in

                switch res.result {
                case .success(let res):
                    completion(res.articles, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }
}
