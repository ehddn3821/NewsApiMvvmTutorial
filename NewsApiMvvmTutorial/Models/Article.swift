//
//  Article.swift
//  NewsApiMvvmTutorial
//
//  Created by dwKang on 2022/03/23.
//

import Foundation

struct ArticleRes: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
}
