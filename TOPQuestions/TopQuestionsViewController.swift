//
//  ViewController.swift
//  Top100Questions
//
//  Created by мария баженова on 31.08.2023.
//

import UIKit

class TopQuestionsViewController: UIViewController {
    private let dataModel = QuestionsDataModel()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchTopQuestions()
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(QuestionTableViewCell.self, forCellReuseIdentifier: "QuestionCell")
    }
    
    private func fetchTopQuestions() {
        dataModel.fetchTopQuestions()
        self.tableView.reloadData()
        
    }
}

    extension TopQuestionsViewController: UITableViewDataSource, UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dataModel.questions.count

        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath) as? QuestionTableViewCell else {
                return UITableViewCell()
            }
            let question = dataModel.questions[indexPath.row]
            cell.configure(with: question)
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let question = dataModel.questions[indexPath.row]
            let questionViewController = QuestionViewController(question: question)
            navigationController?.pushViewController(questionViewController, animated: true)
        }
        
    }

    class QuestionTableViewCell: UITableViewCell {
        
        private let titleLabel = UILabel()
        private let tagsLabel = UILabel()
        private let scoreLabel = UILabel()
        private let answerCountLabel = UILabel()
        private let viewCountLabel = UILabel()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            configureLabels()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func configureLabels() {
            contentView.addSubview(titleLabel)
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0).isActive = true
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0).isActive = true
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0).isActive = true
            titleLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
            titleLabel.numberOfLines = 0
            
            contentView.addSubview(tagsLabel)
            tagsLabel.translatesAutoresizingMaskIntoConstraints = false
            tagsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0).isActive = true
            tagsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0).isActive = true
            tagsLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
            tagsLabel.textColor = .systemBlue
            
            contentView.addSubview(scoreLabel)
            scoreLabel.translatesAutoresizingMaskIntoConstraints = false
            scoreLabel.topAnchor.constraint(equalTo: tagsLabel.bottomAnchor, constant: 8.0).isActive = true
            scoreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0).isActive = true
            scoreLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0).isActive = true
            
            contentView.addSubview(answerCountLabel)
            answerCountLabel.translatesAutoresizingMaskIntoConstraints = false
            answerCountLabel.leadingAnchor.constraint(equalTo: scoreLabel.trailingAnchor, constant: 16.0).isActive = true
            answerCountLabel.centerYAnchor.constraint(equalTo: scoreLabel.centerYAnchor).isActive = true
            
            contentView.addSubview(viewCountLabel)
            viewCountLabel.translatesAutoresizingMaskIntoConstraints = false
            viewCountLabel.leadingAnchor.constraint(equalTo: answerCountLabel.trailingAnchor, constant: 16.0).isActive = true
            viewCountLabel.centerYAnchor.constraint(equalTo: scoreLabel.centerYAnchor).isActive = true
        }
        
        func configure(with question: Question) {
            titleLabel.text = question.title
            tagsLabel.text = question.tags.joined(separator: ", ")
            scoreLabel.text = "Score: \(question.score.thousandsFormatting)"
            answerCountLabel.text = "Answers: \(question.answerCount.thousandsFormatting)"
            viewCountLabel.text = "Views: \(question.viewCount.thousandsFormatting)"
        }
        
    }

