#!/bin/bash
set -e  # exit on first error
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

APP_NAME="v2ray_client"
CONF_DIR="/etc/supervisor/conf.d"  # supervisor configuration file directory
CONF="$APP_NAME.conf"
main()
{
    create_config_for_app
}

create_config_for_app()
{
    cd $CURRENT_DIR
    ## create supervisor configuration file for the app
    touch "$CONF"
    # write lines
    echo "[program:$APP_NAME]" > $CONF
    echo "directory = $SCRIPT_DIR" >> $CONF
    echo "command = /usr/bin/v2ray/v2ray -config /etc/v2ray/config.json" >> $CONF
    echo "autostart = true" >> $CONF
    echo "autorestart = true" >> $CONF
    echo "stderr_logfile = /var/log/$APP_NAME.err.log" >> $CONF
    echo "stdout_logfile = /var/log/$APP_NAME.out.log" >> $CONF
    # change the permission of the file
    sudo chmod a+x $CONF
    # enable the app in supervisor
    sudo mv $CONF $CONF_DIR
    # read the supervisor configuration file
    sudo supervisorctl reread
    # update the programs run by the supervisor
    sudo supervisorctl update
}

main
