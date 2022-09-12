import UIKit
import SnapKit

class ViewController: UIViewController {

    private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 2
        layout.itemSize = CGSize(width: view.frame.size.width, height: view.frame.size.height / 9)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.frame = view.bounds
        return collectionView
    }()
    
    private let actionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.layer.cornerRadius = 5
        button.setTitle("START", for: .normal)
        button.setTitle("STOP", for: .selected)
        button.isSelected = false
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    private let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        layout()
    }

    @objc private func didTapButton() {
        if button.isSelected == false {
            button.isSelected = true
            button.backgroundColor = .red
        }
        else {
            button.isSelected = false
            button.backgroundColor = .systemGreen
        }
    }
    
    private func layout() {
        view.addSubview(collectionView)
        view.addSubview(actionLabel)
        view.addSubview(button)
        
        button.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(50)
            $0.bottom.equalTo(view.safeAreaInsets).offset(-40)
        }
        
        actionLabel.snp.makeConstraints {
            $0.bottom.equalTo(button.snp.top).offset(-10)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(40)
        }
    }
}

extension ViewController:  UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell
    else {
        return UICollectionViewCell()
    }
    
    return cell
}
}

