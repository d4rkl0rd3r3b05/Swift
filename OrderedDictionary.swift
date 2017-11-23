import Foundation

public struct OrderedDictionary<K: Hashable, V>{
    //Ordered Set of Keys
    public var keys : [K]?
    private var dictionary : [K:V]?
    
    subscript(key : K) -> V?{
        get{
            return self.dictionary?[key] ?? nil
        }
        
        set{
            if self.dictionary == nil{
                self.dictionary = [K:V]()
            }
            
            if keys == nil {
                keys = [K]()
            }
            
            if newValue != nil {
                let updatedValue = self.dictionary!.updateValue(newValue!, forKey: key)
                if updatedValue == nil {
                    self.keys!.append(key)
                }
            }else{
                //Removing element from collection
                self.dictionary!.removeValue(forKey: key)
                self.keys = self.keys!.filter{$0 != key}
            }
            
        }
    }
}

extension OrderedDictionary : ExpressibleByDictionaryLiteral, CustomStringConvertible {
    public init(dictionaryLiteral: (K,V)...){
        self.init()
        for (key, value) in dictionaryLiteral{
            self[key] = value
        }
    }
    
    public var description: String{
        guard self.keys != nil else {
            return "nil"
        }
        
        var desc = "[ "
        for key in self.keys! {
            desc += "\(key) : \(self[key]!), "
        }
        
        desc = desc.dropLast(2) + " ]"
        
        return desc
    }
}
