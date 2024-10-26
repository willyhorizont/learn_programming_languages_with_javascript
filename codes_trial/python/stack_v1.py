class Stack:
    def __init__(self):
        self.stack = []

    def push(self, item):
        self.stack.append(item)  # Add item to the top of the stack

    def pop(self):
        if (self.is_empty() == False):
            return self.stack.pop()  # Remove and return the top item
        return None  # Return None if the stack is empty

    def peek(self):
        if (self.is_empty() == False):
            return self.stack[-1]  # Return the top item without removing it
        return None

    def is_empty(self):
        return (len(self.stack) == 0)  # Check if the stack is empty

    def size(self):
        return len(self.stack)  # Return the size of the stack

    def display(self):
        print(self.stack)  # Print the entire stack

# Example usage:
stack = Stack()
stack.push(10)
stack.push(20)
stack.push(30)
stack.display()  # Output: [10, 20, 30]

print("Top item is:", stack.peek())  # Output: 30
stack.pop()
stack.display()  # Output: [10, 20]
