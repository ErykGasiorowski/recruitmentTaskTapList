//
//  CustomCollectionViewCell.swift
//  ListTap
//
//  Created by Eryk Gasiorowski on 12/09/2022.
//

import UIKit
import SnapKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    private var circleFillImageName = "circle.fill"

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: circleFillImageName)
        imageView.backgroundColor = .systemBlue
        return imageView
    }()
    
    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.isHidden = false
        return view
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "1"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        label.text = nil
    }
    
    func configure() {
        // configure cell with viewModel 
    }
    
    private func layout() {
        contentView.addSubview(label)
        contentView.addSubview(imageView)
        contentView.addSubview(separator)
        contentView.clipsToBounds = true
        
        imageView.snp.makeConstraints {
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.leading.equalTo(contentView.snp.leading).offset(20)
            $0.width.height.equalTo(50)
        }
        
        label.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(20)
            $0.centerY.equalTo(contentView.snp.centerY)
        }
        
        separator.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top)
            $0.leading.equalTo(contentView.snp.leading)
            $0.trailing.equalTo(contentView.snp.trailing)
            $0.width.equalToSuperview()
            $0.height.equalTo(2)
        }
    }
}
