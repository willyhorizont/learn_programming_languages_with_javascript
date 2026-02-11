import sys
import random

lorem_ipsum_string_prefix = "Lorem ipsum dolor sit amet consectetur adipiscing elit"
lorem_ipsum_string = "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"
lorem_ipsum_prefix_words = lorem_ipsum_string_prefix.split(" ")
lorem_ipsum_words = lorem_ipsum_string.split(" ")


def choose_lorem_ipsum_words():
    def choose_lorem_ipsum_words_inner(previous_word=None):
        current_word = random.choice(lorem_ipsum_words)
        if current_word != previous_word:
            return current_word
        choose_lorem_ipsum_words_inner(current_word)
    return choose_lorem_ipsum_words_inner()


def lorem(word_amount, prefix=True):
    lorem_ipsum_string_prefix_word_amoun = len(lorem_ipsum_prefix_words)
    if word_amount <= lorem_ipsum_string_prefix_word_amoun:
        return " ".join(lorem_ipsum_prefix_words[0:word_amount])
    new_rest = " ".join([choose_lorem_ipsum_words() for _ in range(0, (word_amount - lorem_ipsum_string_prefix_word_amoun))])
    rest = new_rest if (new_rest[-1] == "." or new_rest[-1] == "?") else (new_rest[:-2] + ".") if (new_rest[-1] == ",") else (new_rest + ".")
    rest = rest[0].upper() + rest[1:]
    if prefix == False:
        return rest
    return " ".join(lorem_ipsum_prefix_words[0:lorem_ipsum_string_prefix_word_amoun]) + ". " + rest


def main():
    if (len(sys.argv) == 2):
        return lorem(int(sys.argv[1]))
    if (len(sys.argv) == 3):
        return lorem(int(sys.argv[1]), False)
    return ""


if __name__ == "__main__":
    print(main())
