#!/bin/bash
set -e  # exit on first error
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

APP_NAME="v2ray_client"
CONF_DIR="/etc/supervisor/conf.d"  # supervisor configuration file directory
CONF="$APP_NAME.conf"
main()
{
    install_dependencies
    #enable_supervisor_web_interface
    #create_config_for_app
}

install_dependencies(){
    sudo apt-get update && sudo apt-get -y install supervisor
}

enable_supervisor_web_interface()
{
    # enable the web gui interface
    if ( grep -Fxq "[inet_http_server]" /etc/supervisor/supervisord.conf ); then
        # if find "inet_http_server" in the supervisord.conf
        echo "Found web gui configuration."
        if ( grep "port" /etc/supervisor/supervisord.conf ); then
            echo "port found"
            sudo sed -i '/port /c\port = 127.0.0.1:9001' /etc/supervisor/supervisord.conf
        else
            # port not found
            echo "port not found"
            sudo sh -c 'echo "port = 127.0.0.1:9001" >> /etc/supervisor/supervisord.conf'
        fi

    else
        # can not find the configuration for the web app
        sudo sh -c "echo '[inet_http_server]' >> /etc/supervisor/supervisord.conf"
        sudo sh -c 'echo "port = 127.0.0.1:9001" >> /etc/supervisor/supervisord.conf'
    fi
    sudo supervisorctl reread
    sudo supervisorctl update
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
    echo "user=root" >> $CONF
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
