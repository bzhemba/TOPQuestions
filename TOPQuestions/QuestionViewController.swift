//
//  QuestionViewController.swift
//  TOPQuestions
//
//  Created by мария баженова on 31.08.2023.
//

import UIKit

class QuestionViewController: UIViewController {
    
    private let question: Question
    private let titleLabel = UILabel()
    private let tagsLabel = UILabel()
    private let bodyTextView = UITextView()
    
    init(question: Question) {
        
        self.question = question
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabels()
        configureBodyTextView()
    }
    
    private func configureLabels() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16.0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16.0).isActive = true
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        titleLabel.numberOfLines = 0
        titleLabel.text = question.title
        
        view.addSubview(tagsLabel)
        tagsLabel.translatesAutoresizingMaskIntoConstraints = false
        tagsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0).isActive = true
        tagsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16.0).isActive = true
        tagsLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        tagsLabel.textColor = .systemBlue
        tagsLabel.text = question.tags.joined(separator: ", ")
    }
    
    private func configureBodyTextView() {
        view.addSubview(bodyTextView)
        bodyTextView.translatesAutoresizingMaskIntoConstraints = false
        bodyTextView.topAnchor.constraint(equalTo: tagsLabel.bottomAnchor, constant: 16.0).isActive = true
        bodyTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16.0).isActive = true
        bodyTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16.0).isActive = true
        bodyTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16.0).isActive = true
        bodyTextView.font = UIFont.systemFont(ofSize: 18.0)
        bodyTextView.isEditable = false
        bodyTextView.text = question.body
    }
}
