//
//  DetailView.swift
//  ShortVideoApp
//
//  Created by Biswajyoti Sahu on 08/05/21.
//

import UIKit
import AVKit

class VideoView: UIView {

    let scrollView: UIScrollView
    var player: AVPlayer?
    
    override init(frame: CGRect) {
        
        scrollView = UIScrollView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false
        
        super.init(frame: frame)
        
        addSubview(scrollView)
        addCustomConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func addPlayerToScrollView(_ nodes: [Node]) {
        
        for (index,node) in nodes.enumerated() {
            
            if let videoURL = URL(string: node.video.encodeUrl) {
                
                let videoView = UIView()
                let yOrigin = CGFloat(index) * scrollView.frame.size.height
                let player = AVPlayer(url: videoURL)
                let layer = AVPlayerLayer(player: player)
                layer.frame = scrollView.bounds
                layer.videoGravity = .resizeAspectFill
                videoView.layer.addSublayer(layer)
                videoView.frame = CGRect(x: 0.0, y: yOrigin, width: scrollView.frame.size.width, height: scrollView.frame.size.height)
                scrollView.addSubview(videoView)
            }
        }
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: scrollView.frame.size.height * CGFloat(nodes.count))
    }
    
    func playVideo(_ currentIndex: Int) {
        
        scrollView.contentOffset.y = CGFloat(currentIndex) * scrollView.frame.size.height
        for (index, videoView) in scrollView.subviews.enumerated() {
            
            if let videoLayer = videoView.layer.sublayers?.first as? AVPlayerLayer {
                
                player = videoLayer.player
                if currentIndex == index {
                    
                    NotificationCenter.default.addObserver(self, selector: #selector(videoReachedEndTime(notification:)), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
                    player?.play()
                    player?.actionAtItemEnd = .none
                } else {
                    
                    player?.seek(to: .zero)
                    player?.pause()
                }
            }
        }
    }
    
    @objc private func videoReachedEndTime(notification: Notification) {
        
        if let playerItem = notification.object as? AVPlayerItem {
            
            playerItem.seek(to: .zero, completionHandler: nil)
        }
    }
    
    private func addCustomConstraints() {
        
        NSLayoutConstraint.activate([
            
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
