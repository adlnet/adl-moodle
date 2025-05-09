    FROM ubuntu:latest
    RUN apt-get update && apt-get install -y cron curl
    
    # Add your script to be executed
    ADD runCron.sh /runCron.sh
    RUN chmod +x /runCron.sh
    
    # Add crontab file
    ADD crontab /etc/cron.d/mycron
    RUN chmod 0644 /etc/cron.d/mycron
    
    CMD ["cron", "-f"]
