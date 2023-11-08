print("\n# JavaScript-like Array.includes() in Ruby")

my_friends = ["Alisa", "Trivia"]
print("\nmy friends: ", my_friends)

name = "Alisa"
print("\nname: \"#{name}\"")
is_my_friend = my_friends.include?(name)
print("\n# is my friend includes: \"#{name}\": #{is_my_friend}")
# is my friends includes "Alisa": true

name = "Trivia"
print("\nname: \"#{name}\"")
is_my_friend = my_friends.include?(name)
print("\n# is my friend includes: \"#{name}\": #{is_my_friend}")
# is my friends includes "Trivia": true

name = "Tony"
print("\nname: \"#{name}\"")
is_my_friend = my_friends.include?(name)
print("\n# is my friend includes: \"#{name}\": #{is_my_friend}")
# is my friends includes "Tony": true

name = "Ezekiel"
print("\nname: \"#{name}\"")
is_my_friend = my_friends.include?(name)
print("\n# is my friend includes: \"#{name}\": #{is_my_friend}")
# is my friends includes "Ezekiel": true
