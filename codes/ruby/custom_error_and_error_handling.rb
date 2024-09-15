print("\n", "# Custom Error and Error Handling in Ruby")

def give_me_respect(argument)
    # Custom Error
    raise StandardError.new("Error: You should give me \"respect\"!") if (argument != "respect")
    return "Thank you for giving me \"respect\"!"
end

# Error Handling
begin
    response = give_me_respect("boo!")
    print("\n", response)
rescue StandardError => an_error
    print("\n", an_error.message)
end
print("\n", "I'm sorry!")

# Without Error Handling
response = give_me_respect("boo!")
# this will never executed
print("\n", response)
print("\n", "I'm sorry!")
