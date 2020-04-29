//
//  ViewController.swift
//  MobileBlog
//
//  Created by Yasin Shamrat on 29/4/20.
//  Copyright © 2020 Yasin Shamrat. All rights reserved.
//

import UIKit

struct Post: Codable {
    var id:Int?
    var title:String?
    var body:String?
    var tags:String?
    var created_at:String?
    var updated_at:String?
 init(id:Int,title:String,body:String,tags:String,created_at:String,updated_at:String) {
        self.id = id
        self.title = title
        self.body = body
        self.tags = tags
        self.created_at = created_at
        self.updated_at = updated_at
    }
}

struct Posts: Codable {
    var data: [Post]?
    
    init(data:[Post]) {
        self.data = data
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var posts: Posts?
    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .gray
        
        getData()
        
    }
    
    // MARK:- Table view methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? HomeTableViewCell
        
        cell?.title.text = self.posts?.data![indexPath.row].title
        cell?.body.text = self.posts?.data![indexPath.row].body
        cell?.tags.text = self.posts?.data![indexPath.row].tags
        
        return cell!
    }
    
    // MARK:- Data Fetching
    
    func getData(){
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
        let url = URL(string: "http://localhost:8888/MobileBlog/public/api/posts")
        let request = URLRequest(url: url!)
        
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 5, execute: {
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let response = response as? HTTPURLResponse, let data = data, response.statusCode == 200, error == nil else {
                    fatalError("Problem fetching data")
                }
                do{
                    let json = try JSONDecoder().decode(Posts.self,from: data)
                    self.posts = json
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.tableView.reloadData()
//                        self.activityIndicator.removeFromSuperview()
                    }
                }catch let error {
                    print("error decoding data: \(error.localizedDescription)")
                }
                
                
                }.resume()
        })
    }
    
    
    


}

