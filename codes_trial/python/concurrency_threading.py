import threading

def function1():
    for i in range(50):
        print("Function 1 is running")

def function2():
    for i in range(5):
        print("Function 2 is running")

# Create threads
thread1 = threading.Thread(target=function1)
thread2 = threading.Thread(target=function2)

# Start threads
thread1.start()
thread2.start()

# Wait for both threads to finish
thread1.join()
thread2.join()

print("Both functions have finished")
