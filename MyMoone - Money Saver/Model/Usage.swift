//
//  Usage.swift
//  MyMoone - Money Saver
//
//  Created by MacBook on 15/05/21.
//

import Foundation

struct Usage {
    var id : Int
    var title : String
    var dateTime : String
    var balance : Double
    var usageState : UsageState
    var status : String
}

//var usages : [Usage] = [
//    Usage(id: 1, title: "Bayar Listrik", dateTime: "1-Mei-2021 19:30", balance: 200000.0, usageState: UsageState.Outcome, status: "Pengeluaran"),
//    Usage(id: 2, title: "Gaji Februari", dateTime: "1-Mei-2021 19:30", balance: 1200000.0, usageState: UsageState.Income, status: "Pemasukan")
//]

var usages : [Usage] = [Usage]()
