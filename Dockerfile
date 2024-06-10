FROM registry1.dso.mil/ironbank/opensource/moodle:4.4.0

COPY configuration/config.php /var/www/html/config.php

# RUN ls

# RUN mkdir /tmp/moodle-files
# RUN chown -R 1001:0 /tmp/moodle-files
# RUN mkdir /var/www/moodledata/lang
# RUN mkdir /var/www/html/auth/jwt
# RUN mkdir /var/www/html/local/mass_enroll
# RUN mkdir /var/www/html/course/format/flexsections
# RUN mkdir /var/www/html/local/edwiserreports

# COPY plug-ins/tool_Certificate.tgz /tmp/moodle-files/
# RUN tar -xzf /tmp/moodle-files/tool_Certificate.tgz -C /var/www/html/admin/tool/

# COPY plug-ins/coursecertificate.tgz /tmp/moodle-files/
# RUN tar -xzf /tmp/moodle-files/coursecertificate.tgz -C /var/www/html/mod/

# COPY plug-ins/logstore.tgz /tmp/moodle-files/
# RUN tar -xzf /tmp/moodle-files/logstore.tgz -C /var/www/html/admin/tool/log/store/

# COPY plug-ins/block_sharing_cart.tgz /tmp/moodle-files/
# RUN tar -xzf /tmp/moodle-files/block_sharing_cart.tgz -C /var/www/html/blocks

# COPY plug-ins/bulkenroll.tgz /tmp/moodle-files/
# RUN tar -xzf /tmp/moodle-files/bulkenroll.tgz -C /var/www/html/local

# COPY plug-ins/moodle-flex-format.tgz /tmp/moodle-files/
# RUN tar -xzf /tmp/moodle-files/moodle-flex-format.tgz --strip-components=1 -C /var/www/html/course/format/flexsections

# COPY plug-ins/moodle-jwt-auth.tar.gz /tmp/moodle-files/
# RUN tar -xzf /tmp/moodle-files/moodle-jwt-auth.tar.gz --strip-components=1 -C /var/www/html/auth/jwt

# COPY plug-ins/mass_enroll.tgz /tmp/moodle-files
# RUN tar -xzf /tmp/moodle-files/mass_enroll.tgz -C /var/www/html/local/mass_enroll

# COPY plug-ins/gchat.tgz /tmp/moodle-files
# RUN tar -xzf /tmp/moodle-files/gchat.tgz -C /var/www/html/blocks

# COPY plug-ins/multiselect.tgz /tmp/moodle-files
# RUN tar -xzf /tmp/moodle-files/multiselect.tgz -C /var/www/html/user/profile/field

# COPY language-packs/en_US.tgz /tmp/moodle-files/
# RUN tar -xzf /tmp/moodle-files/en_US.tgz -C /var/www/moodledata/lang

# COPY plug-ins/fullscreen.tgz /tmp/moodle-files
# RUN tar -xzf /tmp/moodle-files/fullscreen.tgz -C /var/www/html/lib/editor/atto/plugins/

# COPY plug-ins/benchmark.tgz /tmp/moodle-files
# RUN tar -xzf /tmp/moodle-files/benchmark.tgz -C /var/www/html/report

# COPY plug-ins/questionnaire.tgz /tmp/moodle-files/
# RUN tar -xzf /tmp/moodle-files/questionnaire.tgz -C /var/www/html/mod/

# #COPY plug-ins/edwiserreports.tgz /tmp/moodle-files
# #RUN tar -xzf /tmp/moodle-files/edwiserreports.tgz -C /var/www/html/local/edwiserreports

# #COPY plug-ins/academi_theme.tgz /tmp/moodle-files
# #RUN tar -xzf /tmp/moodle-files/academi_theme.tgz -C /var/www/html/theme

# COPY plug-ins/adaptable_theme.tgz /tmp/moodle-files
# RUN tar -xzf /tmp/moodle-files/adaptable_theme.tgz -C /var/www/html/theme

# COPY plug-ins/theme_almondb.tgz /tmp/moodle-files
# RUN tar -xzf /tmp/moodle-files/theme_almondb.tgz -C /var/www/html/theme

# COPY plug-ins/theme_moove.tgz /tmp/moodle-files
# RUN tar -xzf /tmp/moodle-files/theme_moove.tgz -C /var/www/html/theme

# COPY plug-ins/theme_snap.tgz /tmp/moodle-files
# RUN tar -xzf /tmp/moodle-files/theme_snap.tgz -C /var/www/html/theme

# #COPY plug-ins/apply.tgz /tmp/moodle-files/
# #RUN tar -xzf /tmp/moodle-files/apply.tgz -C /var/www/html/mod/

# COPY plug-ins/block_rbreport_moodle43.tgz /tmp/moodle-files
# RUN tar -xzf /tmp/moodle-files/block_rbreport_moodle43.tgz -C /var/www/html/blocks

# COPY plug-ins/block_completion.tgz /tmp/moodle-files
# RUN tar -xzf /tmp/moodle-files/block_completion.tgz -C /var/www/html/blocks

# COPY plug-ins/customcert.tgz /tmp/moodle-files
# RUN tar -xzf /tmp/moodle-files/customcert.tgz -C /var/www/html/mod
