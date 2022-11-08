//
//  ViewModel.swift
//  ListTap
//
//  Created by Eryk Gasiorowski on 12/09/2022.
//

import Foundation
import UIKit

final class ViewModel: NSObject {
    
    var reloadCollectionView: (() -> Void)?
    var actionLabelText: String = ""
    
    private var array: [CellInput] = []
    private var timer: Timer?
    
    func startButtonTapped() {
        reloadCollectionView?()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
    }
    
    func stopButtonTapped() {
        timer?.invalidate()
        actionLabelText = ""
        reloadCollectionView?()
    }
    
    private func randomInt() {
        let randomInt = Int.random(in: 0..<10)
        
        guard let index = array.indices.randomElement() else { return }
        
        switch randomInt {
        case (0...4):
            actionLabelText = "incrementRandomElement(index: \(index))"
            array[index].number += 1
            
        case (5...7):
            actionLabelText = "resetRandomElement(index: \(index))"
            array[index].number = 0
            
        case 8:
            actionLabelText = "deleteElement(index: \(index))"
            array.remove(at: index)
            
        case 9:
            actionLabelText = "addValueOfAnElementBefore(index: \(index))"
            if index != 0 {
                array[index].number += array[index-1].number
            }
            else {
                let lastElement = array.last
                array[index].number += lastElement?.number ?? 0
            }
        default: break
        }
    }
    
    @objc private func runTimer() {
        actionLabelText = ""
        
        if array.count < 5 {
            actionLabelText = "appendElement"
            appendRandomElement()
            reloadCollectionView?()
        }
        else {
            randomInt()
            reloadCollectionView?()
        }
    }
    
    private func appendRandomElement() {
        if array.count >= 1 {
            let newElement: CellInput = CellInput(isSeparatorHidden: false)
            array.append(newElement)
        }
        else {
            let newElement: CellInput = CellInput(isSeparatorHidden: true)
            array.append(newElement)
        }
    }
}

extension ViewModel: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        let model = array[indexPath.row]
        
        cell.configure(model: model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        array[indexPath.row].number += 1
        reloadCollectionView?()
    }
}
