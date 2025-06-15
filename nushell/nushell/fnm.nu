if (which fnm | is-not-empty) {
    ^fnm env --version-file-strategy=recursive --json | from json | load-env
    $env.PATH = ($env.PATH | prepend [
	(match $nu.os-info.name { "windows" => $env.FNM_MULTISHELL_PATH, _ => $"($env.FNM_MULTISHELL_PATH)/bin" })
    ])
    $env.config = ($env.config | merge {
	hooks: {
	    env_change: {
		PWD: [{ fnm use --silent-if-unchanged --install-if-missing }]
            }
        }
    })
}
