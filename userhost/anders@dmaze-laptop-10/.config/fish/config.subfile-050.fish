set -gx ANDROID_HOME $HOME/Android/Sdk
set -gx ANDROID_AVD_HOME $HOME/.config/.android/avd

fish_add_path -p ~/fvm/default/bin
fish_add_path -p $ANDROID_HOME/cmdline-tools/latest/bin
fish_add_path -p $ANDROID_HOME/platform-tools

