//
//  OnboardingViewController.swift
//  Yummie
//
//  Created by Наталья Шарапова on 23.04.2022.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: - Properties
    
    var slides = [OnboardingSlide]()
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextButton.setTitle("Get started", for: .normal)
                
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    // MARK: - ViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slides = [
            OnboardingSlide(image: UIImage(named: "dish")!, title: "Delicious dishes", description: "Experience of variety of amazing dishes from different cultures around the world"),
            OnboardingSlide(image: UIImage(named: "chef")!, title: "World-Class chefs", description: "Our dishes are prepared by only the best"),
            OnboardingSlide(image: UIImage(named: "delivery")!, title: "Instant world-wide delivery", description: "Our orders will be delivered instantly irrespective of your location around the world")
        ]
        
        pageControl.numberOfPages = slides.count
    }
    
    // MARK: - Actions
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
        if currentPage == slides.count - 1 {
            
            let controller = storyboard?.instantiateViewController(withIdentifier: "HomeNavigationController") as! UINavigationController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            present(controller, animated: true, completion: nil)
            
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
        }
    }
}
// MARK: - Extensions

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        
        cell.setupSlide(slides[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}

