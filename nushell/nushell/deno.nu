# First check if deno bin is already in path
# if it is not, add it to path
# we also allow for local installs to override system installs
use std/util "path add"
let deno_path_exists = ($env.PATH | str join ":" | str contains ($env.HOME + "/.deno/bin"))
if not $deno_path_exists {
    path add ($env.HOME + "/.deno/bin")
}

