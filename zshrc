#
# Ingelmo's bash smashin              _///_,  
# Zsh console                        / ` ' '>
#                                   ఠ'  __/_'>    
#                                  /  _/  )_\'>i    
#                                 (^(_/   /_/\_>   
#                               ,/|   ____/_/_/_/    <- Zsh
#                             ,//('  /,---, _/ / 
#                           ( ( ')  ""  /_/_/_/
#                         -)) )) (     /_(_(_(_                 \
#                       ,/,'//( (     (   \_\_\\_               )\
#                     ,( ( ((, )       \'__\_\_\_\__            )0\
#                    ~/  )` ) /        //____|___\__)           )_/2
#                  _-~//( )/ )         |  _  \'___'_(           /'4
#                  '( ')/ ,(/           \_ (-'\'___'_\      __,'_'
#                   '                 __) \  \\___(_   __/.__,'
#  Bash ->   .-"--.ಠ,ಠ             ,((,-,__\  '", __\_/. __,'
#           '->>>--'﹏          ---------------'"./_._._-'--
#             `  `         -----------------------------------
#-----------------------------------------------------------------       

# New session summary
if [[ -o interactive ]]; then
  
    local key_color='[38;5;117m'
    local value_color='[38;5;189m'

    uptime=$(uptime 2>/dev/null | awk '{print $3 " " $4}' | cut -d"," -f1)     
    loadAverages=$(uptime 2>/dev/null | awk '{print $(NF-2) " " $(NF-1) " " $(NF) }')
    longDate=$(date "+%a, %b %_d %Y @[00m ${value_color}%I:%M %p (%Z %z)")
    
    print "${key_color}Host[00m ${value_color}$HOST[00m ${key_color}up for[00m ${value_color}$uptime"
    print "${key_color}Date[00m ${value_color}$longDate[00m"
    print "${key_color}Load[00m ${value_color}$loadAverages[00m"
fi

# ZSH Options
setopt APPEND_HISTORY               # append to history file
setopt INC_APPEND_HISTORY           # append to history file incrementally, as commands are typed in 
setopt CORRECT                      # spelling correction... >pee /foofolder ... did you mean pe?
setopt HIST_REDUCE_BLANKS           # remove useless blanks from history
setopt NO_BEEP                      # don't beep 
setopt AUTO_CD                      # cd into directories by just typing them out, ex: /foo intead of cd /foo
setopt AUTO_PUSHD                   # automatically call pushd on call to cd
setopt PUSHD_IGNORE_DUPS            # don't add dupes to the pushd stack
setopt HIST_IGNORE_ALL_DUPS         # ignore dupes
setopt EXTENDED_GLOB                # adds 3 more glob characters (#,~,^), ex: to exclude .c files ^*.c, 
setopt RM_STAR_WAIT                 # confirm before executing rm *, sanity check
unsetopt CASE_GLOB                  # make globbing case insensitive by default

# Completion system (copy pasta from the internet)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'
zstyle ':completion:*:corrections' format "- %d - (errors %e})"
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes
zstyle ':completion:*' list-dirs-first true                 # Separate directories from files.
zstyle ':vcs_info:*' enable git cvs svn                     # Only enable version control info for the 3 big ones

autoload -Uz compinit
autoload -Uz vcs_info
compinit

# Custom keybindings. These enable ctrl-arrow, ctrl-backspace, & ctrl-del
# Hit ctrl-v at the command line and then any key to see the control code 
bindkey "^[[1;5D" backward-word	                    # ctrl-leftarrow jump backward word for iTerm
bindkey "^[[1;5C" forward-word	                    # ctrl-rightarrow jump forward word for iTerm
bindkey "^[[5D" backward-word	                    # ctrl-leftarrow jump backward word for Terminal
bindkey "^[[5C" forward-word	                    # ctrl-rightarrow jump forward word for Terminal
bindkey "^[[3~" delete-char                         # delete key
bindkey '^R'    history-incremental-search-backward # ctrl -R search history
bindkey "^[[A"  up-line-or-search                   # up arrow go through history
bindkey "^[[B"  down-line-or-search                 # down arrow go through history
bindkey "\ed"   delete-word                         # esc d is only used when mapping ctrl-del in iTerm
bindkey "\ez"   backward-delete-word                # esc z is only used when mapping ctrl-back in iTerm

