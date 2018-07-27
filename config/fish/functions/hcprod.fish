# Defined in - @ line 0
function hcprod --description 'alias hcprod heroku run console -r production'
	heroku run console -r production $argv;
end
