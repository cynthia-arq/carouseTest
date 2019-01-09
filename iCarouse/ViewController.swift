//
//  ViewController.swift
//  iCarouse
//
//  Created by Fu Qian on 9/1/19.
//  Copyright © 2019 Fu Qian. All rights reserved.
//

import UIKit
struct News {
    let name: String
    let imageURL: String
    let imageURLs: [String]?
    init(name: String,
         imageURL: String,
         imageURLs: [String]?) {
        self.name = name
        self.imageURL = imageURL
        self.imageURLs = imageURLs
    }
}
class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var cellItems: [News] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "NewsTableViewCell", bundle: bundle)
        //self.tableView.register(nib, forCellWithReuseIdentifier: "NewsTableViewCell")
        self.tableView.register(nib, forCellReuseIdentifier: "NewsTableViewCell")
        //self.tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
        cellItems = sampleData()
    }
    
    private func sampleData() -> [News]{
        return [News(name: "news1",imageURL: "1345",imageURLs: ["https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&ved=2ahUKEwjysLXCsuDfAhUEW7wKHaZVD8MQjRx6BAgBEAU&url=https%3A%2F%2Fwww.foodnetwork.com%2Ffn-dish%2Fnews%2F2018%2F4%2Feverything-you-need-to-eat-at-coachella-this-weekend&psig=AOvVaw0Cy-u3FSdfhtOwi4-JqVQM&ust=1547112811017227","https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&cad=rja&uact=8&ved=2ahUKEwiRo7rOsuDfAhUEf7wKHcblDVoQjRx6BAgBEAU&url=http%3A%2F%2Fthehorsesurryhills.com.au%2Ffood%2F&psig=AOvVaw0Cy-u3FSdfhtOwi4-JqVQM&ust=1547112811017227"]),
                News(name: "news2",imageURL: "T##String",imageURLs: ["3","4"]),
                News(name: "news3",imageURL: "45",imageURLs: ["5"]),
                News(name: "news4",imageURL: "12345",imageURLs: []),
        ]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsTableViewCell.self), for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(fromNews: cellItems[indexPath.row])
        return cell
    }
    


}

