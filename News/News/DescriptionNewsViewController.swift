//
//  DescriptionNewsViewController.swift
//  News
//
//  Created by M1 on 16.08.2022.
//

import UIKit

class DescriptionNewsViewController: UIViewController {
    
    var article: Article?
    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: 17, weight: .light)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondarySystemBackground

        self.view.addSubview(newsTitleLabel)
        self.view.addSubview(newsImageView)
        self.view.addSubview(subTitleLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        newsTitleLabel.frame = CGRect(
            x: 20,
            y: 100,
            width: view.frame.self.width - 10,
            height: 70
        )
        
        newsImageView.frame = CGRect(
            x: 20,
            y: 200,
            width: 300,
            height: 300
        )
        
        subTitleLabel.frame = CGRect(
            x: 20,
            y: 250,
            width: view.frame.self.width - 10,
            height: view.frame.self.height
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        newsTitleLabel.text = article?.title
        subTitleLabel.text = article?.description
        
        guard let article = article,
              let urlToImage = article.urlToImage,
              let url = URL(string: urlToImage)
        else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.newsImageView.image = UIImage(data: data)
            }
        }.resume()
    }
}
