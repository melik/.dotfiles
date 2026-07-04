black=$'\e[30m';
red=$'\e[31m';
green=$'\e[32m';
yellow=$'\e[33m';
blue=$'\e[34m';
purple=$'\e[35m';
cyan=$'\e[36m';
gray=$'\e[37m';
reset=$'\e[0m';

# Prompt [Directory with install.sh]* [Name for prompt]* [Verb for name]
prompt_and_do() {
    local dir="$1";
    local name="$2";
    local verb="$3";

    if [ -z "$verb" ]; then
        verb="update"
    fi;

    read -p "${yellow}This will ${verb} ${name}. Are you sure? (Y/n):${reset} " -r -s -n 1 key;
    if [[ $key =~ ^[Yy]$ || $key = "" ]]; then
        echo "${gray}\nYes. Go!${reset}";

        sh "./${dir}/install.sh";
    else
        echo "${gray}\nNo${reset}";
    fi;
}
