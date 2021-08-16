//
//  MarketDataModel.swift
//  crypto-tracker
//
//  Created by Rick Brown on 10/08/2021.
//

import Foundation

// JSON DATA
/*
 URL: https://api.coingecko.com/api/v3/global
 
 JSON RESPONSE:
 {
 "data": {
 "active_cryptocurrencies": 8017,
 "upcoming_icos": 0,
 "ongoing_icos": 50,
 "ended_icos": 3375,
 "markets": 623,
 "total_market_cap": {
 "btc": 43295197.6991541,
 "eth": 683848396.8797559,
 "ltc": 9955329567.314304,
 "bch": 2777549476.990013,
 "bnb": 4562394393.687256,
 "eos": 343327941702.7271,
 "xrp": 1994876495123.7195,
 "xlm": 5195130026451.164,
 "link": 70424512784.12856,
 "dot": 74700534961.32976,
 "yfi": 42241646.315041244,
 "usd": 1546860286890.7075,
 "aed": 5681589990264.41,
 "ars": 147509972116692.72,
 "aud": 2066413532610.4106,
 "bdt": 131117854985005,
 "bhd": 583062688518.5762,
 "bmd": 1546860286890.7075,
 "brl": 7877805210128.69,
 "cad": 1928399564093.447,
 "chf": 1426915193384.9165,
 "clp": 1157977913860648.2,
 "cny": 9982044117334.424,
 "czk": 33338803785410.055,
 "dkk": 9695177330270.273,
 "eur": 1303683021769.4792,
 "gbp": 1121056055718.3025,
 "hkd": 12009139555172.629,
 "huf": 463948303845790.1,
 "idr": 22363337313044684,
 "ils": 5071573261246.7705,
 "inr": 114685360159248.22,
 "jpy": 170545213780417.94,
 "krw": 1756071043150126.8,
 "kwd": 466084473043.0409,
 "lkr": 307488700838742.1,
 "mmk": 2546549532907258,
 "mxn": 31943158372724.633,
 "myr": 6403692215670.161,
 "ngn": 634651640778454.6,
 "nok": 13398432012659.793,
 "nzd": 2229352060930.045,
 "php": 75000818825676.48,
 "pkr": 243089734485033.7,
 "pln": 5936167615699.997,
 "rub": 112468293262716.45,
 "sar": 5800727622700.437,
 "sek": 13328284992369.885,
 "sgd": 2080836457925.3796,
 "thb": 48692556918596.25,
 "try": 13534849621360.71,
 "twd": 42995728807645.79,
 "uah": 42070574872960.75,
 "vef": 154887120526.3664,
 "vnd": 35719561466981084,
 "zar": 22148007462112.64,
 "xdr": 1082567078059.8875,
 "xag": 59938438483.57022,
 "xau": 876605724.5809646,
 "bits": 43295197699154.1,
 "sats": 4329519769915410
 },
 "total_volume": {
 "btc": 3145659.544825988,
 "eth": 49685746.946035616,
 "ltc": 723315266.8089669,
 "bch": 201805869.65400952,
 "bnb": 331485712.8379228,
 "eos": 24944863962.215946,
 "xrp": 144939915305.14587,
 "xlm": 377457806472.55206,
 "link": 5116769355.540835,
 "dot": 5427448384.403738,
 "yfi": 3069112.6263795574,
 "usd": 112388811798.05975,
 "aed": 412802082735.6615,
 "ars": 10717497006716.652,
 "aud": 150137516349.54486,
 "bdt": 9526509958372.34,
 "bhd": 42363051997.478134,
 "bmd": 112388811798.05975,
 "brl": 572370481449.6177,
 "cad": 140109961783.2983,
 "chf": 103674070942.4265,
 "clp": 84134141221500.94,
 "cny": 725256241414.0593,
 "czk": 2422266946772.8267,
 "dkk": 704413623877.2987,
 "eur": 94720503861.72212,
 "gbp": 81451543574.40785,
 "hkd": 872537058945.3198,
 "huf": 33708667193055.72,
 "idr": 1624832526733481.2,
 "ils": 368480655692.6027,
 "inr": 8332589224873.635,
 "jpy": 12391147472765.6,
 "krw": 127589246194518.53,
 "kwd": 33863872882.873516,
 "lkr": 22340925047639.406,
 "mmk": 185022318184688.38,
 "mxn": 2320864815660.898,
 "myr": 465267203081.6085,
 "ngn": 46111303274940.945,
 "nok": 973477609207.1942,
 "nzd": 161975991840.2936,
 "php": 5449265834242.014,
 "pkr": 17661948303033.19,
 "pln": 431298696214.949,
 "rub": 8171505824976.626,
 "sar": 421458156631.5356,
 "sek": 968381001369.7767,
 "sgd": 151185429630.74997,
 "thb": 3537810532643.846,
 "try": 983389178519.667,
 "twd": 3123901307723.17,
 "uah": 3056683245218.927,
 "vef": 11253491725.339714,
 "vnd": 2595243478188412,
 "zar": 1609187502877.0925,
 "xdr": 78655085159.24849,
 "xag": 4354892254.516527,
 "xau": 63690739.64596051,
 "bits": 3145659544825.988,
 "sats": 314565954482598.8
 },
 "market_cap_percentage": {
 "btc": 43.28313299367642,
 "eth": 17.034983620703706,
 "usdt": 4.039227454774952,
 "bnb": 3.3871127449534613,
 "ada": 2.9904151581887746,
 "doge": 2.386211918652565,
 "xrp": 2.3167906754874017,
 "usdc": 1.579858093531471,
 "dot": 1.344489244432573,
 "uni": 0.7016697530063748
 },
 "market_cap_change_percentage_24h_usd": -0.21233920856828037,
 "updated_at": 1624226590
 }
 }
 
 */

struct GlobalData: Codable {
  let data: MarketDataModel?
}

struct MarketDataModel: Codable {
  let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
  let marketCapChangePercentage24HUsd: Double
  
  enum CodingKeys: String, CodingKey {
    case totalMarketCap = "total_market_cap"
    case totalVolume = "total_volume"
    case marketCapPercentage = "market_cap_percentage"
    case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
  }
  
  var marketCap: String {
    if let item = totalMarketCap.first(where: { $0.key == "usd" }) {
      return "$" + item.value.formattedWithAbbreviations()
    }
    return ""
  }
  
  var volume: String {
    if let item = totalVolume.first(where: { $0.key == "usd" }) {
      return "$" + item.value.formattedWithAbbreviations()
    }
    return ""
  }
  
  var btcDominance: String {
    if let item = marketCapPercentage.first(where: { $0.key == "btc" }) {
      return item.value.asPercentString()
    }
    return ""
  }
  
}
