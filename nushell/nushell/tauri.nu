$env.JAVA_HOME = $env.HOME + "/.local/share/JetBrains/Toolbox/apps/android-studio/jbr"
$env.ANDROID_HOME = $env.HOME | path join Android Sdk
$env.NDK_HOME = $env.ANDROID_HOME | path join ndk ($env.ANDROID_HOME | path join 'ndk' | ls ($env.ANDROID_HOME | path join ndk) | get name | sort -n | last)
