# launch nvim in a loop until nvim exits with a non-zero exit code (:cq).
# useful when you want to make changes to nvim config and quickly restart nvim.
# this is easier if you use auto-session.
while true; do
    chezmoi apply
    nvim
    if [ $? -ne 0 ]; then
        break
    fi
done
