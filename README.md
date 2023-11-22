# Handle
Handle is a library for ComputerCraft that allows for better handling of shutdowns, errors, and more!

# Documentation
List of functions:

# log(message, type)
  Parameters
  1. message : **string** the message you want to appear in the log
  2. type    : **number** the type of the info tag in the log. 0 is for INFO, 1 is for WARN, 2 is for ERROR, 3 is for FATAL, 4 is for !FATAL.

  writes to a log in this format: TIME: [INFO TAG] message

  INFOTAG meanings:   INFO is for general info, WARN is for warnings, ERROR is for recoverable errors, FATAL is for unrecoverable errors, !FATAL is for errors that are severe enough to warrant a scomputer shutdown 
 
  NOTE: IT IS GOOD PRACTICE TO USE exception() WHEN LOGGING ANYTHING THAT IS AN ERROR, this should only be used directly when writing data of type INFO to the log!

# exception(severity, message, position)
  
  Parameters
  1. severity : **number** the severity of the error. 0 is a warning, 1 is an error, 2 is an error that casues program to terminate, 3 is an error that causes computer to shutdown.
  2. message  : **string** the error message you want to display to the screen
  3. position : **number** the line on which you want to print the error

  this will log an exception and do the appropriate error handling
  
# timedShutdown(time, position)
  
  Parameters
  1. time     : **number** the amount of time until shutdown
  2. position : **number** the line on which you want to print the shutdown timer
    
  Returns
  1. false if time is above 100
