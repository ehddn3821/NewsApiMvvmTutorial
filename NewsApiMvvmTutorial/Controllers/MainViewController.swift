//
//  MainViewController.swift
//  NewsApiMvvmTutorial
//
//  Created by dwKang on 2022/03/23.
//

import UIKit
import RxSwift

final class MainViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    private let viewModel: MainViewModel
    
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
    }

    private func configureUI() {
        view.backgroundColor = .gray
    }
    
    private func getArticles() {
        viewModel.getArticles().subscribe(onNext: {
            print($0)
        }).disposed(by: disposeBag)
    }
}

