set -gx ANDROID_HOME $HOME/Android/Sdk

fish_add_path -p ~/fvm/default/bin
fish_add_path -p $ANDROID_HOME/cmdline-tools/latest/bin
fish_add_path -p $ANDROID_HOME/platform-tools

