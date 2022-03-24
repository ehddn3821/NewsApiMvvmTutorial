//
//  MainViewController.swift
//  NewsApiMvvmTutorial
//
//  Created by dwKang on 2022/03/23.
//

import UIKit
import RxSwift
import RxRelay

final class MainViewController: UIViewController {
    
    //MARK: Propertys
    private let disposeBag = DisposeBag()
    private let viewModel: MainViewModel
    private let articles = BehaviorRelay<[Article]>(value: [])
    var articlesObserver: Observable<[Article]> { articles.asObservable() }
    
    
    //MARK: Life-cycles
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getArticles()
        subscribeArticles()
    }

    
    private func configureUI() {
        view.backgroundColor = .gray
    }
    
    private func getArticles() {
        viewModel.getArticles().subscribe(onNext: { [weak self] articles in
            guard let self = self else { return }
            self.articles.accept(articles)
        }).disposed(by: disposeBag)
    }
    
    func subscribeArticles() {
        articlesObserver.subscribe(onNext: { [weak self] articles in
            guard let self = self else { return }
            // ReloadData 시 활용
        }).disposed(by: disposeBag)
    }
}

