#
# This shell prompt config file was created by promptline.vim
#

function __promptline_last_exit_code {

  if [[ $last_exit_code -gt 0 ]]; then
    printf "%s" "☹  = $last_exit_code"
  else
    printf "%s" "☻ ";
  fi
}
function __promptline_ps1 {
  local slice_prefix slice_empty_prefix slice_joiner slice_suffix is_prompt_empty=1

  # section "a" header
  slice_prefix="${a_bg}${sep}${a_fg}${a_bg}${space}" slice_suffix="$space${a_sep_fg}" slice_joiner="${a_fg}${a_bg}${alt_sep}${space}" slice_empty_prefix="${a_fg}${a_bg}${space}"
  [ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
  # section "a" slices
  __promptline_wrapper "\t" "$slice_prefix" "$slice_suffix" && { slice_prefix="$slice_joiner"; is_prompt_empty=0; }

  # section "b" header
  slice_prefix="${b_bg}${sep}${b_fg}${b_bg}${space}" slice_suffix="$space${b_sep_fg}" slice_joiner="${b_fg}${b_bg}${alt_sep}${space}" slice_empty_prefix="${b_fg}${b_bg}${space}"
  [ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
  # section "b" slices
  __promptline_wrapper "$(__promptline_vcs_branch)" "$slice_prefix" "$slice_suffix" && { slice_prefix="$slice_joiner"; is_prompt_empty=0; }

  # section "c" header
  slice_prefix="${c_bg}${sep}${c_fg}${c_bg}${space}" slice_suffix="$space${c_sep_fg}" slice_joiner="${c_fg}${c_bg}${alt_sep}${space}" slice_empty_prefix="${c_fg}${c_bg}${space}"
  [ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
  # section "c" slices
  __promptline_wrapper "\u@\h" "$slice_prefix" "$slice_suffix" && { slice_prefix="$slice_joiner"; is_prompt_empty=0; }

  # section "x" header
  slice_prefix="${x_bg}${sep}${x_fg}${x_bg}${space}" slice_suffix="$space${x_sep_fg}" slice_joiner="${x_fg}${x_bg}${alt_sep}${space}" slice_empty_prefix="${x_fg}${x_bg}${space}"
  [ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
  # section "x" slices
  __promptline_wrapper "$(__promptline_cwd)" "$slice_prefix" "$slice_suffix" && { slice_prefix="$slice_joiner"; is_prompt_empty=0; }

  # section "warn" header
  slice_prefix="${warn_bg}${sep}${warn_fg}${warn_bg}${space}" slice_suffix="$space${warn_sep_fg}" slice_joiner="${warn_fg}${warn_bg}${alt_sep}${space}" slice_empty_prefix="${warn_fg}${warn_bg}${space}"
  [ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
  # section "warn" slices
  __promptline_wrapper "$(__promptline_jobs)" "$slice_prefix" "$slice_suffix" && { slice_prefix="$slice_joiner"; is_prompt_empty=0; }
  __promptline_wrapper "$(__promptline_last_exit_code)" "$slice_prefix" "$slice_suffix" && { slice_prefix="$slice_joiner"; is_prompt_empty=0; }

  # close sections
  printf "%s" "${reset_bg}${sep}$reset$space"
}
function __promptline_vcs_branch {
  local branch
  local branch_symbol=" "

  # git
  if hash git 2>/dev/null; then
    if branch=$( { git symbolic-ref --quiet HEAD || git rev-parse --short HEAD; } 2>/dev/null ); then
      branch=${branch##*/}
      printf "%s" "${branch_symbol}${branch:-unknown}"
      return
    fi
  fi
  return 1
}
function __promptline_cwd {
  local cwd="${PWD/#$HOME/~}"
  local dir_limit=7
  local parts
  local dir_sep="  "
  local truncation="⋯"

  # get first char of the path, i.e. tilda or slash
  if [[ -n ${ZSH_VERSION-} ]]; then
    local root_char=$cwd[1,1]
  else
    local root_char=${cwd::1}
  fi

  # cleanup leading tilda and slash. replace slashes with spaces
  cwd="${cwd#\~}"
  cwd="${cwd#\/}"
  cwd=${cwd//\// }

  if [[ -n ${ZSH_VERSION-} ]]; then
    parts=($root_char ${=cwd})
  else
    parts=($root_char $cwd)
  fi

  # truncate dirs to the limit
  local parts_count=${#parts[@]}
  if [ $parts_count -gt $dir_limit ] && [ $dir_limit -gt -0 ]; then
    parts=($truncation ${parts[@]:(-3)})
  fi

  # join the dirs with the separator
  local formatted_cwd=""
  for part in "${parts[@]}"; do
    formatted_cwd="$formatted_cwd$dir_sep$part"
  done;
  formatted_cwd="${formatted_cwd#$dir_sep}"

  printf "%s" "$formatted_cwd"
}
function __promptline_left_prompt {
  local slice_prefix slice_empty_prefix slice_joiner slice_suffix is_prompt_empty=1

  # section "a" header
  slice_prefix="${a_bg}${sep}${a_fg}${a_bg}${space}" slice_suffix="$space${a_sep_fg}" slice_joiner="${a_fg}${a_bg}${alt_sep}${space}" slice_empty_prefix="${a_fg}${a_bg}${space}"
  [ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
  # section "a" slices
  __promptline_wrapper "\t" "$slice_prefix" "$slice_suffix" && { slice_prefix="$slice_joiner"; is_prompt_empty=0; }

  # section "b" header
  slice_prefix="${b_bg}${sep}${b_fg}${b_bg}${space}" slice_suffix="$space${b_sep_fg}" slice_joiner="${b_fg}${b_bg}${alt_sep}${space}" slice_empty_prefix="${b_fg}${b_bg}${space}"
  [ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
  # section "b" slices
  __promptline_wrapper "$(__promptline_vcs_branch)" "$slice_prefix" "$slice_suffix" && { slice_prefix="$slice_joiner"; is_prompt_empty=0; }

  # section "c" header
  slice_prefix="${c_bg}${sep}${c_fg}${c_bg}${space}" slice_suffix="$space${c_sep_fg}" slice_joiner="${c_fg}${c_bg}${alt_sep}${space}" slice_empty_prefix="${c_fg}${c_bg}${space}"
  [ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
  # section "c" slices
  __promptline_wrapper "\u@\h" "$slice_prefix" "$slice_suffix" && { slice_prefix="$slice_joiner"; is_prompt_empty=0; }

  # close sections
  printf "%s" "${reset_bg}${sep}$reset$space"
}
function __promptline_wrapper {
  # wrap the text in $1 with $2 and $3, only if $1 is not empty
  # $2 and $3 typically contain non-content-text, like color escape codes and separators

  [[ -n "$1" ]] || return 1
  printf "%s" "${2}${1}${3}"
}
function __promptline_right_prompt {
  local slice_prefix slice_empty_prefix slice_joiner slice_suffix

  # section "warn" header
  slice_prefix="${warn_sep_fg}${rsep}${warn_fg}${warn_bg}${space}" slice_suffix="$space${warn_sep_fg}" slice_joiner="${warn_fg}${warn_bg}${alt_rsep}${space}" slice_empty_prefix=""
  # section "warn" slices
  __promptline_wrapper "$(__promptline_jobs)" "$slice_prefix" "$slice_suffix" && { slice_prefix="$slice_joiner"; }
  __promptline_wrapper "$(__promptline_last_exit_code)" "$slice_prefix" "$slice_suffix" && { slice_prefix="$slice_joiner"; }

  # section "x" header
  slice_prefix="${x_sep_fg}${rsep}${x_fg}${x_bg}${space}" slice_suffix="$space${x_sep_fg}" slice_joiner="${x_fg}${x_bg}${alt_rsep}${space}" slice_empty_prefix=""
  # section "x" slices
  __promptline_wrapper "$(__promptline_cwd)" "$slice_prefix" "$slice_suffix" && { slice_prefix="$slice_joiner"; }

  # close sections
  printf "%s" "$reset"
}

function __promptline_jobs {
  local job_count=0

  local IFS=$'\n'
  for job in $(jobs); do
    # count only lines starting with [
    if [[ $job == \[* ]]; then
      job_count=$(($job_count+1))
    fi
  done

  [[ $job_count -gt 0 ]] || return 1;
  printf "%s" "$job_count"
}
function __promptline {
  local last_exit_code="$?"

  local esc=$'[' end_esc=m
  if [[ -n ${ZSH_VERSION-} ]]; then
    local noprint='%{' end_noprint='%}'
  else
    local noprint='\[' end_noprint='\]'
  fi
  local wrap="$noprint$esc" end_wrap="$end_esc$end_noprint"
  local space=" "
  local sep=""
  local rsep=""
  local alt_sep=""
  local alt_rsep=""
  local reset="${wrap}0${end_wrap}"
  local reset_bg="${wrap}49${end_wrap}"
  local a_fg="${wrap}38;5;220${end_wrap}"
  local a_bg="${wrap}48;5;166${end_wrap}"
  local a_sep_fg="${wrap}38;5;166${end_wrap}"
  local b_fg="${wrap}38;5;231${end_wrap}"
  local b_bg="${wrap}48;5;31${end_wrap}"
  local b_sep_fg="${wrap}38;5;31${end_wrap}"
  local c_fg="${wrap}38;5;250${end_wrap}"
  local c_bg="${wrap}48;5;240${end_wrap}"
  local c_sep_fg="${wrap}38;5;240${end_wrap}"
  local warn_fg="${wrap}38;5;231${end_wrap}"
  local warn_bg="${wrap}48;5;52${end_wrap}"
  local warn_sep_fg="${wrap}38;5;52${end_wrap}"
  local x_fg="${wrap}38;5;250${end_wrap}"
  local x_bg="${wrap}48;5;236${end_wrap}"
  local x_sep_fg="${wrap}38;5;236${end_wrap}"
  if [[ -n ${ZSH_VERSION-} ]]; then
    PROMPT="$(__promptline_left_prompt)"
    RPROMPT="$(__promptline_right_prompt)"
  else
    PS1="\n$(__promptline_ps1)"
  fi
}

if [[ -n ${ZSH_VERSION-} ]]; then
  if [[ ! ${precmd_functions[(r)__promptline]} == __promptline ]]; then
    precmd_functions+=(__promptline)
  fi
else
  PROMPT_COMMAND=__promptline
fi
