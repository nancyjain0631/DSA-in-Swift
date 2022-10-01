//  generic method, T can be anything
struct Stack<T> {
    
    var items: [T] = []
    init() { }
    init(_ elements: [T]){
        items = elements
    }
    mutating func push(_ element: T){
        items.append(element)
    }
    
    @discardableResult
    mutating func pop() -> T? {
        items.popLast()
    }
    func peek() -> T? {
        return items.last
    }
    var isEmpty: Bool {
        peek() == nil
    }
}

func example(of description: String, action: () -> ()) {
  print("---Example of \(description)---")
  action()
  print()
}

example(of: "using a stack") {
    var stack = Stack<Int>()
    stack.push(3)
    stack.push(4)
    stack.push(5)
    stack.pop()
    print(stack)
}
example(of: "initializing stack from array literal"){
    var stack: Stack = [1.0,2.0,3.0]
    print(stack)
}
example(of: "initializing stack from array") {
    let array = ["A","B","C"]
    var stack = Stack(array)
    print(stack)
}
// CHALLENGE 1
// Create a function that uses a stack to print the contents of an array in reversed order.
let array: [Int] = [4,5,6,7,8,9]
func printArrayInReverse<T>(_ array: [T]) {
    var stack = Stack<T>()
    for value in array {
        stack.push(value)
    }
    while let value = stack.pop() {
        print(value)
    }
}
printArrayInReverse(array)

// CHALLENGE 2
// Check for balanced parentheses. Given a string, check if there are ( and ) characters, and return true if the parentheses in the string are balanced.
var test1 = "h((e))llo(world)()"
func checkParenthesis(_ string: String) -> Bool {
    var stack = Stack<Character>()
    for character in string {
        if character == "(" {
            stack.push(character)
        }
        else if character == ")" {
            if stack.isEmpty {
                return false
            }
            else {
                stack.pop()
            }
        }
    }
    return stack.isEmpty
}
checkParenthesis(test1)


//  to print the formatted description
extension Stack: CustomStringConvertible {
    var description: String {
        """
        ---top---
        \(items.map({"\($0)"}).reversed().joined(separator: "\n"))
        ---------
        """
    }
}
extension Stack: ExpressibleByArrayLiteral {
    typealias ArrayLiteralElement = T
    
    init(arrayLiteral elements: T...) {
        items = elements
    }
}



