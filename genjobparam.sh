command -v groovy >/dev/null 2>&1 || { echo "Groovy not installed. Aborting." >&2; exit 1;}
groovy genjobparam