# Environment variables. Use printenv to print all terminal variables, unset to delete one
export HISTFILE="$HOME/.history"            # history file path
export HISTSIZE=500                         # number of history lines to keep in memory
export SAVEHIST=500                         # number of history lines to keep on disk
export LC_CTYPE=en_US.UTF-8                 # so SVN doesn't shit itself on non-ascii files
export WORDCHARS='*?_[]~=&;!#$%^(){}'       # Remove slash, period, angle brackets and dash from valid word characters
                                            # This allows delete-word (ctrl-w) to delete a piece of a path,
                                            # and ctrl-arrow to jumps between parts of a path

# Custom less behaviors. 
# X prevents less from clearing screen on quit
# -P customizes prompt to ex: .zshrc lines 1-47/228 20%
# -R print control chacters, allows colors to flow through less
export LESS="X -R -P ?f%f .?n?m(file %i of %m) ..?ltlines %lt-%lb?L/%L. :
            byte %bB?s/%s. .?e(END) ?x- Next\: %x.:?pB%pB\%..%t"  

# Environment variables for colored man pages, escape code syntax below
export LESS_TERMCAP_ti=$'\E[01;37m'         # white         
export LESS_TERMCAP_mb=$'[38;5;117m'      # light blue    [0m 
export LESS_TERMCAP_md=$'[38;5;117m'      # light blue    [0m 
export LESS_TERMCAP_me=$'\E[0m'             # color reset   
export LESS_TERMCAP_us=$'\E[01;33m'         # yellow        
export LESS_TERMCAP_ue=$'\E[0m'             # color reset 

