# this is a single line comment

# this
# is
# a
# multi
# line
# comment

cat((function() {
    # multiline comment
    if (FALSE) {
        return('#
this
is
a
multi
line
comment
workaround
        #')
    }
    return("")
})())
