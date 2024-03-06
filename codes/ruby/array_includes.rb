print("\n", "# JavaScript-like Array.includes() in Ruby")

print("\n", "# using Ruby Array.includes() built-in method \"include?\"")

my_friends = ["Alisa", "Trivia"]
print("\n", "my friends: ", my_friends)

name = "Alisa"
print("\n", "name: \"#{name}\"")
is_my_friend = my_friends.include?(name)
print("\n", "# is my friend includes: \"#{name}\": #{is_my_friend}")
# is my friends includes "Alisa": true

name = "Trivia"
print("\n", "name: \"#{name}\"")
is_my_friend = my_friends.include?(name)
print("\n", "# is my friend includes: \"#{name}\": #{is_my_friend}")
# is my friends includes "Trivia": true

name = "Tony"
print("\n", "name: \"#{name}\"")
is_my_friend = my_friends.include?(name)
print("\n", "# is my friend includes: \"#{name}\": #{is_my_friend}")
# is my friends includes "Tony": true

name = "Ezekiel"
print("\n", "name: \"#{name}\"")
is_my_friend = my_friends.include?(name)
print("\n", "# is my friend includes: \"#{name}\": #{is_my_friend}")
# is my friends includes "Ezekiel": true
