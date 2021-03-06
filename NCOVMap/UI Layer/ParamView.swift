//
//  ParamView.swift
//  NCOVMap
//
//  Created by Emil Karimov on 18.02.2020.
//  Copyright © 2020 ESKARIA LLC. All rights reserved.
//

import UIKit
import SnapKit

public enum CompressionMode {
    case paramDominates
    case valueDominates
    case fixedParamWidth(width: CGFloat)
    case fixedValueWidth(width: CGFloat)
    case equalWidth
}

public enum VerticalAlignmentMode {
    case top
    case middle
    case bottom
}

public struct ParamValueViewConfiguration {

    public var fontParam = UIFont()
    public var fontValue = UIFont()
    public var colorParam = UIColor()
    public var colorValue = UIColor()
    public var compressionMode: CompressionMode
    public var verticalAlighnmentParam: VerticalAlignmentMode
    public var verticalAlighnmentValue: VerticalAlignmentMode
    public var insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    public var unwrapPlaceholderParam = "-"
    public var unwrapPlaceholderValue = "-"
    public var paramAligment: NSTextAlignment = .left
    public var valueAligment: NSTextAlignment = .right

    public init() {
        self.compressionMode = .paramDominates
        self.verticalAlighnmentParam = .middle
        self.verticalAlighnmentValue = .middle
        self.colorParam = UIColor.black
        self.colorValue = UIColor.black
        
    }
}

public class ParamValueView: UIView {

    public var labelParam = UILabel()
    public var labelValue = UILabel()
    private let configuration: ParamValueViewConfiguration
    
    public var param: String? {
        get {
            return self.labelParam.text
        }
        set {
            self.labelParam.text = String.unwrap(newValue, placeholder: configuration.unwrapPlaceholderParam)
        }
    }
    public var value: String? {
        get {
            return self.labelValue.text
        }
        set {
            self.labelValue.text = String.unwrap(newValue, placeholder: configuration.unwrapPlaceholderValue)
        }
    }
    
    public init(configuration: ParamValueViewConfiguration) {

        self.configuration = configuration
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.labelParam.translatesAutoresizingMaskIntoConstraints = false
        self.labelParam.font = configuration.fontParam
        self.labelParam.textColor = configuration.colorParam
        self.labelValue.textAlignment = configuration.paramAligment
        self.labelParam.backgroundColor = UIColor.clear
        self.labelValue.translatesAutoresizingMaskIntoConstraints = false
        self.labelValue.font = configuration.fontValue
        self.labelValue.textColor = configuration.colorValue
        self.labelValue.textAlignment = configuration.valueAligment
        self.labelParam.backgroundColor = UIColor.clear

        self.labelParam.setContentHuggingPriority(.defaultLow, for: .vertical)
        self.labelValue.setContentHuggingPriority(.defaultLow, for: .vertical)
        self.labelParam.setContentCompressionResistancePriority(.required, for: .vertical)
        self.labelValue.setContentCompressionResistancePriority(.required, for: .vertical)
        self.addSubview(self.labelParam)
        self.addSubview(self.labelValue)
        self.labelParam.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(configuration.insets.left)
        }

        self.labelValue.snp.makeConstraints { make in
            make.left.equalTo(self.labelParam.snp.right).offset(8)
            make.right.equalToSuperview().offset(-configuration.insets.right)
        }

        switch configuration.compressionMode {
        case .paramDominates:
            self.labelValue.numberOfLines = 0
            process(verticalAlighnment: .middle, view: self.labelValue, insets: configuration.insets)
            process(verticalAlighnment: configuration.verticalAlighnmentParam, view: self.labelParam, insets: configuration.insets)

        case .valueDominates:
            self.labelParam.numberOfLines = 0
            process(verticalAlighnment: .middle, view: self.labelParam, insets: configuration.insets)
            process(verticalAlighnment: configuration.verticalAlighnmentValue, view: self.labelValue, insets: configuration.insets)

        default:
            if configuration.verticalAlighnmentParam == .middle {
                self.labelParam.numberOfLines = 0
            }
            if configuration.verticalAlighnmentValue == .middle {
                self.labelValue.numberOfLines = 0
            }
            self.process(verticalAlighnment: configuration.verticalAlighnmentValue, view: self.labelValue, insets: configuration.insets)
            self.process(verticalAlighnment: configuration.verticalAlighnmentParam, view: self.labelParam, insets: configuration.insets)
        }

        switch configuration.compressionMode {
        case .paramDominates:
            let priorityParam = UILayoutPriority.defaultHigh
            let priorityValue = UILayoutPriority.defaultLow
            self.labelParam.setContentHuggingPriority(priorityValue, for: .horizontal)
            self.labelValue.setContentHuggingPriority(priorityParam, for: .horizontal)
            self.labelParam.setContentCompressionResistancePriority(priorityParam, for: .horizontal)
            self.labelValue.setContentCompressionResistancePriority(priorityValue, for: .horizontal)
        case .valueDominates:
            let priorityParam = UILayoutPriority.defaultLow
            let priorityValue = UILayoutPriority.defaultHigh
            self.labelParam.setContentHuggingPriority(priorityValue, for: .horizontal)
            self.labelValue.setContentHuggingPriority(priorityParam, for: .horizontal)
            self.labelParam.setContentCompressionResistancePriority(priorityParam, for: .horizontal)
            self.labelValue.setContentCompressionResistancePriority(priorityValue, for: .horizontal)
        case .fixedParamWidth(let width):
            self.labelParam.snp.makeConstraints({

                $0.width.equalTo(width)
            })
        case .fixedValueWidth(let width):
            self.labelValue.snp.makeConstraints({

                $0.width.equalTo(width)
            })
        case .equalWidth:
            self.labelParam.snp.makeConstraints({

                $0.width.equalTo(labelValue)
            })
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func process(verticalAlighnment: VerticalAlignmentMode, view: UIView, insets: UIEdgeInsets) {

        let filler = UIView()
        filler.translatesAutoresizingMaskIntoConstraints = false
        switch verticalAlighnment {
        case .top:

            view.snp.makeConstraints({ make in
                make.top.equalToSuperview().offset(insets.top)
            })
            self.addSubview(filler)
            filler.snp.makeConstraints({ make in
                make.top.equalTo(view.snp.bottom)
                make.bottom.equalToSuperview().offset(-insets.bottom)
                make.left.equalTo(view)
                make.right.equalTo(view)
            })

        case .middle:
            view.snp.makeConstraints({ make in
                make.top.equalToSuperview().offset(insets.top)
                make.bottom.equalToSuperview().offset(-insets.bottom)
            })

        case .bottom:

            view.snp.makeConstraints({ make in
                make.bottom.equalToSuperview()
            })
            self.addSubview(filler)
            filler.snp.makeConstraints({ make in
                make.top.equalToSuperview().offset(insets.top)
                make.bottom.equalTo(view.snp.top)
                make.left.equalTo(view)
                make.right.equalTo(view)
            })
        }
    }
    
    public func setAccessibilityLabel(label: String) {
        self.labelParam.accessibilityLabel = "\(label):title"
        self.labelValue.accessibilityLabel = "\(label):value"
    }

}

