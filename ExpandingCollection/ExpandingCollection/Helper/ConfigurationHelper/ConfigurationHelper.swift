//
//  ConfigurationHelper.swift
//  ExpandingCollection
//
//  Created by henvy on 16/8/8.
//  Copyright © 2016年 csh. All rights reserved.
//

import Foundation

@warn_unused_result
internal func Init<Type>(value : Type, @noescape block: (object: Type) -> Void) -> Type
{
    block(object: value)
    return value
}


func Inited<T>(value: T, block: (object: T) -> Void) -> T {
    block(object: value)
    return value
}