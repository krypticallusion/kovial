function hostname
  printf '%s[%s]%s' (set_color -o green) $hostname (set_color normal)
end

function user 
  printf '%s%s%s' (set_color -o green) $USER (set_color normal)
end

function custom_prompt_pwd
  set -g fish_prompt_pwd_dir_length 0
  printf '%s%s%s' (set_color -o red) (prompt_pwd) (set_color normal)
end

function git_branch
  set -g __fish_git_prompt_show_informative_status true
  set -g __fish_git_prompt_char_untrackedfiles ''
  set -g __fish_git_prompt_char_stateseparator ' '
  set -g __fish_git_prompt_char_upstream_prefix ' '
  set -g __fish_git_prompt_color -o blue
  set -g __fish_git_prompt_showcolorhints true

  if [ (fish_git_prompt) ]
    printf 'on%s%s' (fish_vcs_prompt) (set_color normal)
  else
    printf ' '
  end 
end

function arrow
  argparse f s -- $argv
  or return # exit if argparse failed because it found an option it didn't recognize - it will print an error


  if set -q _flag_f 
    printf '┌──'
  else if set -q _flag_s 
    printf '└──▶ '
  end
end

function fish_prompt
  printf '%s%s as %s in %s %s\n%s' (arrow -f) (hostname) (user) (custom_prompt_pwd) (git_branch) (arrow -s)
end
 