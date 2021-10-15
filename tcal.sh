#!/bin/bash

tmux new-session -e COMPOSE_FILE=$HOME/Devel/calendar-compose.yml -d -s calendar -n docker -c $HOME/Devel
tmux new-window -n be-editor -c $HOME/Devel/calendar-api
tmux new-window -n be-misc -c $HOME/Devel/calendar-api
tmux new-window -n fe-editor -c $HOME/Devel/calendar-frontend
tmux new-window -n fe-misc -c $HOME/Devel/calendar-frontend
tmux select-window -t1

tmux attach-session -t calendar
