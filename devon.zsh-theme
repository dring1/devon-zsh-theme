prompt_setup_devon() {
	ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[green]%}"
	ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
	ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$reset_color%}"
	ZSH_THEME_GIT_PROMPT_CLEAN=""

	# Calculate distance from home
	CURRENT_WORKING_DIR="%0~"

	base_prompt='%{$fg[green]%}%n%{$reset_color%}%{$fg[cyan]%}@%{$reset_color%}%{$fg[yellow]%}%m%{$reset_color%}%{$fg[red]%}:%{$reset_color%}%{$fg[cyan]%}${CURRENT_WORKING_DIR}%{$reset_color%}%{$fg[red]%}%{$reset_color%}'
	
	post_prompt='%{$fg[cyan]%}⇒%{$reset_color%} '

	base_prompt_nocolor=$(echo "$base_prompt" | perl -pe "s/%\{[^}]+\}//g")
	post_prompt_nocolor=$(echo "$post_prompt" | perl -pe "s/%\{[^}]+\}//g")

	precmd_functions+=(prompt_devon_precmd)
}

prompt_devon_precmd() {
	local gitinfo=$(git_prompt_info)
	local DATE="[%{$fg[green]%}%D{%y/%m/%f} | %D{%H:%M:%S}%{$reset_color%}]"
	local nl=""
	if [[ -n $gitinfo ]]; then
		gitinfo=" [${gitinfo}]"
	fi
	nl=$'\n%{\r%}'
	PROMPT="$base_prompt$gitinfo$nl$post_prompt"
	RPROMPT="${DATE}"
}

prompt_setup_devon
