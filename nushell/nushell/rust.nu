if ("~/.cargo/bin" not-in ($env.Path | split row (char esep))) {
  $env.Path = ($env.Path | prepend "~/.cargo/bin")
}
