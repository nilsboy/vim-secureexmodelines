Vim plugin to automatically run ex-commands from a file when starting to edit
it.

# Usage
Add a line like this at the top of your file:
`# vimex: DBSetOption profile=my_db_profile`

This calls the `DBSetOption` ex-command with the argument `profile=my_db_profile`.

The line has to match this regex:
`\v\svimex:\s([a-zA-Z0-9_=-]+)\s([a-zA-Z0-9_=-]+)`

For security reasons only this simple regex is allowed. If you want to do more
complicated things you should create a command and call that.

# Configuration

## Allowed commands
Set the global var `g:secure_exmodelines_allowed_items` to the commands you want
to allow:
`let g:secure_exmodelines_allowed_items = [ "DBSetOption", "SomeOtherCmd" ]`
default: []

## Debugging
To get info messages for debugging set:
`let g:secure_exmodelines_verbose = 1`

