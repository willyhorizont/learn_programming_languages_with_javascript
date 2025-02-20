println("# Immediately Invoked Function Expression (IIFE) in Julia")
println("# a Self-Executing Anonymous Function that runs as soon as it is defined")
println("# https://developer.mozilla.org/en-US/docs/Glossary/IIFE")

(function ()
    println("# self-executing after defined")
end)()

(() -> begin
    println("# self-executing after defined")
end)()

(() -> println("# self-executing after defined"))()
