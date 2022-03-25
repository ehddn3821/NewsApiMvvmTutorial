//
//  MainViewController.swift
//  NewsApiMvvmTutorial
//
//  Created by dwKang on 2022/03/23.
//

import UIKit
import RxSwift
import RxRelay
import SnapKit

final class MainViewController: UIViewController {
    
    //MARK: Propertys
    private let disposeBag = DisposeBag()
    private let viewModel: MainViewModel
    private let articleViewModels = BehaviorRelay<[ArticleViewModel]>(value: [])
    var articleViewModelObserver: Observable<[ArticleViewModel]> { articleViewModels.asObservable() }
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(ArticleTableViewCell.self, forCellReuseIdentifier: "cell")
        return tv
    }()
    
    
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
        title = viewModel.title
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func getArticles() {
        viewModel.getArticles().subscribe(onNext: { [weak self] articleViewModels in
            guard let self = self else { return }
            self.articleViewModels.accept(articleViewModels)
        }).disposed(by: disposeBag)
    }
    
    func subscribeArticles() {
        articleViewModelObserver.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }).disposed(by: disposeBag)
    }
}


//MARK: TableView
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleViewModels.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ArticleTableViewCell
        
        let viewModel = articleViewModels.value[indexPath.row]
        cell.viewModel.onNext(viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
