# cc-errorlib
errorlib is a library for ComputerCraft that allows for better handling fo shutdowns, errors, and more!

# Documentation
List of functions:

exception(severity, message, position)
  Parameters
  1. severity : **number** the severity of the error. 0 is a warning, 1 is an error, 2 is an error that casues program to terminate, 3 is an error that causes computer to shutdown.
  2. message  : **string** the error message you want to display to the screen
  3. position : **number** the line on which you want to print the error

timedShutdown(time, position)
  Parameters
  1. time     : **number** the amount of time until shutdown
  2. position : **number** the line on which you want to print the shutdown timer
    
  Returns
  1. false if time is above 100
