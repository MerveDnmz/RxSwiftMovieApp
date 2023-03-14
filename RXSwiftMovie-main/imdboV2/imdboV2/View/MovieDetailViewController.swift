//
//  DetailsViewController.swift

import UIKit
import RxSwift

class MovieDetailViewController: UIViewController{
    
    var selectedMovie : ListResult!
    let movieVM = MovieViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var filmImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        
        movieVM.requestMovieData(id: selectedMovie.imdbID)
        
        setupBindings()
    }
    
    
    private func setupBindings()
    {
        movieVM
            .error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {
                failure in print(failure)
            })
            .disposed(by: disposeBag)
                
        movieVM
            .movie
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { movie in
                self.titleLabel.text = movie.title
                self.actorsLabel.text = movie.actors
                self.directorLabel.text = "Director : " + movie.director
                self.yearLabel.text = movie.year
                self.ratingLabel.text = "IMDB Rating: " + movie.imdbRating
                self.countryLabel.text = movie.country
                
                DispatchQueue.global().async {
                    let data = try! Data(contentsOf: URL(string: movie.poster)!)
                    
                    DispatchQueue.main.async
                    {
                        self.filmImageView.image = UIImage(data: data)
                    }
                }
                
            })
            .disposed(by: disposeBag)
        
    }
    
}
