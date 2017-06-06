cat("What's your name: ")

name<- readLines("stdin",n=1)

if (name == "Uros")
{
  print("What's up dude!?")
} else {
  print(paste("Hello Mr/Mrs ", name,":)", sep=""))
}