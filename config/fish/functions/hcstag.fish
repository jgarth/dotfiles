# Defined in - @ line 0
function hcstag --description 'alias hcstag heroku run console -r staging'
	heroku run console -r staging $argv;
end