# Environment variables for printing process stats if a command takes > n seconds
export REPORTTIME=1
export TIMEFMT='
> %J
  | Time:   [38;5;159m%E[0m total time, %U user time, %S kernel time
  | Disk:   [38;5;159m%F[0m major page faults (pages loaded from disk)  
  | System: [38;5;159m%P[0m max CPU used, [38;5;159m%M[0m KB max memory used'

# Useful zsh functions and modules
autoload -U colors && colors    # zsh function that loads colors w/ names into 'fg' & 'bg' arrays
autoload zcalc                  # calculator
autoload zmv                    # zsh batch file renamer ex: zmv '(*).txt' '$1.md'

grepr() {grep -iIr --color "$1" *}  # grep recursive(r), ignore case (i), ignore binary files(I). ex: grepr searchstring

# Command aliases for different systems (Darwin == Mac)
if [[ `uname` == "Darwin" ]] then
    # if the command gls exists, gls is part of the GNU standard version of ls that can be installed on a Mac (brew install coreutils)
    # the 'g' prefix is added by homebrew to avoid naming collisions, gls, gcat etc...
    if (( $+commands[gls] )) ; then
        # remove date entirely for day-to-day usage
        alias ls='gls -AlFh --color --time-style="+[38;5;100m—[00m" --group-directories-first'                            
        # use English sentence style date when needed ex: [Tue, Jan 11 2011 @ 11:01 am]
        # format specifiers @ http://www.gnu.org/software/coreutils/manual/html_node/date-invocation.html#date-invocation 
        alias lsd='gls -AlFh --color --time-style="+[%a, %b %_d %Y @ %l:%M %P]" --group-directories-first; echo Today is `date "+%a, %b %_d %Y @ %l:%M %p"`'  
    else
        alias ls='ls -AlFhg'
    fi
else
    # assume GNU ls is available
    alias ls='ls -AlFh --color --time-style="+—" --group-directories-first'                                 
    alias lsd='ls -AlFh --color --time-style="+[%a, %b %_d %Y @ %l:%M %P]" --group-directories-first'   
fi

# custom prompt
# %{ ... %} tells zsh to disregard the contained characters when calculating the length of the prompt (in order correctly position the cursor)
local p_ret_status="%{$fg[white]%}%?%{$reset_color%}"   # last command return code
local p_delim="%{$fg[red]%}>%{$reset_color%}"           # > as a delimiter

# If .zshrc.local exists include it. It's should contain system 
# specific settings such as aliases, exports, a custom $PATH, etc...
if [[ -e "$HOME/.zshrc.local" ]] then
    source $HOME/.zshrc.local
fi

# Pastel-ish colors for GNU LS_COLORS
# di=directory (blue), ln=sym link (coral), ex=executable (orange)
export LS_COLORS='di=38;5;110:ln=38;5;175:ex=38;5;166'

# Dynamic prompt customization point, precmd gets called just before every command prompt
function precmd {
    vcs_info

    # current working dir
    local p_cwd="%{[38;5;180m%}$PWD%{$reset_color%}"        
    
    # if $EUID is zero then we're running as root,
    # change the color of the username from purple to red
    if [ $EUID -eq 0 ]; then
        local USER_COLOR='[01;38;5;124m'
    else
        local USER_COLOR='[38;5;146m'
    fi

    # p_hostname is defined in .zshrc.local It's useful for creating a friendly 
    # name in our prompt when we can't actually edit the hostname 
    if [[ -z "$p_hostName" ]]; then
        local p_user_at_host="%{$USER_COLOR%}%B%n%b@%m%{$reset_color%}" 
        printf "\e]1;$HOST\a"
    else
        local p_user_at_host="%{$USER_COLOR%}%B%n%b@$p_hostName%{$reset_color%}" 
        printf "\e]1;$p_hostName\a"
    fi
        
    if [[ -n "$vcs_info_msg_0_" ]]; then
        local vcs="%{[38;5;180m%}${vcs_info_msg_0_}%{$reset_color%}"
    fi

    PROMPT="${p_cwd}${vcs}
${p_user_at_host} [${p_ret_status}] ${p_delim} "

}

# Badass ZSH script that adds live syntax highlighting to command arguments
# https://github.com/zsh-users/zsh-syntax-highlighting 
if [[ -e "$HOME/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] then
    source $HOME/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

    # enable colored braces/parens & custom patterns, great when using zcalc
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

    # change the zsh-highlighing default colors
    ZSH_HIGHLIGHT_STYLES[globbing]='fg=blue,bold'
    ZSH_HIGHLIGHT_STYLES[path]='bold'
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=cyan'
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=cyan'
fi

# ESC '  Quote the current line; that is, put a `'' character at the beginning and the end, and convert all `'' characters to `'\'''  
# ^ a    Move to beginnging of line
# ^ e    Move to end of line
# ^ xf   Move to next typed character
# ESC U  Uppercase a word
# ESC c  Uppercase a character
# ^ l    Clear screen
# ^ @    Set Mark

# The 256 color escape code syntax
# The #'s noted are adjustable, everything else must remain untouched
# Once a color is set it must be unset using ^[[00
# http://lucentbeing.com/blog/that-256-color-thing/
#
# print '[01;38;05;50;48;05;100m poop [00'  don't forget the m...
#        |/ |/       |/       |/___________ dark yellow background color (100)
#        |  |        |_____________________ aqua foreground color (50)
#        |  |______________________________ bold text attribute (01) 
#        |_________________________________ hit ctrl-v then esc to start escape sequence*
#
# * In most cases the escape sequence can also be written as \E or \033, but you must
#   enable backslash escapes for that to work.
#
# Shortcut to change just the foreground to aqua (50)
# print '[38;05;50m poop [00 '
# 
# text attributes
#   0=RESET     1=BOLD              4=underline 24=not underline, 
#   5=blinking  25=notblinking      7=inverse   27=notinverse    
#   22=not bold
# 
# colors
#   1-255    
