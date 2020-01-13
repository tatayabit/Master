//
//  FilterTableViewController.swift
//  Tatayaba
//
//  Created by new on 1/13/20.
//  Copyright © 2020 Shaik. All rights reserved.
//

import UIKit

struct Headline {

    var id : Int
    var title : String
    var text : String
    var image : String

}

class FilterTableViewController: UITableViewController {

    var headlines = [
    Headline(id: 1, title: "Lorem Ipsum", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque id ornare tortor, quis dictum enim. Morbi convallis tincidunt quam eget bibendum. Suspendisse malesuada maximus ante, at molestie massa fringilla id.", image: "Apple"),
    Headline(id: 2, title: "Aenean condimentum", text: "Ut eget massa erat. Morbi mauris diam, vulputate at luctus non, finibus et diam. Morbi et felis a lacus pharetra blandit.", image: "Banana"),
    Headline(id: 3, title: "In ac ante sapien", text: "Aliquam egestas ultricies dapibus. Nam molestie nunc in ipsum vehicula accumsan quis sit amet quam. Sed vel feugiat eros.", image: "Cantaloupe"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//
//        return headlines.count
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return headlines.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! FilterTableViewCell

           let headline = headlines[indexPath.row]
           cell.nameLBL?.text = headline.title
           cell.arrowImg?.image = UIImage(named: "right_rectangle_product")

           return cell
       }
   

}
