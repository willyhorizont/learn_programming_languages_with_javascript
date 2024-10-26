from collections import deque

class Stack:
    def __init__(self):
        self.stack = deque()

    def push(self, item):
        self.stack.append(item)

    def pop(self):
        if (self.is_empty() == False):
            return self.stack.pop()
        return None

    def peek(self):
        if (self.is_empty() == False):
            return self.stack[-1]
        return None

    def is_empty(self):
        return (len(self.stack) == 0)

    def size(self):
        return len(self.stack)

    def display(self):
        print(list(self.stack))  # Convert deque to list for display

# Example usage:
stack = Stack()
stack.push(10)
stack.push(20)
stack.push(30)
stack.display()  # Output: [10, 20, 30]

print("Top item is:", stack.peek())  # Output: 30
stack.pop()
stack.display()  # Output: [10, 20]
