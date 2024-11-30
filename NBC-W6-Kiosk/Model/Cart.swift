final class Cart {
    var items: [CartItem] = []
    private let maxItems = 20
    
    var totalQuantity: Int {
        items.reduce(0) { $0 + $1.quantity }
    }
    
    var totalPrice: Int {
        items.reduce(0) { $0 + ($1.product.price * $1.quantity) }
    }
    
    func addItem(_ product: Product) -> Bool {
        if totalQuantity >= maxItems {
            return false
        }
        
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(product: product, quantity: 1))
        }
        
        return true
    }
    
    func decreaseQuantity(for productId: String) {
        guard let index = items.firstIndex(where: { $0.product.id == productId }) else { return }
        
        if items[index].quantity > 1 {
            items[index].quantity -= 1
        } else {
            items.remove(at: index)
        }
    }
    
    func removeItem(productId: String) {
        items.removeAll { $0.product.id == productId }
    }
    
    func clear() {
        items.removeAll()
    }
}

struct CartItem {
    let product: Product
    var quantity: Int
}
