import Foundation

class Quote {
  
  let item: String
  let quantity: Int
  
  init(item: String, quantity: Int) {
    self.item = item
    self.quantity = quantity
  }
  
}

struct Price {
  var value: Double
  
  func displayPrice() -> String {
    return String(format:"£%.2f", value)
  }
}


// What
protocol SupplierStrategy {
  func supplierName() -> String
  func requestQuote(_ quote: Quote) -> Price
}

// Who
struct QuoteService {
  let strategy: SupplierStrategy
  
  func send(quote: Quote) {
    let price = strategy.requestQuote(quote)
    print("\(strategy.supplierName()) quote = \(price.displayPrice())")
  }
}

// How
class ArgosStrategy: SupplierStrategy {
  
  func supplierName() -> String {
    return "Argos"
  }
  
  func requestQuote(_ quote: Quote) -> Price {
    let total: Double = 2.0 * Double(quote.quantity)
    return Price(value: total)
  }
  
}

class AmazonStrategy: SupplierStrategy {
  
  func supplierName() -> String {
    return "Amazon"
  }
  
  func requestQuote(_ quote: Quote) -> Price {
    let total: Double = 1.0 * Double(quote.quantity)
    return Price(value: total)
  }
  
}

class AsdaStrategy: SupplierStrategy {
  
  func supplierName() -> String {
    return "Asda"
  }
  
  func requestQuote(_ quote: Quote) -> Price {
    let total: Double = 1.5 * Double(quote.quantity)
    return Price(value: total)
  }
  
}

let quote = Quote(item: "pens", quantity: 5)

let argosQuote = QuoteService(strategy: ArgosStrategy())
argosQuote.send(quote: quote)

let amazonQuote = QuoteService(strategy: AmazonStrategy())
amazonQuote.send(quote: quote)

let asdaQuote = QuoteService(strategy: AsdaStrategy())
asdaQuote.send(quote: quote)
