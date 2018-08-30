set hilite (which highlight)
set -x LESSOPEN "| $hilite %s --out-format truecolor --style=moria --quiet --force "
set -x LESS " -R"
