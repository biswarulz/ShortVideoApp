//
//  DetailViewController.swift
//  ShortVideoApp
//
//  Created by Biswajyoti Sahu on 08/05/21.
//

import UIKit

class VideoViewController: UIViewController {

    let detailView = VideoView()
    var nodeData: [Node] = []
    var indexPathToLoad: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.makeBarTransparent()
        detailView.scrollView.delegate = self
        detailView.addPlayerToScrollView(nodeData)
        detailView.playVideo(indexPathToLoad.row)
    }
    
    override func loadView() {
        
        view = detailView
    }

}

extension VideoViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let currentIndex = Int(scrollView.contentOffset.y / UIScreen.main.bounds.height)
        
        detailView.playVideo(currentIndex)
    }
}
