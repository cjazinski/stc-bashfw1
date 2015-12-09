# !/bin/bash
# A better then out of the box error handler
# Uncomment line #13 if you plan to use pushover

PROGNAME=$(basename $0)

error_exit() {
	echo -e "$(UI.Color.Red)$(UI.Color.Bold)\nEXIT HANDLER:$(UI.Color.Default)"
	echo -e "  $(UI.Color.Yellow)$(UI.Powerline.Cog)$(UI.Color.White) ${PROGNAME}: Error Line: ${BASH_LINENO}\n\t$(UI.Color.Magenta)${1:-"Unknown Error"}$(UI.Color.Default)\n" 1>&2
	# pushover "${PROGNAME}: ${1:-"Unknown Error"}"
	exit 1	
}