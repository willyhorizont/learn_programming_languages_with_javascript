print("\n", "# JavaScript-like Array.includes() in Ruby")

print("\n", "# using Ruby Array.includes() built-in method \"include?\"")

my_friends = ["Alisa", "Trivia"]
print("\n", "my friends: ", JSON.generate(my_friends).gsub(",", ", "))

a_name = "Alisa"
is_my_friend = my_friends.include?(a_name)
print("\n", "# is my friend includes: \"#{a_name}\": #{is_my_friend}")
# is my friends includes "Alisa": true

a_name = "Trivia"
is_my_friend = my_friends.include?(a_name)
print("\n", "# is my friend includes: \"#{a_name}\": #{is_my_friend}")
# is my friends includes "Trivia": true

a_name = "Tony"
is_my_friend = my_friends.include?(a_name)
print("\n", "# is my friend includes: \"#{a_name}\": #{is_my_friend}")
# is my friends includes "Tony": true

a_name = "Ezekiel"
is_my_friend = my_friends.include?(a_name)
print("\n", "# is my friend includes: \"#{a_name}\": #{is_my_friend}")
# is my friends includes "Ezekiel": true
