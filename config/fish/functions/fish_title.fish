function fish_title \
    --description "Set title to current folder and shell name" \
    --argument-names last_command

    set --local basename (string replace -r '^.*/' '' -- $PWD)
    set --local current_folder (_pure_parse_directory)
    set --local current_command (status current-command 2>/dev/null; or echo $_)

    # set --local prompt "$basename: $last_command $pure_symbol_title_bar_separator $current_command"
    set --local prompt "$basename: $current_command"

    if test -z "$last_command"
      if test "$current_command" = "fish"
        set prompt "$current_folder"
      else
        set prompt "$current_folder $pure_symbol_title_bar_separator $current_command"
      end
    end

    echo $prompt
end
